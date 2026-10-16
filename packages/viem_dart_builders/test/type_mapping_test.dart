import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/type_mapping.dart';

final _formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

// `useNullSafetySyntax` defaults to `false` on `DartEmitter` (code_builder
// kept the old default for backwards compat even though null safety has
// been the Dart default for years) — omitting it silently drops every `?`
// from a nullable type, which `copyWith`'s optional params need. Always
// pass it explicitly, here and in the real generator.
String _emit(Spec spec) =>
    _formatter.format('${spec.accept(DartEmitter(useNullSafetySyntax: true))}');

AbiParameter _param(
  String name,
  String type, {
  List<AbiParameter>? components,
}) => AbiParameter(name: name, type: type, components: components);

void main() {
  group('scalar/array type mapping', () {
    final mapper = TypeMapper();

    test('uintN/intN -> BigInt', () {
      expect(mapper.dartType(_param('a', 'uint256')).symbol, 'BigInt');
      expect(mapper.dartType(_param('a', 'uint8')).symbol, 'BigInt');
      expect(mapper.dartType(_param('a', 'int256')).symbol, 'BigInt');
    });

    test('address/string -> String', () {
      expect(mapper.dartType(_param('a', 'address')).symbol, 'String');
      expect(mapper.dartType(_param('a', 'string')).symbol, 'String');
    });

    test('bool -> bool', () {
      expect(mapper.dartType(_param('a', 'bool')).symbol, 'bool');
    });

    test('bytes/bytesN -> Uint8List', () {
      expect(mapper.dartType(_param('a', 'bytes')).symbol, 'Uint8List');
      expect(mapper.dartType(_param('a', 'bytes32')).symbol, 'Uint8List');
    });

    test('T[] and T[k] -> List<T>, recursively', () {
      final dynamicArray = mapper.dartType(_param('a', 'uint256[]'));
      expect(dynamicArray.symbol, 'List');
      expect(dynamicArray.types.single.symbol, 'BigInt');

      final fixedArray = mapper.dartType(_param('a', 'address[3]'));
      expect(fixedArray.symbol, 'List');
      expect(fixedArray.types.single.symbol, 'String');

      final nested = mapper.dartType(_param('a', 'uint256[][]'));
      expect(nested.symbol, 'List');
      final inner = nested.types.single as TypeReference;
      expect(inner.symbol, 'List');
      expect(inner.types.single.symbol, 'BigInt');
    });

    test('an unsupported type throws FormatException', () {
      expect(
        () => mapper.dartType(_param('a', 'function')),
        throwsFormatException,
      );
    });
  });

  group('tuple-to-class mapping', () {
    test('a tuple parameter maps to a named generated class', () {
      final mapper = TypeMapper();
      final type = mapper.dartType(
        _param(
          'position',
          'tuple',
          components: [_param('owner', 'address'), _param('amount', 'uint256')],
        ),
      );

      expect(type.symbol, 'Position');
      expect(mapper.tupleClasses, hasLength(1));
      expect(mapper.tupleClasses.single.name, 'Position');
    });

    test('two components with the same shape share one generated class', () {
      final mapper = TypeMapper();
      final shape = [_param('owner', 'address'), _param('amount', 'uint256')];

      final a = mapper.dartType(_param('deposit', 'tuple', components: shape));
      final b = mapper.dartType(
        _param('withdrawal', 'tuple', components: shape),
      );

      // Same field names+types -> same shape signature -> reused class,
      // named after whichever parameter registered it first.
      expect(a.symbol, b.symbol);
      expect(mapper.tupleClasses, hasLength(1));
    });

    test(
      'same preferred name but different shape gets a disambiguated class',
      () {
        final mapper = TypeMapper();
        mapper.dartType(
          _param('info', 'tuple', components: [_param('a', 'address')]),
        );
        mapper.dartType(
          _param('info', 'tuple', components: [_param('b', 'uint256')]),
        );

        expect(mapper.tupleClasses.map((c) => c.name), ['Info', 'Info2']);
      },
    );

    test('an unnamed tuple parameter falls back to a generic class name', () {
      final mapper = TypeMapper();
      final type = mapper.dartType(
        _param('', 'tuple', components: [_param('a', 'address')]),
      );
      expect(type.symbol, 'Tuple');
    });

    test('nested tuple components are supported', () {
      final mapper = TypeMapper();
      final type = mapper.dartType(
        _param(
          'order',
          'tuple',
          components: [
            _param('trader', 'address'),
            _param(
              'fill',
              'tuple',
              components: [
                _param('amount', 'uint256'),
                _param('price', 'uint256'),
              ],
            ),
          ],
        ),
      );
      expect(type.symbol, 'Order');
      expect(mapper.tupleClasses.map((c) => c.name), ['Fill', 'Order']);
    });
  });

  group('generated tuple class shape', () {
    test(
      'emits a const constructor, fields, copyWith, ==, hashCode, toString',
      () {
        final mapper = TypeMapper();
        mapper.dartType(
          _param(
            'position',
            'tuple',
            components: [
              _param('owner', 'address'),
              _param('amount', 'uint256'),
            ],
          ),
        );
        final source = _emit(mapper.tupleClasses.single);

        expect(source, contains('class Position'));
        expect(
          source,
          contains(
            'const Position({required this.owner, required this.amount})',
          ),
        );
        expect(source, contains('final String owner;'));
        expect(source, contains('final BigInt amount;'));
        expect(source, contains('Position copyWith('));
        expect(source, contains('bool operator ==('));
        expect(source, contains('int get hashCode'));
        expect(source, contains('String toString()'));
      },
    );

    test(
      'the full generated output (classes + helpers) is valid, analyzable Dart',
      () async {
        final mapper = TypeMapper();
        mapper.dartType(
          _param(
            'position',
            'tuple',
            components: [
              _param('owner', 'address'),
              _param('amount', 'uint256'),
              _param('tags', 'bytes32[]'),
            ],
          ),
        );

        final library = Library(
          (b) => b
            ..directives.add(Directive.import('dart:typed_data'))
            ..body.addAll(mapper.tupleClasses)
            ..body.addAll(deepEqualsHelperFunctions()),
        );
        final source =
            DartFormatter(
              languageVersion: DartFormatter.latestLanguageVersion,
            ).format(
              '${library.accept(DartEmitter.scoped(useNullSafetySyntax: true))}',
            );

        final tempDir = await Directory.systemTemp.createTemp(
          'viem_dart_builders_type_mapping_test_',
        );
        addTearDown(() => tempDir.delete(recursive: true));
        final file = File('${tempDir.path}/generated_probe.dart');
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
  });
}
