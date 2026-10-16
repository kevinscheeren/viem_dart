import 'dart:typed_data';

import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import 'address.dart';
import 'hex.dart';

/// Computes a contract's deployment address ahead of/without deploying it —
/// `CREATE` (deterministic from [from] + [nonce]) if [nonce] is given, or
/// `CREATE2` (deterministic from [from] + [salt] + [bytecode]'s hash) if
/// [salt] and [bytecode] are given instead.
///
/// Exactly one of [nonce], or the ([salt], [bytecode]) pair, must be
/// provided.
String getContractAddress({
  required String from,
  BigInt? nonce,
  String? salt,
  String? bytecode,
}) {
  if (nonce != null) {
    if (salt != null || bytecode != null) {
      throw ArgumentError(
        'Provide either `nonce` (CREATE) or both `salt` and `bytecode` '
        '(CREATE2), not both.',
      );
    }
    return _createAddress(from: from, nonce: nonce);
  }
  if (salt != null && bytecode != null) {
    return _create2Address(from: from, salt: salt, bytecode: bytecode);
  }
  throw ArgumentError(
    'Provide either `nonce` (CREATE) or both `salt` and `bytecode` '
    '(CREATE2).',
  );
}

String _createAddress({required String from, required BigInt nonce}) {
  final encoded = encodeRlp(
    RlpItem.list([
      RlpItem.bytes(hexToBytes(from)),
      RlpItem.bytes(rlpBytesFromBigInt(nonce)),
    ]),
  );
  return _addressFromHash(keccak256(encoded));
}

String _create2Address({
  required String from,
  required String salt,
  required String bytecode,
}) {
  final saltBytes = hexToBytes(padHex(salt, size: 32));
  final initCodeHash = keccak256(hexToBytes(bytecode));
  final preimage = Uint8List.fromList([
    0xff,
    ...hexToBytes(from),
    ...saltBytes,
    ...initCodeHash,
  ]);
  return _addressFromHash(keccak256(preimage));
}

String _addressFromHash(Uint8List hash) =>
    getAddress(bytesToHex(hash.sublist(12)));
