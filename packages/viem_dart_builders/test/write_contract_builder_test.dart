import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/read_contract_builder.dart';
import 'package:viem_dart_builders/src/type_mapping.dart';
import 'package:viem_dart_builders/src/write_contract_builder.dart';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

// A generated write method is always a lambda (`=> expr`) — but
// `DartEmitter` only appends the trailing `;` a lambda *method* needs when
// visiting it as a class member (`Class`'s own emission logic adds it);
// emitting a bare `Method` in isolation via `.accept()` directly, as every
// other `_emit` helper in this test suite does, silently produces
// unterminated source. Wrap in a throwaway class here so this helper
// matches how these methods are actually always embedded for real.
String _emit(Method method) => _formatter.format(
  '${Class((b) => b
    ..name = '_Probe'
    ..methods.add(method)).accept(DartEmitter(useNullSafetySyntax: true))}',
);

AbiFunction _fn(
  String name,
  List<AbiParameter> inputs,
  List<AbiParameter> outputs, {
  String stateMutability = 'nonpayable',
}) => AbiFunction(
  name: name,
  inputs: inputs,
  outputs: outputs,
  stateMutability: stateMutability,
);

AbiParameter _p(String name, String type, {List<AbiParameter>? components}) =>
    AbiParameter(name: name, type: type, components: components);

void main() {
  test('only payable/nonpayable functions become write methods', () {
    final functions = [
      _fn(
        'transfer',
        [_p('to', 'address'), _p('amount', 'uint256')],
        [_p('', 'bool')],
      ),
      _fn('deposit', [], [], stateMutability: 'payable'),
      _fn(
        'balanceOf',
        [_p('owner', 'address')],
        [_p('', 'uint256')],
        stateMutability: 'view',
      ),
    ];

    final walletClass = buildWriteContractClass(
      className: 'Erc20',
      functions: functions,
      typeMapper: TypeMapper(),
    );

    // The generator's own class always has the `_walletClient` getter
    // plus one method per write function.
    expect(
      walletClass.methods.map((m) => m.name),
      containsAll(['transfer', 'deposit']),
    );
    expect(
      walletClass.methods.map((m) => m.name),
      isNot(contains('balanceOf')),
    );
  });

  test('extends <className>Contract and requires a WalletClient', () {
    final walletClass = buildWriteContractClass(
      className: 'Erc20',
      functions: [
        _fn(
          'transfer',
          [_p('to', 'address'), _p('amount', 'uint256')],
          [_p('', 'bool')],
        ),
      ],
      typeMapper: TypeMapper(),
    );

    expect(walletClass.name, 'Erc20WalletContract');
    expect(walletClass.extend?.symbol, 'Erc20Contract');
    final ctor = walletClass.constructors.single;
    final clientParam = ctor.optionalParameters.firstWhere(
      (p) => p.name == 'client',
    );
    expect(clientParam.type?.symbol, 'WalletClient');
    expect(clientParam.required, isTrue);
  });

  test('a write method returns Future<String> (the tx hash)', () {
    final method = buildWriteMethod(
      _fn(
        'transfer',
        [_p('to', 'address'), _p('amount', 'uint256')],
        [_p('', 'bool')],
      ),
      'transfer',
      TypeMapper(),
    );
    final source = _emit(method);

    expect(source, contains('Future<String> transfer({'));
    expect(source, contains('required String to,'));
    expect(source, contains('required BigInt amount,'));
    expect(source, contains('String? from,'));
    expect(source, contains('BigInt? value,'));
    expect(source, contains('BigInt? gas,'));
    expect(source, contains('BigInt? maxFeePerGas,'));
    expect(source, contains('BigInt? maxPriorityFeePerGas,'));
    expect(source, contains('int? nonce,'));
    expect(source, contains('_walletClient.writeContract('));
    expect(source, contains('args: [to, amount],'));
  });

  test('overloaded function names get disambiguated method names', () {
    final walletClass = buildWriteContractClass(
      className: 'Multisend',
      functions: [
        _fn('send', [_p('to', 'address')], []),
        _fn('send', [_p('to', 'address'), _p('amount', 'uint256')], []),
      ],
      typeMapper: TypeMapper(),
    );
    expect(
      walletClass.methods.map((m) => m.name),
      containsAll(['send', 'send2']),
    );
  });

  test(
    'the full generated Contract + WalletContract pair is valid, analyzable Dart',
    () async {
      final mapper = TypeMapper();
      final functions = [
        _fn(
          'balanceOf',
          [_p('owner', 'address')],
          [_p('', 'uint256')],
          stateMutability: 'view',
        ),
        _fn(
          'transfer',
          [_p('to', 'address'), _p('amount', 'uint256')],
          [_p('', 'bool')],
        ),
        _fn(
          'depositPosition',
          [
            _p(
              'position',
              'tuple',
              components: [_p('owner', 'address'), _p('amount', 'uint256')],
            ),
          ],
          [],
          stateMutability: 'payable',
        ),
      ];
      final readResult = buildReadContractClass(
        className: 'Demo',
        functions: functions,
        events: const [],
        typeMapper: mapper,
      );
      final walletClass = buildWriteContractClass(
        className: 'Demo',
        functions: functions,
        typeMapper: mapper,
      );

      final library = Library(
        (b) => b
          ..directives.addAll([
            // No dart:typed_data here — this fixture has no bytes/bytesN
            // field, and dart analyze (correctly) flags an unused import.
            Directive.import('package:viem_dart/viem_dart.dart'),
            Directive.import('package:viem_dart/abi.dart'),
          ])
          ..body.addAll(mapper.tupleClasses)
          ..body.addAll(mapper.fromDecodedFunctions)
          ..body.addAll(deepEqualsHelperFunctions())
          ..body.addAll(readResult.eventClasses)
          ..body.add(readResult.contractClass)
          ..body.add(walletClass),
      );
      final source =
          DartFormatter(
            languageVersion: DartFormatter.latestLanguageVersion,
          ).format(
            '${library.accept(DartEmitter.scoped(useNullSafetySyntax: true))}',
          );

      // A dedicated subdirectory per test file (not shared with
      // read_contract_builder_test.dart's own probe dir) — `dart test` runs
      // different test files concurrently in separate isolates, and a
      // shared path race between two tests' create/write/delete caused a
      // real, observed `PathNotFoundException` here.
      final probeDir = Directory('test/.generated_probe/write_contract');
      await probeDir.create(recursive: true);
      addTearDown(() => probeDir.delete(recursive: true));
      final file = File('${probeDir.path}/generated_wallet_probe.dart');
      await file.writeAsString(source);

      // Plain `dart analyze` (not --fatal-infos, unlike this repo's own CI
      // gate): an info-level `use_super_parameters` suggestion here is a
      // real, correct observation from the analyzer, but not something the
      // generator can act on — `client`'s type is deliberately narrowed
      // from `PublicClient` to `WalletClient` versus the super
      // constructor's declared param, which is incompatible with Dart's
      // `super.field` shorthand (it always takes the super param's own
      // declared type). This test cares whether generated code *compiles*,
      // not whether it satisfies this repo's own especially strict lint
      // config — a real consumer's analysis_options.yaml is theirs to set.
      final result = await Process.run('dart', ['analyze', file.path]);
      expect(
        result.exitCode,
        0,
        reason:
            'Generated source failed `dart analyze`:\n$source\n\n'
            '${result.stdout}\n${result.stderr}',
      );
    },
  );
}
