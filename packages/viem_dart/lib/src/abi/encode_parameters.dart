import 'dart:convert';
import 'dart:typed_data';

import '../errors/abi_error.dart';
import '../utils/address.dart';
import '../utils/hex.dart';
import 'abi_parameter.dart';
import 'abi_type.dart';

final RegExp _uintTypeRegExp = RegExp(r'^uint(\d*)$');
final RegExp _intTypeRegExp = RegExp(r'^int(\d*)$');
final RegExp _fixedBytesTypeRegExp = RegExp(r'^bytes(\d+)$');

/// Encodes [values] against [params] per the Solidity ABI spec (the
/// "head/tail" scheme: static values inline, dynamic values referenced by
/// a 32-byte offset into a trailing "tail" section). No function selector
/// is prepended — see `encodeFunctionData` for that.
Uint8List encodeAbiParameters(List<AbiParameter> params, List<Object?> values) {
  if (params.length != values.length) {
    throw AbiEncodingLengthMismatchError(
      expectedLength: params.length,
      givenLength: values.length,
    );
  }
  return _encodeSequence(params, values);
}

Uint8List _encodeSequence(List<AbiParameter> params, List<Object?> values) {
  final headParts = <Uint8List>[];
  final tailParts = <Uint8List>[];
  final dynamicFlags = <bool>[];

  for (var i = 0; i < params.length; i++) {
    final dynamic_ = isDynamicAbiType(params[i]);
    dynamicFlags.add(dynamic_);
    final encoded = _encodeValue(params[i], values[i]);
    if (dynamic_) {
      headParts.add(Uint8List(32));
      tailParts.add(encoded);
    } else {
      headParts.add(encoded);
      tailParts.add(Uint8List(0));
    }
  }

  final headSize = headParts.fold<int>(0, (sum, p) => sum + p.length);
  var tailOffset = headSize;
  final resolvedHead = <Uint8List>[];
  for (var i = 0; i < params.length; i++) {
    if (dynamicFlags[i]) {
      resolvedHead.add(_encodeUint(BigInt.from(tailOffset)));
      tailOffset += tailParts[i].length;
    } else {
      resolvedHead.add(headParts[i]);
    }
  }

  return Uint8List.fromList([
    for (final part in resolvedHead) ...part,
    for (final part in tailParts) ...part,
  ]);
}

Uint8List _encodeValue(AbiParameter param, Object? value) {
  final arrayInfo = parseArrayType(param.type);
  if (arrayInfo != null) {
    final elementParam = param.copyWith(type: arrayInfo.elementType);
    final list = (value as List).cast<Object?>();
    if (arrayInfo.fixedLength != null && list.length != arrayInfo.fixedLength) {
      throw FormatException(
        'Expected ${arrayInfo.fixedLength} element(s) for type `${param.type}`, got ${list.length}.',
      );
    }
    final body = _encodeSequence(List.filled(list.length, elementParam), list);
    if (arrayInfo.fixedLength != null) return body;
    return Uint8List.fromList([
      ..._encodeUint(BigInt.from(list.length)),
      ...body,
    ]);
  }

  if (param.type == 'tuple') {
    final components = param.components ?? const <AbiParameter>[];
    final list = value is Map
        ? components.map((c) => value[c.name]).toList()
        : (value as List).cast<Object?>();
    return _encodeSequence(components, list);
  }

  switch (param.type) {
    case 'address':
      return _encodeAddress(value as String);
    case 'bool':
      return _encodeUint((value as bool) ? BigInt.one : BigInt.zero);
    case 'string':
      return _encodeDynamicBytes(
        Uint8List.fromList(utf8.encode(value as String)),
      );
    case 'bytes':
      return _encodeDynamicBytes(value as Uint8List);
  }

  final uintMatch = _uintTypeRegExp.firstMatch(param.type);
  if (uintMatch != null) {
    final bits = uintMatch.group(1)!.isEmpty
        ? 256
        : int.parse(uintMatch.group(1)!);
    return _encodeUintChecked(_toBigInt(value), bits, param.type);
  }

  final intMatch = _intTypeRegExp.firstMatch(param.type);
  if (intMatch != null) {
    final bits = intMatch.group(1)!.isEmpty
        ? 256
        : int.parse(intMatch.group(1)!);
    return _encodeIntChecked(_toBigInt(value), bits, param.type);
  }

  final fixedBytesMatch = _fixedBytesTypeRegExp.firstMatch(param.type);
  if (fixedBytesMatch != null) {
    final size = int.parse(fixedBytesMatch.group(1)!);
    return _encodeFixedBytes(value as Uint8List, size, param.type);
  }

  throw FormatException('Unsupported ABI type `${param.type}`.');
}

BigInt _toBigInt(Object? value) {
  if (value is BigInt) return value;
  if (value is int) return BigInt.from(value);
  throw FormatException(
    'Expected an int or BigInt, got `${value.runtimeType}`.',
  );
}

Uint8List _encodeUint(BigInt value) => hexToBytes(bigIntToHex(value, size: 32));

Uint8List _encodeUintChecked(BigInt value, int bits, String type) {
  final max = (BigInt.one << bits) - BigInt.one;
  if (value.isNegative || value > max) {
    throw FormatException('Value `$value` is out of range for `$type`.');
  }
  return _encodeUint(value);
}

Uint8List _encodeIntChecked(BigInt value, int bits, String type) {
  final max = (BigInt.one << (bits - 1)) - BigInt.one;
  final min = -(BigInt.one << (bits - 1));
  if (value < min || value > max) {
    throw FormatException('Value `$value` is out of range for `$type`.');
  }
  return hexToBytes(bigIntToHex(value, size: 32, signed: true));
}

Uint8List _encodeAddress(String address) {
  if (!isAddress(address)) {
    throw FormatException('`$address` is not a valid address.');
  }
  return hexToBytes(padHex(address.toLowerCase()));
}

Uint8List _encodeFixedBytes(Uint8List value, int size, String type) {
  if (value.length != size) {
    throw FormatException(
      'Expected $size byte(s) for `$type`, got ${value.length}.',
    );
  }
  return hexToBytes(bytesToHex(value, size: 32));
}

Uint8List _encodeDynamicBytes(Uint8List data) {
  final paddedLength = ((data.length + 31) ~/ 32) * 32;
  final padded = Uint8List(paddedLength)..setRange(0, data.length, data);
  return Uint8List.fromList([
    ..._encodeUint(BigInt.from(data.length)),
    ...padded,
  ]);
}
