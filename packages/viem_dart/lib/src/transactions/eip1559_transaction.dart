import 'dart:typed_data';

import '../accounts/account.dart';
import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'transaction_envelope.dart';

/// The EIP-2718 transaction-type byte identifying an EIP-1559 (dynamic
/// fee) transaction on the wire.
const int eip1559TransactionType = 0x02;

/// Encodes [tx] per EIP-2718/EIP-1559: the type byte `0x02` followed by
/// the RLP list `[chainId, nonce, maxPriorityFeePerGas, maxFeePerGas,
/// gasLimit, to, value, data, accessList]`, plus `[yParity, r, s]` once
/// [tx] is signed.
Uint8List serializeEip1559Transaction(Eip1559Transaction tx) {
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
  ];

  if (tx.yParity != null) {
    fields.addAll([
      RlpItem.bytes(rlpBytesFromBigInt(BigInt.from(tx.yParity!))),
      RlpItem.bytes(rlpBytesFromBigInt(tx.r!)),
      RlpItem.bytes(rlpBytesFromBigInt(tx.s!)),
    ]);
  }

  return Uint8List.fromList([
    eip1559TransactionType,
    ...encodeRlp(RlpItem.list(fields)),
  ]);
}

/// The keccak256 hash of [tx]'s to-be-signed preimage (its signature fields
/// are ignored, not required to already be `null`) — sign this with the
/// sender's private key to produce `r`/`s`/`yParity`.
Uint8List hashEip1559Transaction(Eip1559Transaction tx) {
  final unsigned = tx.copyWith(yParity: null, r: null, s: null);
  return keccak256(serializeEip1559Transaction(unsigned));
}

/// Signs [tx] with [account]'s private key, returning a copy with
/// `yParity`/`r`/`s` populated.
Eip1559Transaction signEip1559Transaction(
  Eip1559Transaction tx,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashEip1559Transaction(tx),
    account.privateKey,
  );
  return tx.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}

/// Decodes a serialized EIP-1559 transaction (including its leading
/// `0x02` type byte) back into an [Eip1559Transaction].
Eip1559Transaction parseEip1559Transaction(Uint8List serialized) {
  if (serialized.isEmpty || serialized[0] != eip1559TransactionType) {
    throw FormatException(
      'Invalid EIP-1559 transaction: expected type byte '
      '0x${eip1559TransactionType.toRadixString(16).padLeft(2, '0')}.',
    );
  }
  final decoded = decodeRlp(serialized.sublist(1));
  if (decoded is! RlpList) {
    throw const FormatException(
      'Invalid EIP-1559 transaction: expected an RLP list.',
    );
  }
  final items = decoded.items;
  if (items.length != 9 && items.length != 12) {
    throw FormatException(
      'Invalid EIP-1559 transaction: expected 9 (unsigned) or 12 (signed) '
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

  if (items.length == 9) {
    return Eip1559Transaction(
      chainId: chainId,
      nonce: nonce,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      maxFeePerGas: maxFeePerGas,
      gasLimit: gasLimit,
      to: to,
      value: value,
      data: data,
      accessList: accessList,
    );
  }

  final yParity = rlpBytesToBigInt(bytesOfRlpItem(items[9])).toInt();
  final r = rlpBytesToBigInt(bytesOfRlpItem(items[10]));
  final s = rlpBytesToBigInt(bytesOfRlpItem(items[11]));

  return Eip1559Transaction(
    chainId: chainId,
    nonce: nonce,
    maxPriorityFeePerGas: maxPriorityFeePerGas,
    maxFeePerGas: maxFeePerGas,
    gasLimit: gasLimit,
    to: to,
    value: value,
    data: data,
    accessList: accessList,
    yParity: yParity,
    r: r,
    s: s,
  );
}
