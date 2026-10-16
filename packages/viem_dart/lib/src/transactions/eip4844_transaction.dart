import 'dart:typed_data';

import '../accounts/account.dart';
import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'transaction_envelope.dart';

/// The EIP-2718 transaction-type byte identifying an EIP-4844 (blob)
/// transaction on the wire.
const int eip4844TransactionType = 0x03;

/// Encodes [tx] per EIP-2718/EIP-4844: the type byte `0x03` followed by
/// the RLP list `[chainId, nonce, maxPriorityFeePerGas, maxFeePerGas,
/// gasLimit, to, value, data, accessList, maxFeePerBlobGas,
/// blobVersionedHashes]`, plus `[yParity, r, s]` once [tx] is signed.
///
/// This is the *consensus* encoding used once a blob transaction is
/// included in a block (and returned by `eth_getTransaction*`) — it
/// carries only the versioned hashes, not the actual blobs/KZG
/// commitments/proofs. Those form a separate "network wrapper" used only
/// for `eth_sendRawTransaction`-style mempool gossip, which viem_dart
/// does not yet produce.
Uint8List serializeEip4844Transaction(Eip4844Transaction tx) {
  final fields = <RlpItem>[
    RlpItem.bytes(rlpBytesFromBigInt(tx.chainId)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.nonce)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.maxPriorityFeePerGas)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.maxFeePerGas)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.gasLimit)),
    RlpItem.bytes(hexToBytes(tx.to)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.value)),
    RlpItem.bytes(tx.data),
    encodeAccessListRlp(tx.accessList),
    RlpItem.bytes(rlpBytesFromBigInt(tx.maxFeePerBlobGas)),
    RlpItem.list(tx.blobVersionedHashes.map(RlpItem.bytes).toList()),
  ];

  if (tx.yParity != null) {
    fields.addAll([
      RlpItem.bytes(rlpBytesFromBigInt(BigInt.from(tx.yParity!))),
      RlpItem.bytes(rlpBytesFromBigInt(tx.r!)),
      RlpItem.bytes(rlpBytesFromBigInt(tx.s!)),
    ]);
  }

  return Uint8List.fromList([
    eip4844TransactionType,
    ...encodeRlp(RlpItem.list(fields)),
  ]);
}

/// The keccak256 hash of [tx]'s to-be-signed preimage (its signature fields
/// are ignored, not required to already be `null`) — sign this with the
/// sender's private key to produce `r`/`s`/`yParity`.
Uint8List hashEip4844Transaction(Eip4844Transaction tx) {
  final unsigned = tx.copyWith(yParity: null, r: null, s: null);
  return keccak256(serializeEip4844Transaction(unsigned));
}

/// Signs [tx] with [account]'s private key, returning a copy with
/// `yParity`/`r`/`s` populated.
Eip4844Transaction signEip4844Transaction(
  Eip4844Transaction tx,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashEip4844Transaction(tx),
    account.privateKey,
  );
  return tx.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}

/// Decodes a serialized EIP-4844 transaction (including its leading
/// `0x03` type byte) back into an [Eip4844Transaction]. Expects the
/// consensus encoding — see [serializeEip4844Transaction].
Eip4844Transaction parseEip4844Transaction(Uint8List serialized) {
  if (serialized.isEmpty || serialized[0] != eip4844TransactionType) {
    throw FormatException(
      'Invalid EIP-4844 transaction: expected type byte '
      '0x${eip4844TransactionType.toRadixString(16).padLeft(2, '0')}.',
    );
  }
  final decoded = decodeRlp(serialized.sublist(1));
  if (decoded is! RlpList) {
    throw const FormatException(
      'Invalid EIP-4844 transaction: expected an RLP list.',
    );
  }
  final items = decoded.items;
  if (items.length != 11 && items.length != 14) {
    throw FormatException(
      'Invalid EIP-4844 transaction: expected 11 (unsigned) or 14 (signed) '
      'fields, got ${items.length}.',
    );
  }

  final chainId = rlpBytesToBigInt(bytesOfRlpItem(items[0]));
  final nonce = rlpBytesToBigInt(bytesOfRlpItem(items[1]));
  final maxPriorityFeePerGas = rlpBytesToBigInt(bytesOfRlpItem(items[2]));
  final maxFeePerGas = rlpBytesToBigInt(bytesOfRlpItem(items[3]));
  final gasLimit = rlpBytesToBigInt(bytesOfRlpItem(items[4]));
  final to = bytesToHex(bytesOfRlpItem(items[5]));
  final value = rlpBytesToBigInt(bytesOfRlpItem(items[6]));
  final data = bytesOfRlpItem(items[7]);
  final accessList = decodeAccessListRlp(items[8]);
  final maxFeePerBlobGas = rlpBytesToBigInt(bytesOfRlpItem(items[9]));
  final blobVersionedHashesItem = items[10];
  if (blobVersionedHashesItem is! RlpList) {
    throw const FormatException(
      'Invalid EIP-4844 transaction: expected blobVersionedHashes to be an '
      'RLP list.',
    );
  }
  final blobVersionedHashes = blobVersionedHashesItem.items
      .map(bytesOfRlpItem)
      .toList();

  if (items.length == 11) {
    return Eip4844Transaction(
      chainId: chainId,
      nonce: nonce,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      maxFeePerGas: maxFeePerGas,
      gasLimit: gasLimit,
      to: to,
      value: value,
      data: data,
      accessList: accessList,
      maxFeePerBlobGas: maxFeePerBlobGas,
      blobVersionedHashes: blobVersionedHashes,
    );
  }

  final yParity = rlpBytesToBigInt(bytesOfRlpItem(items[11])).toInt();
  final r = rlpBytesToBigInt(bytesOfRlpItem(items[12]));
  final s = rlpBytesToBigInt(bytesOfRlpItem(items[13]));

  return Eip4844Transaction(
    chainId: chainId,
    nonce: nonce,
    maxPriorityFeePerGas: maxPriorityFeePerGas,
    maxFeePerGas: maxFeePerGas,
    gasLimit: gasLimit,
    to: to,
    value: value,
    data: data,
    accessList: accessList,
    maxFeePerBlobGas: maxFeePerBlobGas,
    blobVersionedHashes: blobVersionedHashes,
    yParity: yParity,
    r: r,
    s: s,
  );
}
