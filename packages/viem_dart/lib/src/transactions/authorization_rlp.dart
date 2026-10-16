import 'dart:typed_data';

import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'authorization.dart';

/// The EIP-7702 "MAGIC" byte prepended to an authorization's signing
/// preimage: `keccak256(MAGIC || rlp([chainId, address, nonce]))`.
const int authorizationMagic = 0x05;

/// The keccak256 hash of [authorization]'s to-be-signed preimage (its
/// signature fields, if any, are ignored) — sign this with the delegating
/// EOA's private key to produce `r`/`s`/`yParity`.
Uint8List hashAuthorization(Authorization authorization) {
  final fields = RlpItem.list([
    RlpItem.bytes(rlpBytesFromBigInt(authorization.chainId)),
    RlpItem.bytes(hexToBytes(authorization.address)),
    RlpItem.bytes(rlpBytesFromBigInt(authorization.nonce)),
  ]);
  return keccak256(
    Uint8List.fromList([authorizationMagic, ...encodeRlp(fields)]),
  );
}

/// RLP-encodes [authorization] as EIP-7702 defines it within an
/// authorization list: `[chainId, address, nonce, yParity, r, s]`.
/// [authorization] must already be signed.
RlpItem encodeAuthorizationRlp(Authorization authorization) {
  assert(
    authorization.yParity != null &&
        authorization.r != null &&
        authorization.s != null,
    'Authorization must be signed before it can be added to an '
    'authorizationList.',
  );
  return RlpItem.list([
    RlpItem.bytes(rlpBytesFromBigInt(authorization.chainId)),
    RlpItem.bytes(hexToBytes(authorization.address)),
    RlpItem.bytes(rlpBytesFromBigInt(authorization.nonce)),
    RlpItem.bytes(rlpBytesFromBigInt(BigInt.from(authorization.yParity!))),
    RlpItem.bytes(rlpBytesFromBigInt(authorization.r!)),
    RlpItem.bytes(rlpBytesFromBigInt(authorization.s!)),
  ]);
}

/// RLP-encodes a full `authorizationList`.
RlpItem encodeAuthorizationListRlp(List<Authorization> authorizationList) =>
    RlpItem.list(authorizationList.map(encodeAuthorizationRlp).toList());

/// Inverse of [encodeAuthorizationRlp].
Authorization decodeAuthorizationRlp(RlpItem item) {
  if (item is! RlpList || item.items.length != 6) {
    throw const FormatException(
      'Invalid authorization: expected a 6-element RLP list.',
    );
  }
  final fields = item.items;
  return Authorization(
    chainId: rlpBytesToBigInt(bytesOfRlpItem(fields[0])),
    address: bytesToHex(bytesOfRlpItem(fields[1])),
    nonce: rlpBytesToBigInt(bytesOfRlpItem(fields[2])),
    yParity: rlpBytesToBigInt(bytesOfRlpItem(fields[3])).toInt(),
    r: rlpBytesToBigInt(bytesOfRlpItem(fields[4])),
    s: rlpBytesToBigInt(bytesOfRlpItem(fields[5])),
  );
}

/// Inverse of [encodeAuthorizationListRlp].
List<Authorization> decodeAuthorizationListRlp(RlpItem item) {
  if (item is! RlpList) {
    throw const FormatException(
      'Invalid authorizationList: expected an RLP list.',
    );
  }
  return item.items.map(decodeAuthorizationRlp).toList();
}
