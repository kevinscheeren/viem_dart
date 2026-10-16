import 'abi_parameter.dart';

final RegExp _arrayTypeRegExp = RegExp(r'^(.*)\[(\d*)\]$');

/// A Solidity array type's element type and, for a fixed-size array
/// (`T[k]`), its length — `null` for a dynamic array (`T[]`).
class ArrayTypeInfo {
  /// Creates an [ArrayTypeInfo] with the given [elementType] and
  /// [fixedLength] (`null` for a dynamic array).
  const ArrayTypeInfo(this.elementType, this.fixedLength);
  final String elementType;
  final int? fixedLength;
}

/// Parses [type] as an array type (`"T[]"` or `"T[k]"`), or returns `null`
/// if it isn't one.
ArrayTypeInfo? parseArrayType(String type) {
  final match = _arrayTypeRegExp.firstMatch(type);
  if (match == null) return null;
  final lengthGroup = match.group(2)!;
  return ArrayTypeInfo(
    match.group(1)!,
    lengthGroup.isEmpty ? null : int.parse(lengthGroup),
  );
}

/// Whether [param]'s type requires dynamic (offset + length) ABI encoding:
/// `string`, `bytes`, `T[]`, `T[k]` where `T` is dynamic, or a tuple with
/// any dynamic component. Everything else (`uintN`, `intN`, `address`,
/// `bool`, `bytesN`, and tuples/fixed-arrays composed entirely of such
/// types) is static.
bool isDynamicAbiType(AbiParameter param) {
  final type = param.type;
  if (type == 'string' || type == 'bytes') return true;

  final arrayInfo = parseArrayType(type);
  if (arrayInfo != null) {
    if (arrayInfo.fixedLength == null) return true;
    return isDynamicAbiType(param.copyWith(type: arrayInfo.elementType));
  }

  if (type == 'tuple') {
    return (param.components ?? const <AbiParameter>[]).any(isDynamicAbiType);
  }

  return false;
}

/// The number of bytes a *static* [param] occupies inline (32 for scalars;
/// for static tuples/fixed-arrays, the sum/product of their components').
/// Only meaningful when `isDynamicAbiType(param)` is `false`.
int staticAbiTypeSize(AbiParameter param) {
  final arrayInfo = parseArrayType(param.type);
  if (arrayInfo != null && arrayInfo.fixedLength != null) {
    return arrayInfo.fixedLength! *
        staticAbiTypeSize(param.copyWith(type: arrayInfo.elementType));
  }
  if (param.type == 'tuple') {
    final components = param.components ?? const <AbiParameter>[];
    return components.fold<int>(0, (sum, c) => sum + staticAbiTypeSize(c));
  }
  return 32;
}
