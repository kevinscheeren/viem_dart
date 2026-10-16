import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/generate_abi_generator.dart';

/// Golden-file coverage for the real, fully-wired `@GenerateAbi` codegen
/// path — a minimal ERC-20 fragment (`balanceOf`, `transfer`,
/// `Transfer`) through
/// [generateContractSource], diffed against a checked-in golden file.
///
/// Calls [generateContractSource] directly rather than going through
/// `build_test`'s `testBuilder` harness — the usual pattern, and how `json_serializable`/`freezed` themselves are tested.
/// That harness genuinely Stack Overflows resolving a real cross-package
/// `@GenerateAbi` annotation in this analyzer/source_gen/build_test
/// version combination (isolated with a minimal repro outside this repo,
/// confirmed not a bug in this code — see
/// `generate_abi_generator_test.dart`'s doc comment). [generateContractSource] is the exact
/// same codegen logic `GenerateAbiGenerator.generateForAnnotatedDirective`
/// calls once it's resolved the annotation — it was extracted specifically
/// so tests could reach it directly. `examples/cli_example`'s real,
/// committed `lib/weth.g.dart` (generated via a real `dart run
/// build_runner build`, not a test double) is the proof that
/// the annotation-resolution half — the part this test *doesn't* cover —
/// also genuinely works end-to-end.
void main() {
  test(
    'matches the checked-in golden file for a minimal ERC-20 fragment',
    () async {
      final fixtureJson =
          jsonDecode(
                await File('test/golden/erc20_fragment.json').readAsString(),
              )
              as List;
      final abiItems = fixtureJson
          .map((e) => AbiItem.fromJson(e as Map<String, dynamic>))
          .toList();

      final source = generateContractSource('Erc20', abiItems);
      final formatted = DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      ).format(source);

      final golden = await File(
        'test/golden/erc20.g.dart.golden',
      ).readAsString();
      expect(
        formatted,
        golden,
        reason:
            'Generator output drifted from the checked-in golden file. If '
            'this is an intentional change, regenerate it via:\n'
            '  dart run tool/regenerate_golden.dart > test/golden/erc20.g.dart.golden\n'
            'and review the diff before committing — don\'t just silence this test.',
      );
    },
  );

  test(
    'the golden output, wrapped with the imports a real consumer needs, is valid analyzable Dart',
    () async {
      final fixtureJson =
          jsonDecode(
                await File('test/golden/erc20_fragment.json').readAsString(),
              )
              as List;
      final abiItems = fixtureJson
          .map((e) => AbiItem.fromJson(e as Map<String, dynamic>))
          .toList();
      final source = generateContractSource('Erc20', abiItems);

      // What a real consuming library (e.g. `erc20.dart`) must itself
      // import for a generated `erc20.g.dart` part to compile — see
      // `GenerateAbi`'s own doc comment for the same requirement.
      final wrapped =
          DartFormatter(
            languageVersion: DartFormatter.latestLanguageVersion,
          ).format('''
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/viem_dart.dart';

$source
''');

      final probeDir = Directory(
        'test/.generated_probe/generate_abi_generator',
      );
      await probeDir.create(recursive: true);
      addTearDown(() => probeDir.delete(recursive: true));
      final file = File('${probeDir.path}/generated_full_pipeline_probe.dart');
      await file.writeAsString(wrapped);

      // Plain `dart analyze` (not --fatal-infos, unlike this repo's own
      // CI gate): this fixture has a write function, so
      // `<Name>WalletContract`'s constructor hits the same
      // `use_super_parameters` info-level suggestion documented in
      // write_contract_builder_test.dart — real, but not actionable here
      // (the `client` param's type is deliberately narrowed from
      // `PublicClient`, incompatible with Dart's `super.field` shorthand).
      final result = await Process.run('dart', ['analyze', file.path]);
      expect(
        result.exitCode,
        0,
        reason:
            'Generated source failed `dart analyze`:\n$wrapped\n\n'
            '${result.stdout}\n${result.stderr}',
      );
    },
  );
}
