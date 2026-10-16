import 'dart:convert';
import 'dart:typed_data';

import '../utils/address.dart';
import '../utils/hex.dart';
import 'abi_parameter.dart';
import 'abi_type.dart';

final RegExp _uintTypeRegExp = RegExp(r'^uint\d*$');
final RegExp _intTypeRegExp = RegExp(r'^int\d*$');
final RegExp _fixedBytesTypeRegExp = RegExp(r'^bytes(\d+)$');

/// Decodes ABI-encoded [data] against [params] — the inverse of
/// `encodeAbiParameters`. Returns one Dart value per parameter, positionally
/// (`BigInt` for `uintN`/`intN`, `String` for `address`, `bool` for `bool`,
/// `Uint8List` for `bytes`/`bytesN`, `String` for `string`, `List<Object?>`
/// for arrays, and `List<Object?>` — one entry per component, in order —
/// for tuples).
List<Object?> decodeAbiParameters(List<AbiParameter> params, Uint8List data) =>
    _decodeSequence(params, data, 0);

List<Object?> _decodeSequence(
  List<AbiParameter> params,
  Uint8List data,
  int baseOffset,
) {
  final values = <Object?>[];
  var headCursor = 0;
  for (final param in params) {
    if (isDynamicAbiType(param)) {
      final relativeOffset = _readUint(data, baseOffset + headCursor).toInt();
      values.add(_decodeValue(param, data, baseOffset + relativeOffset));
      headCursor += 32;
    } else {
      values.add(_decodeValue(param, data, baseOffset + headCursor));
      headCursor += staticAbiTypeSize(param);
    }
  }
  return values;
}

Object? _decodeValue(AbiParameter param, Uint8List data, int offset) {
  final arrayInfo = parseArrayType(param.type);
  if (arrayInfo != null) {
    final elementParam = param.copyWith(type: arrayInfo.elementType);
    if (arrayInfo.fixedLength != null) {
      return _decodeSequence(
        List.filled(arrayInfo.fixedLength!, elementParam),
        data,
        offset,
      );
    }
    final length = _readUint(data, offset).toInt();
    return _decodeSequence(
      List.filled(length, elementParam),
      data,
      offset + 32,
    );
  }

  if (param.type == 'tuple') {
    final components = param.components ?? const <AbiParameter>[];
    return _decodeSequence(components, data, offset);
  }

  switch (param.type) {
    case 'address':
      return getAddress(bytesToHex(data.sublist(offset + 12, offset + 32)));
    case 'bool':
      return _readUint(data, offset) != BigInt.zero;
    case 'string':
      return utf8.decode(_decodeDynamicBytes(data, offset));
    case 'bytes':
      return _decodeDynamicBytes(data, offset);
  }

  if (_uintTypeRegExp.hasMatch(param.type)) return _readUint(data, offset);
  if (_intTypeRegExp.hasMatch(param.type)) return _readInt(data, offset);

  final fixedBytesMatch = _fixedBytesTypeRegExp.firstMatch(param.type);
  if (fixedBytesMatch != null) {
    final size = int.parse(fixedBytesMatch.group(1)!);
    return data.sublist(offset, offset + size);
  }

  throw FormatException('Unsupported ABI type `${param.type}`.');
}

BigInt _readUint(Uint8List data, int offset) =>
    hexToBigInt(bytesToHex(data.sublist(offset, offset + 32)));

BigInt _readInt(Uint8List data, int offset) =>
    hexToBigInt(bytesToHex(data.sublist(offset, offset + 32)), signed: true);

Uint8List _decodeDynamicBytes(Uint8List data, int offset) {
  final length = _readUint(data, offset).toInt();
  return data.sublist(offset + 32, offset + 32 + length);
}
