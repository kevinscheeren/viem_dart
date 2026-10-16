import 'dart:typed_data';

import '../accounts/account.dart';
import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'authorization_rlp.dart';
import 'transaction_envelope.dart';

/// The EIP-2718 transaction-type byte identifying an EIP-7702
/// (authorization list / set-code) transaction on the wire.
const int eip7702TransactionType = 0x04;

/// Encodes [tx] per EIP-2718/EIP-7702: the type byte `0x04` followed by
/// the RLP list `[chainId, nonce, maxPriorityFeePerGas, maxFeePerGas,
/// gasLimit, to, value, data, accessList, authorizationList]`, plus
/// `[yParity, r, s]` once [tx] is signed. Every entry of
/// [tx].authorizationList must itself already be signed (see
/// [signAuthorization]) — that signature is independent of, and unrelated
/// to, the transaction's own.
Uint8List serializeEip7702Transaction(Eip7702Transaction tx) {
  final fields = <RlpItem>[
    RlpItem.bytes(rlpBytesFromBigInt(tx.chainId)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.nonce)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.maxPriorityFeePerGas)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.maxFeePerGas)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.gasLimit)),
    RlpItem.bytes(tx.to == null ? Uint8List(0) : hexToBytes(tx.to!)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.value)),
    RlpItem.bytes(tx.data),
    encodeAccessListRlp(tx.accessList),
    encodeAuthorizationListRlp(tx.authorizationList),
  ];

  if (tx.yParity != null) {
    fields.addAll([
      RlpItem.bytes(rlpBytesFromBigInt(BigInt.from(tx.yParity!))),
      RlpItem.bytes(rlpBytesFromBigInt(tx.r!)),
      RlpItem.bytes(rlpBytesFromBigInt(tx.s!)),
    ]);
  }

  return Uint8List.fromList([
    eip7702TransactionType,
    ...encodeRlp(RlpItem.list(fields)),
  ]);
}

/// The keccak256 hash of [tx]'s to-be-signed preimage (its own signature
/// fields are ignored, not required to already be `null`) — sign this with
/// the sender's private key to produce `r`/`s`/`yParity`.
Uint8List hashEip7702Transaction(Eip7702Transaction tx) {
  final unsigned = tx.copyWith(yParity: null, r: null, s: null);
  return keccak256(serializeEip7702Transaction(unsigned));
}

/// Signs [tx] with [account]'s private key, returning a copy with
/// `yParity`/`r`/`s` populated. This signs the transaction itself — each
/// [tx].authorizationList entry needs its own, separate signature (see
/// [signAuthorization]) before it's added.
Eip7702Transaction signEip7702Transaction(
  Eip7702Transaction tx,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashEip7702Transaction(tx),
    account.privateKey,
  );
  return tx.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}

/// Decodes a serialized EIP-7702 transaction (including its leading
/// `0x04` type byte) back into an [Eip7702Transaction].
Eip7702Transaction parseEip7702Transaction(Uint8List serialized) {
  if (serialized.isEmpty || serialized[0] != eip7702TransactionType) {
    throw FormatException(
      'Invalid EIP-7702 transaction: expected type byte '
      '0x${eip7702TransactionType.toRadixString(16).padLeft(2, '0')}.',
    );
  }
  final decoded = decodeRlp(serialized.sublist(1));
  if (decoded is! RlpList) {
    throw const FormatException(
      'Invalid EIP-7702 transaction: expected an RLP list.',
    );
  }
  final items = decoded.items;
  if (items.length != 10 && items.length != 13) {
    throw FormatException(
      'Invalid EIP-7702 transaction: expected 10 (unsigned) or 13 (signed) '
      'fields, got ${items.length}.',
    );
  }

  final chainId = rlpBytesToBigInt(bytesOfRlpItem(items[0]));
  final nonce = rlpBytesToBigInt(bytesOfRlpItem(items[1]));
  final maxPriorityFeePerGas = rlpBytesToBigInt(bytesOfRlpItem(items[2]));
  final maxFeePerGas = rlpBytesToBigInt(bytesOfRlpItem(items[3]));
  final gasLimit = rlpBytesToBigInt(bytesOfRlpItem(items[4]));
  final toBytes = bytesOfRlpItem(items[5]);
  final to = toBytes.isEmpty ? null : bytesToHex(toBytes);
  final value = rlpBytesToBigInt(bytesOfRlpItem(items[6]));
  final data = bytesOfRlpItem(items[7]);
  final accessList = decodeAccessListRlp(items[8]);
  final authorizationList = decodeAuthorizationListRlp(items[9]);

  if (items.length == 10) {
    return Eip7702Transaction(
      chainId: chainId,
      nonce: nonce,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      maxFeePerGas: maxFeePerGas,
      gasLimit: gasLimit,
      to: to,
      value: value,
      data: data,
      accessList: accessList,
      authorizationList: authorizationList,
    );
  }

  final yParity = rlpBytesToBigInt(bytesOfRlpItem(items[10])).toInt();
  final r = rlpBytesToBigInt(bytesOfRlpItem(items[11]));
  final s = rlpBytesToBigInt(bytesOfRlpItem(items[12]));

  return Eip7702Transaction(
    chainId: chainId,
    nonce: nonce,
    maxPriorityFeePerGas: maxPriorityFeePerGas,
    maxFeePerGas: maxFeePerGas,
    gasLimit: gasLimit,
    to: to,
    value: value,
    data: data,
    accessList: accessList,
    authorizationList: authorizationList,
    yParity: yParity,
    r: r,
    s: s,
  );
}
