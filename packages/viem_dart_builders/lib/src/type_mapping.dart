import 'package:code_builder/code_builder.dart';
import 'package:viem_dart/abi.dart';

import 'name_utils.dart';

final RegExp _uintTypeRegExp = RegExp(r'^uint\d*$');
final RegExp _intTypeRegExp = RegExp(r'^int\d*$');
final RegExp _fixedBytesTypeRegExp = RegExp(r'^bytes\d+$');

/// Top-level helper names [TypeMapper]-generated tuple classes' `==`/
/// `hashCode` call into — see [deepEqualsHelperFunctions]'s doc comment for
/// why these are emitted as plain top-level functions rather than pulled
/// from `package:collection`.
const deepEqualsFunctionName = '_deepEquals';
const deepHashFunctionName = '_deepHash';

/// Maps Solidity ABI parameter types to Dart type [Reference]s, mirroring
/// the runtime mapping `decodeAbiParameters`/`encodeAbiParameters` already
/// use elsewhere in `viem_dart`: `uintN`/`intN` -> `BigInt`,
/// `address`/`string` -> `String`, `bool` -> `bool`, `bytes`/`bytesN` ->
/// `Uint8List`, `T[]`/`T[k]` -> `List<T>`.
///
/// The one upgrade over the runtime mapping: a `tuple` type doesn't map to
/// a positional `List<Object?>` here — each *unique* tuple shape gets its
/// own generated immutable data class (via [tupleClasses]), named after the
/// parameter/field that introduced it. This is the concrete ergonomic win
/// code generation buys over both the runtime `Contract.read(...)` API and
/// viem's own untyped JS tuple output.
///
/// Not literally `@freezed`-annotated (despite the working
/// name "tuple-to-freezed-class codegen"): a generated
/// `@freezed` class would need `build_runner` to run *again* over this
/// builder's own output to expand it, exactly the "one builder generating
/// input for another builder" anti-pattern `SharedPartBuilder`/
/// `combining_builder` exist to avoid (see `build.yaml`'s own doc
/// comment). Instead each tuple class is emitted hand-rolled, directly,
/// with the same public surface freezed would give it: a `const`
/// constructor, `copyWith`, value `==`/`hashCode`, and `toString` —
/// freezed-equivalent ergonomics without a second codegen pass.
///
/// **Import constraint**: generated code lands in a `part` file, which
/// shares its `part of` library's imports rather than declaring its own —
/// so field types this emits (`Uint8List` for `bytes`/`bytesN` fields) must
/// already be visible there. A library with a `@GenerateAbi`-annotated
/// `part` directive whose ABI has any `bytes`/`bytesN` field needs its own
/// `import 'dart:typed_data';` for the generated tuple class to compile.
class TypeMapper {
  final Map<String, String> _classNameByShape = {};
  final Map<String, Class> _classesByName = {};
  final Map<String, Method> _fromDecodedByClassName = {};

  /// The tuple data classes generated so far, in first-seen order.
  Iterable<Class> get tupleClasses => _classesByName.values;

  /// The private top-level `<class>FromDecoded` conversion functions
  /// built so far — one per tuple class that's actually been
  /// decode-converted via [convertFromDecoded] (i.e. used as some
  /// function's output, directly or nested), not one per tuple class
  /// registered overall — a tuple used only as an *input* never needs
  /// one. See [convertFromDecoded]'s doc comment for why these exist.
  Iterable<Method> get fromDecodedFunctions => _fromDecodedByClassName.values;

  /// A Dart *source expression string* that converts [rawExpr] — some
  /// already-written Dart expression evaluating to the raw, untyped value
  /// `readContract`/`decodeAbiParameters` produced for [param] (`BigInt`
  /// for `uintN`/`intN`, `String` for `address`/`string`, `bool` for
  /// `bool`, `Uint8List` for `bytes`/`bytesN`, `List<Object?>` for both
  /// arrays *and* tuples, positionally) — into the properly-typed value
  /// [dartType] declares for [param].
  ///
  /// This exists because a `tuple`-typed output doesn't just get a
  /// different static *type* here than the runtime API (a generated class
  /// instead of `List<Object?>`) — the *value* `readContract` actually
  /// returns is still the untyped positional list, since decoding happens
  /// in `viem_dart` itself (which knows nothing about generated classes).
  /// Every generated read method needs this conversion step, not just the
  /// type mapping, or a tuple-typed return would be a broken `as` cast at
  /// runtime despite compiling fine.
  String convertFromDecoded(String rawExpr, AbiParameter param) {
    final arrayInfo = parseArrayType(param.type);
    if (arrayInfo != null) {
      final elementParam = param.copyWith(type: arrayInfo.elementType);
      final elementConversion = convertFromDecoded('e', elementParam);
      return '($rawExpr as List<Object?>).map((e) => $elementConversion).toList()';
    }

    if (param.type == 'tuple') {
      final className = _tupleClassName(param);
      // Built lazily, only when a tuple type is actually decode-converted
      // (i.e. used as some function's *output*, directly or nested) —
      // not eagerly whenever the class itself is registered. A tuple used
      // only as an *input* (encoding, not decoding) never needs this
      // function; generating it unconditionally would leave real
      // generated files with an `unused_element` warning whenever a
      // struct is write-only. `putIfAbsent` still dedupes correctly for
      // shapes that ARE used as outputs from multiple call sites.
      _fromDecodedByClassName.putIfAbsent(
        className,
        () => _buildFromDecodedFunction(
          className,
          param.components ?? const <AbiParameter>[],
        ),
      );
      final fnName = _fromDecodedFunctionName(className);
      return '$fnName($rawExpr as List<Object?>)';
    }

    return '$rawExpr as ${dartType(param).symbol}';
  }

  String _fromDecodedFunctionName(String className) =>
      '_${camelCase(className)}FromDecoded';

  /// The Dart [TypeReference] for [param]'s Solidity [AbiParameter.type].
  TypeReference dartType(AbiParameter param) {
    final arrayInfo = parseArrayType(param.type);
    if (arrayInfo != null) {
      final elementParam = param.copyWith(type: arrayInfo.elementType);
      return TypeReference(
        (b) => b
          ..symbol = 'List'
          ..types.add(dartType(elementParam)),
      );
    }

    if (param.type == 'tuple') {
      return TypeReference((b) => b..symbol = _tupleClassName(param));
    }

    switch (param.type) {
      case 'address':
      case 'string':
        return TypeReference((b) => b..symbol = 'String');
      case 'bool':
        return TypeReference((b) => b..symbol = 'bool');
      case 'bytes':
        return TypeReference((b) => b..symbol = 'Uint8List');
    }

    if (_uintTypeRegExp.hasMatch(param.type) ||
        _intTypeRegExp.hasMatch(param.type)) {
      return TypeReference((b) => b..symbol = 'BigInt');
    }
    if (_fixedBytesTypeRegExp.hasMatch(param.type)) {
      return TypeReference((b) => b..symbol = 'Uint8List');
    }

    throw FormatException('Unsupported ABI type `${param.type}` for codegen.');
  }

  /// Registers (or reuses) the generated data class for a `tuple`-typed
  /// [param]'s components, returning its class name.
  String _tupleClassName(AbiParameter param) {
    final components = param.components ?? const <AbiParameter>[];
    final shape = _shapeSignature(components);

    final existing = _classNameByShape[shape];
    if (existing != null) return existing;

    final preferred = pascalCase(param.name.isEmpty ? 'Tuple' : param.name);
    var className = preferred;
    var suffix = 2;
    while (_classesByName.containsKey(className)) {
      className = '$preferred$suffix';
      suffix++;
    }

    _classNameByShape[shape] = className;
    _classesByName[className] = _buildTupleClass(className, components);
    return className;
  }

  /// The companion top-level function [convertFromDecoded] calls for a
  /// tuple type — `_classFromDecoded(List<Object?> raw)` returning
  /// `Class(field: raw[i] as FieldType, ...)` — recursing into nested
  /// tuples/arrays via [convertFromDecoded] itself.
  Method _buildFromDecodedFunction(
    String className,
    List<AbiParameter> components,
  ) {
    final fieldNames = List.generate(
      components.length,
      (i) => camelCase(
        components[i].name.isEmpty ? 'value$i' : components[i].name,
      ),
    );
    final args = List.generate(
      components.length,
      (i) =>
          '${fieldNames[i]}: ${convertFromDecoded('raw[$i]', components[i])}',
    );

    return Method(
      (m) => m
        ..name = _fromDecodedFunctionName(className)
        ..returns = refer(className)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'raw'
              ..type = refer('List<Object?>'),
          ),
        )
        ..lambda = true
        ..body = Code('$className(${args.join(', ')})'),
    );
  }

  /// A structural key identifying a tuple shape (field names + types, in
  /// order, recursively) so two components with the same shape share one
  /// generated class regardless of which parameter/function first
  /// introduced it.
  String _shapeSignature(List<AbiParameter> components) => components
      .map(
        (c) =>
            '${c.name}:${c.type}:'
            '${c.components != null ? _shapeSignature(c.components!) : ''}',
      )
      .join(',');

  Class _buildTupleClass(String className, List<AbiParameter> components) {
    final fieldNames = List.generate(
      components.length,
      (i) => camelCase(
        components[i].name.isEmpty ? 'value$i' : components[i].name,
      ),
    );
    final fieldTypes = components.map(dartType).toList();

    return Class(
      (b) => b
        ..name = className
        ..docs.add(
          "/// Generated data class for a `tuple` ABI shape (see `TypeMapper`).",
        )
        ..constructors.add(
          Constructor(
            (c) => c
              ..constant = true
              ..optionalParameters.addAll(
                fieldNames.map(
                  (f) => Parameter(
                    (p) => p
                      ..name = f
                      ..named = true
                      ..required = true
                      ..toThis = true,
                  ),
                ),
              ),
          ),
        )
        ..fields.addAll(
          List.generate(
            components.length,
            (i) => Field(
              (f) => f
                ..name = fieldNames[i]
                ..type = fieldTypes[i]
                ..modifier = FieldModifier.final$,
            ),
          ),
        )
        ..methods.add(_copyWithMethod(className, fieldNames, fieldTypes))
        ..methods.add(_equalsMethod(className, fieldNames))
        ..methods.add(_hashCodeMethod(fieldNames))
        ..methods.add(_toStringMethod(className, fieldNames)),
    );
  }

  /// `copyWith`'s params are the field types with [TypeReference.isNullable]
  /// set — whoever renders this (`DartEmitter`) must be constructed with
  /// `useNullSafetySyntax: true`, or every `?` here is silently dropped
  /// (that flag defaults to `false` on `DartEmitter` itself).
  Method _copyWithMethod(
    String className,
    List<String> fieldNames,
    List<TypeReference> fieldTypes,
  ) => Method(
    (m) => m
      ..name = 'copyWith'
      ..returns = refer(className)
      ..optionalParameters.addAll(
        List.generate(
          fieldNames.length,
          (i) => Parameter(
            (p) => p
              ..name = fieldNames[i]
              ..named = true
              ..type = fieldTypes[i].rebuild((t) => t.isNullable = true),
          ),
        ),
      )
      ..body = Code(
        'return $className('
        '${fieldNames.map((f) => '$f: $f ?? this.$f').join(', ')});',
      ),
  );

  Method _equalsMethod(String className, List<String> fieldNames) => Method(
    (m) => m
      ..name = 'operator =='
      ..returns = refer('bool')
      ..annotations.add(refer('override'))
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..name = 'other'
            ..type = refer('Object'),
        ),
      )
      ..body = Code(
        'return identical(this, other) || '
        '(other is $className${fieldNames.isEmpty ? '' : ' && '}'
        '${fieldNames.map((f) => '$deepEqualsFunctionName(other.$f, $f)').join(' && ')});',
      ),
  );

  Method _hashCodeMethod(List<String> fieldNames) => Method(
    (m) => m
      ..name = 'hashCode'
      ..type = MethodType.getter
      ..returns = refer('int')
      ..annotations.add(refer('override'))
      ..body = Code(
        fieldNames.isEmpty
            ? 'return 0;'
            : 'return Object.hashAll('
                  '[${fieldNames.map((f) => '$deepHashFunctionName($f)').join(', ')}]);',
      ),
  );

  Method _toStringMethod(String className, List<String> fieldNames) => Method(
    (m) => m
      ..name = 'toString'
      ..returns = refer('String')
      ..annotations.add(refer('override'))
      ..body = Code(
        "return '$className(${fieldNames.map((f) => '$f: \$$f').join(', ')})';",
      ),
  );
}

/// `dart:core`-only deep-equality/hash helpers for [TypeMapper]-generated
/// tuple classes' `==`/`hashCode` — emitted once per output file (only
/// when [TypeMapper.tupleClasses] is non-empty) rather than pulled from
/// `package:collection`, because a `part` file can't declare its own
/// imports (see [TypeMapper]'s doc comment) and there's no way to
/// guarantee the annotated library already imports `package:collection`.
/// Handles nested `List`/`Uint8List` fields (default `List`/`Uint8List`
/// `==` is identity-based, not element-wise) by recursing; falls back to
/// plain `==`/`hashCode` for everything else (`BigInt`, `String`, `bool`,
/// and the generated tuple classes themselves, which already implement
/// value equality).
List<Spec> deepEqualsHelperFunctions() => [
  Method(
    (m) => m
      ..name = deepEqualsFunctionName
      ..returns = refer('bool')
      ..requiredParameters.addAll([
        Parameter(
          (p) => p
            ..name = 'a'
            ..type = refer('Object?'),
        ),
        Parameter(
          (p) => p
            ..name = 'b'
            ..type = refer('Object?'),
        ),
      ])
      ..body = Code('''
if (identical(a, b)) return true;
if (a is List && b is List) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (!$deepEqualsFunctionName(a[i], b[i])) return false;
  }
  return true;
}
return a == b;
'''),
  ),
  Method(
    (m) => m
      ..name = deepHashFunctionName
      ..returns = refer('int')
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..name = 'value'
            ..type = refer('Object?'),
        ),
      )
      ..body = Code('''
if (value is List) {
  return Object.hashAll(value.map($deepHashFunctionName));
}
return value.hashCode;
'''),
  ),
];
