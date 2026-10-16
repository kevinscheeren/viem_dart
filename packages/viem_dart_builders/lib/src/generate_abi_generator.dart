import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/codegen.dart';

import 'name_utils.dart';
import 'read_contract_builder.dart';
import 'type_mapping.dart';
import 'write_contract_builder.dart';

/// Generates `<Name>Contract`/`<Name>WalletContract` typed bindings for
/// each `@GenerateAbi`-annotated `part` directive in a library.
///
/// Resolves [GenerateAbi.abiPath] relative to the annotated library's own
/// package, loads and parses the ABI JSON via `viem_dart`'s own
/// [AbiItem.fromJson], then assembles (via a shared [TypeMapper]
/// so tuple/event classes dedupe across the whole ABI):
/// - `<baseName>Contract` — one typed method per `view`/`pure` function
///   plus `get<Event>Events`/`watch<Event>Event` per ABI event.
/// - `<baseName>WalletContract extends <baseName>Contract` — one typed
///   method per `payable`/`nonpayable` function — only emitted if
///   the ABI actually has any (an ABI with no state-changing functions,
///   e.g. a pure view/query contract, has no use for a wallet-typed
///   class).
/// - Every tuple/struct data class ([TypeMapper.tupleClasses]) and typed
///   event-data class the above reference, plus the `_deepEquals`/
///   `_deepHash` helpers ([deepEqualsHelperFunctions]) — only when at
///   least one tuple class was actually generated.
class GenerateAbiGenerator extends GeneratorForAnnotation<GenerateAbi> {
  // `@GenerateAbi` annotates a `part 'foo.g.dart';` directive, not a Dart
  // element (class/function/variable) — so the hook to implement is
  // `generateForAnnotatedDirective` (source_gen's directive-annotation
  // path, covering PartInclude/LibraryImport/LibraryExport), not the more
  // commonly-overridden `generateForAnnotatedElement`.
  @override
  Future<String> generateForAnnotatedDirective(
    ElementDirective directive,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final abiPath = annotation.read('abiPath').stringValue;
    final classNameOverride = annotation.peek('className')?.stringValue;
    final baseName = classNameOverride ?? classNameFromAbiPath(abiPath);

    final abiItems = await loadAbiItems(buildStep, abiPath);
    return generateContractSource(baseName, abiItems);
  }
}

/// The actual codegen logic — everything after [GenerateAbi.abiPath] has
/// already been resolved to parsed [AbiItem]s. Deliberately a plain,
/// synchronous, `BuildStep`-free function (not a method on
/// [GenerateAbiGenerator] itself): lets the golden-file tests call
/// straight into the real codegen path with a fixture `List<AbiItem>`,
/// without any of `GeneratorForAnnotation`'s directive/annotation
/// resolution machinery — which is exactly the machinery that Stack
/// Overflows under `build_test`'s mock resolver for a real cross-package
/// annotation (see `generate_abi_generator_test.dart`'s doc comment).
String generateContractSource(String baseName, List<AbiItem> abiItems) {
  final functions = abiItems.whereType<AbiFunction>().toList();
  final events = abiItems.whereType<AbiEvent>().toList();

  final mapper = TypeMapper();
  final readResult = buildReadContractClass(
    className: baseName,
    functions: functions,
    events: events,
    typeMapper: mapper,
  );
  final hasWriteFunctions = functions.any(
    (f) => f.stateMutability == 'payable' || f.stateMutability == 'nonpayable',
  );
  final walletClass = hasWriteFunctions
      ? buildWriteContractClass(
          className: baseName,
          functions: functions,
          typeMapper: mapper,
        )
      : null;

  // Event classes' own `==`/`hashCode` call `_deepEquals`/`_deepHash` too
  // (see `event_methods_builder.dart`'s `_equalsMethod`/`_hashCodeMethod`)
  // — the helpers are needed whenever *either* tuple classes or event
  // classes exist, not just for tuples. Missing the event-classes half of
  // this condition was a real bug caught by generating this exact file
  // against a real ABI (WETH9's) for the cli_example proof: an
  // events-only, tuple-free ABI compiled to `_deepEquals`/`_deepHash`
  // calls with no definition in scope.
  final needsDeepEqualsHelpers =
      mapper.tupleClasses.isNotEmpty || readResult.eventClasses.isNotEmpty;
  final specs = <Spec>[
    ...mapper.tupleClasses,
    ...mapper.fromDecodedFunctions,
    if (needsDeepEqualsHelpers) ...deepEqualsHelperFunctions(),
    ...readResult.eventClasses,
    readResult.contractClass,
    ?walletClass,
  ];

  final emitter = DartEmitter(useNullSafetySyntax: true);
  return specs.map((s) => s.accept(emitter).toString()).join('\n\n');
}

/// Resolves [abiPath] relative to the package that owns [buildStep]'s
/// input (the library the `@GenerateAbi` annotation lives in), reads it,
/// and parses it as a Solidity ABI JSON array via [AbiItem.fromJson] —
/// the same parser `package:viem_dart` itself uses everywhere else, so an
/// ABI JSON file valid for the runtime `Contract`/`getContract()` API is
/// automatically valid here too.
Future<List<AbiItem>> loadAbiItems(BuildStep buildStep, String abiPath) async {
  final assetId = AssetId(buildStep.inputId.package, abiPath);
  final raw = await buildStep.readAsString(assetId);
  final json = jsonDecode(raw);
  if (json is! List) {
    throw InvalidGenerationSourceError(
      'ABI JSON at `$abiPath` must be a JSON array of ABI item objects, '
      'got ${json.runtimeType}.',
    );
  }
  return json
      .map((item) => AbiItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
