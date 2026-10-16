import 'dart:convert';
import 'dart:typed_data';

import '../abi/abi_parameter.dart';
import '../abi/abi_type.dart';
import '../abi/encode_parameters.dart';
import '../crypto/keccak.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../crypto/signature.dart';
import 'account.dart';
import 'typed_data.dart';

/// Signs EIP-712 typed structured data with [account]'s private key. See
/// [hashTypedData] for the hashing algorithm.
Signature signTypedData(
  LocalAccount account, {
  required Eip712Domain domain,
  required Map<String, List<TypedDataField>> types,
  required String primaryType,
  required Map<String, Object?> message,
}) {
  final hash = hashTypedData(
    domain: domain,
    types: types,
    primaryType: primaryType,
    message: message,
  );
  return secp256k1.sign(hash, account.privateKey);
}

/// The EIP-712 digest for the given [domain], [types] registry,
/// [primaryType], and [message]:
/// `keccak256("\x19\x01" + domainSeparator + hashStruct(message))`.
Uint8List hashTypedData({
  required Eip712Domain domain,
  required Map<String, List<TypedDataField>> types,
  required String primaryType,
  required Map<String, Object?> message,
}) {
  final domainSeparator = hashTypedDataDomain(domain);
  final messageHash = _hashStruct(primaryType, types, message);
  return keccak256(
    Uint8List.fromList([0x19, 0x01, ...domainSeparator, ...messageHash]),
  );
}

/// The EIP-712 domain separator: `hashStruct` of [domain] against the
/// `EIP712Domain` type auto-derived from its non-null fields.
Uint8List hashTypedDataDomain(Eip712Domain domain) => _hashStruct(
  'EIP712Domain',
  {'EIP712Domain': _domainTypeFields(domain)},
  _domainToMap(domain),
);

/// The EIP-712 `hashStruct(data)` for [typeName] against the [types]
/// registry — the same struct-hashing [hashTypedData] applies to the
/// top-level message, exposed directly for e.g. hashing a nested value on
/// its own.
Uint8List hashTypedDataStruct(
  String typeName,
  Map<String, List<TypedDataField>> types,
  Map<String, Object?> data,
) => _hashStruct(typeName, types, data);

List<TypedDataField> _domainTypeFields(Eip712Domain domain) => [
  if (domain.name != null) const TypedDataField(name: 'name', type: 'string'),
  if (domain.version != null)
    const TypedDataField(name: 'version', type: 'string'),
  if (domain.chainId != null)
    const TypedDataField(name: 'chainId', type: 'uint256'),
  if (domain.verifyingContract != null)
    const TypedDataField(name: 'verifyingContract', type: 'address'),
  if (domain.salt != null) const TypedDataField(name: 'salt', type: 'bytes32'),
];

Map<String, Object?> _domainToMap(Eip712Domain domain) => {
  'name': ?domain.name,
  'version': ?domain.version,
  'chainId': ?domain.chainId,
  'verifyingContract': ?domain.verifyingContract,
  'salt': ?domain.salt,
};

Uint8List _hashStruct(
  String typeName,
  Map<String, List<TypedDataField>> types,
  Map<String, Object?> data,
) {
  final typeHash = keccak256(
    Uint8List.fromList(utf8.encode(_encodeType(typeName, types))),
  );
  final encodedData = _encodeData(typeName, types, data);
  return keccak256(Uint8List.fromList([...typeHash, ...encodedData]));
}

/// The canonical type signature per EIP-712 §encodeType: the primary type's
/// own field list, followed by every struct type it (transitively)
/// references, sorted alphabetically.
String _encodeType(String typeName, Map<String, List<TypedDataField>> types) {
  final referenced = <String>{};
  _collectReferencedTypes(typeName, types, referenced);
  referenced.remove(typeName);
  final ordered = [typeName, ...referenced.toList()..sort()];
  return ordered.map((name) => _encodeSingleType(name, types[name]!)).join();
}

String _encodeSingleType(String name, List<TypedDataField> fields) =>
    '$name(${fields.map((f) => '${f.type} ${f.name}').join(',')})';

void _collectReferencedTypes(
  String typeName,
  Map<String, List<TypedDataField>> types,
  Set<String> found,
) {
  if (found.contains(typeName)) return;
  final fields = types[typeName];
  if (fields == null) return;
  found.add(typeName);
  for (final field in fields) {
    _collectReferencedTypes(_stripArraySuffix(field.type), types, found);
  }
}

String _stripArraySuffix(String type) {
  final index = type.indexOf('[');
  return index == -1 ? type : type.substring(0, index);
}

Uint8List _encodeData(
  String typeName,
  Map<String, List<TypedDataField>> types,
  Map<String, Object?> data,
) {
  final fields = types[typeName]!;
  final encoded = <int>[];
  for (final field in fields) {
    encoded.addAll(_encodeField(field.type, types, data[field.name]));
  }
  return Uint8List.fromList(encoded);
}

/// EIP-712 §encodeData's per-field encoding: atomic types encode exactly
/// like standard ABI encoding (reusing [encodeAbiParameters]); `string`/
/// `bytes` encode as the keccak256 hash of their raw bytes (never the raw
/// value itself); struct-typed fields encode as their own `hashStruct`;
/// array fields encode as the keccak256 hash of their concatenated
/// per-element encodings.
Uint8List _encodeField(
  String type,
  Map<String, List<TypedDataField>> types,
  Object? value,
) {
  final arrayInfo = parseArrayType(type);
  if (arrayInfo != null) {
    final values = (value as List).cast<Object?>();
    final elementEncodings = values
        .map((v) => _encodeField(arrayInfo.elementType, types, v))
        .expand((e) => e)
        .toList();
    return keccak256(Uint8List.fromList(elementEncodings));
  }

  if (types.containsKey(type)) {
    return _hashStruct(type, types, value as Map<String, Object?>);
  }

  if (type == 'string') {
    return keccak256(Uint8List.fromList(utf8.encode(value as String)));
  }
  if (type == 'bytes') {
    return keccak256(value as Uint8List);
  }

  return encodeAbiParameters([AbiParameter(name: '', type: type)], [value]);
}
