import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/read_contract_builder.dart';
import 'package:viem_dart_builders/src/type_mapping.dart';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

String _emit(Spec spec) =>
    _formatter.format('${spec.accept(DartEmitter(useNullSafetySyntax: true))}');

AbiFunction _fn(
  String name,
  List<AbiParameter> inputs,
  List<AbiParameter> outputs, {
  String stateMutability = 'view',
}) => AbiFunction(
  name: name,
  inputs: inputs,
  outputs: outputs,
  stateMutability: stateMutability,
);

AbiParameter _p(
  String name,
  String type, {
  List<AbiParameter>? components,
  bool? indexed,
}) => AbiParameter(
  name: name,
  type: type,
  components: components,
  indexed: indexed,
);

void main() {
  test('only view/pure functions become read methods', () {
    final mapper = TypeMapper();
    final functions = [
      _fn('balanceOf', [_p('owner', 'address')], [_p('', 'uint256')]),
      _fn(
        'transfer',
        [_p('to', 'address'), _p('amount', 'uint256')],
        [_p('', 'bool')],
        stateMutability: 'nonpayable',
      ),
      _fn('totalSupply', [], [_p('', 'uint256')], stateMutability: 'pure'),
    ];

    final result = buildReadContractClass(
      className: 'Erc20',
      functions: functions,
      events: const [],
      typeMapper: mapper,
    );

    expect(result.contractClass.methods.map((m) => m.name), [
      'balanceOf',
      'totalSupply',
    ]);
  });

  test('holds a PublicClient and address, both required', () {
    final result = buildReadContractClass(
      className: 'Erc20',
      functions: [
        _fn('balanceOf', [_p('owner', 'address')], [_p('', 'uint256')]),
      ],
      events: const [],
      typeMapper: TypeMapper(),
    );
    final contractClass = result.contractClass;

    expect(contractClass.name, 'Erc20Contract');
    expect(contractClass.fields.map((f) => f.name), ['client', 'address']);
    final ctor = contractClass.constructors.single;
    expect(ctor.constant, isTrue);
    expect(ctor.optionalParameters.every((p) => p.required), isTrue);
  });

  test('a single-output function returns the mapped type directly', () {
    final mapper = TypeMapper();
    final method = buildReadMethod(
      _fn('balanceOf', [_p('owner', 'address')], [_p('', 'uint256')]),
      'balanceOf',
      mapper,
    );
    final source = _emit(method);

    expect(source, contains('Future<BigInt> balanceOf({'));
    expect(source, contains('required String owner,'));
    expect(source, contains('BigInt? blockNumber,'));
    expect(source, contains("String blockTag = 'latest',"));
    expect(source, contains('final raw = await client.readContract('));
    expect(source, contains('return raw as BigInt;'));
  });

  test('a zero-output function returns Future<void>', () {
    final method = buildReadMethod(_fn('pause', [], []), 'pause', TypeMapper());
    final source = _emit(method);
    expect(source, contains('Future<void> pause('));
    expect(source, isNot(contains('return')));
  });

  test('a multi-output function returns a named record', () {
    final method = buildReadMethod(
      _fn('getReserves', [], [
        _p('reserve0', 'uint112'),
        _p('reserve1', 'uint112'),
        _p('blockTimestampLast', 'uint32'),
      ]),
      'getReserves',
      TypeMapper(),
    );
    final source = _emit(method);

    expect(
      source,
      contains(
        'Future<({BigInt reserve0, BigInt reserve1, BigInt blockTimestampLast})>',
      ),
    );
    expect(source, contains('getReserves('));
    expect(source, contains('final raw = await client.readContract('));
    expect(source, contains('as List<Object?>;'));
    expect(source, contains('reserve0: raw[0] as BigInt,'));
    expect(source, contains('reserve1: raw[1] as BigInt,'));
    expect(source, contains('blockTimestampLast: raw[2] as BigInt,'));
  });

  test('unnamed multi-output fields get synthesized record field names', () {
    final method = buildReadMethod(
      _fn('pair', [], [_p('', 'address'), _p('', 'uint256')]),
      'pair',
      TypeMapper(),
    );
    final source = _emit(method);
    expect(source, contains('({String output0, BigInt output1})'));
  });

  test(
    'a tuple-typed output is converted via the class\'s FromDecoded function',
    () {
      final mapper = TypeMapper();
      final method = buildReadMethod(
        _fn(
          'getPosition',
          [_p('id', 'uint256')],
          [
            _p(
              'position',
              'tuple',
              components: [_p('owner', 'address'), _p('amount', 'uint256')],
            ),
          ],
        ),
        'getPosition',
        mapper,
      );
      final source = _emit(method);

      expect(source, contains('Future<Position> getPosition({'));
      expect(
        source,
        contains('return _positionFromDecoded(raw as List<Object?>);'),
      );
      expect(mapper.tupleClasses.map((c) => c.name), ['Position']);
    },
  );

  test('overloaded function names get disambiguated method names', () {
    final mapper = TypeMapper();
    final result = buildReadContractClass(
      className: 'Multicall',
      functions: [
        _fn('aggregate', [_p('a', 'address')], [_p('', 'bool')]),
        _fn(
          'aggregate',
          [_p('a', 'address'), _p('b', 'uint256')],
          [_p('', 'bool')],
        ),
      ],
      events: const [],
      typeMapper: mapper,
    );
    expect(result.contractClass.methods.map((m) => m.name), [
      'aggregate',
      'aggregate2',
    ]);
  });

  test(
    'the full generated ReadContract class + tuple + event support is valid, analyzable Dart',
    () async {
      final mapper = TypeMapper();
      final functions = [
        _fn('balanceOf', [_p('owner', 'address')], [_p('', 'uint256')]),
        _fn('getReserves', [], [
          _p('reserve0', 'uint112'),
          _p('reserve1', 'uint112'),
        ]),
        _fn(
          'getPosition',
          [_p('id', 'uint256')],
          [
            _p(
              'position',
              'tuple',
              components: [
                _p('owner', 'address'),
                _p('amount', 'uint256'),
                _p('tags', 'bytes32[]'),
              ],
            ),
          ],
        ),
      ];
      final events = [
        AbiEvent(
          name: 'Transfer',
          inputs: [
            _p('from', 'address', indexed: true),
            _p('to', 'address', indexed: true),
            _p('value', 'uint256'),
          ],
        ),
      ];
      final readResult = buildReadContractClass(
        className: 'Demo',
        functions: functions,
        events: events,
        typeMapper: mapper,
      );

      final library = Library(
        (b) => b
          ..directives.addAll([
            Directive.import('dart:typed_data'),
            Directive.import('package:viem_dart/viem_dart.dart'),
            Directive.import('package:viem_dart/abi.dart'),
          ])
          ..body.addAll(mapper.tupleClasses)
          ..body.addAll(mapper.fromDecodedFunctions)
          ..body.addAll(deepEqualsHelperFunctions())
          ..body.addAll(readResult.eventClasses)
          ..body.add(readResult.contractClass),
      );
      final source =
          DartFormatter(
            languageVersion: DartFormatter.latestLanguageVersion,
          ).format(
            '${library.accept(DartEmitter.scoped(useNullSafetySyntax: true))}',
          );

      // Written *inside* this package's own tree (not a system temp dir)
      // deliberately: `package:viem_dart/...` imports in `source` only
      // resolve against a real `.dart_tool/package_config.json`, and this
      // package's own is already set up with exactly the dependencies
      // `source` needs — a bare system-temp file has no package context at
      // all. Cleaned up via `addTearDown` regardless of test outcome.
      // Subdirectory named per test file — `dart test` runs different
      // test files concurrently, and a shared probe path raced with
      // write_contract_builder_test.dart's own probe in practice.
      final probeDir = Directory('test/.generated_probe/read_contract');
      await probeDir.create(recursive: true);
      addTearDown(() => probeDir.delete(recursive: true));
      final file = File('${probeDir.path}/generated_probe.dart');
      await file.writeAsString(source);

      final result = await Process.run('dart', [
        'analyze',
        '--fatal-infos',
        file.path,
      ]);
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
