import 'dart:typed_data';

import '../accounts/account.dart';
import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'transaction_envelope.dart';

/// The EIP-2718 transaction-type byte identifying an EIP-2930 (access
/// list) transaction on the wire.
const int eip2930TransactionType = 0x01;

/// Encodes [tx] per EIP-2718/EIP-2930: the type byte `0x01` followed by
/// the RLP list `[chainId, nonce, gasPrice, gasLimit, to, value, data,
/// accessList]`, plus `[yParity, r, s]` once [tx] is signed. Unlike legacy
/// transactions, `yParity` is carried directly on the wire — there's no
/// EIP-155 `v` derivation.
Uint8List serializeEip2930Transaction(Eip2930Transaction tx) {
  final fields = <RlpItem>[
    RlpItem.bytes(rlpBytesFromBigInt(tx.chainId)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.nonce)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.gasPrice)),
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
    eip2930TransactionType,
    ...encodeRlp(RlpItem.list(fields)),
  ]);
}

/// The keccak256 hash of [tx]'s to-be-signed preimage (its signature fields
/// are ignored, not required to already be `null`) — sign this with the
/// sender's private key to produce `r`/`s`/`yParity`.
Uint8List hashEip2930Transaction(Eip2930Transaction tx) {
  final unsigned = tx.copyWith(yParity: null, r: null, s: null);
  return keccak256(serializeEip2930Transaction(unsigned));
}

/// Signs [tx] with [account]'s private key, returning a copy with
/// `yParity`/`r`/`s` populated.
Eip2930Transaction signEip2930Transaction(
  Eip2930Transaction tx,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashEip2930Transaction(tx),
    account.privateKey,
  );
  return tx.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}

/// Decodes a serialized EIP-2930 transaction (including its leading
/// `0x01` type byte) back into an [Eip2930Transaction].
Eip2930Transaction parseEip2930Transaction(Uint8List serialized) {
  if (serialized.isEmpty || serialized[0] != eip2930TransactionType) {
    throw FormatException(
      'Invalid EIP-2930 transaction: expected type byte '
      '0x${eip2930TransactionType.toRadixString(16).padLeft(2, '0')}.',
    );
  }
  final decoded = decodeRlp(serialized.sublist(1));
  if (decoded is! RlpList) {
    throw const FormatException(
      'Invalid EIP-2930 transaction: expected an RLP list.',
    );
  }
  final items = decoded.items;
  if (items.length != 8 && items.length != 11) {
    throw FormatException(
      'Invalid EIP-2930 transaction: expected 8 (unsigned) or 11 (signed) '
      'fields, got ${items.length}.',
    );
  }

  final chainId = rlpBytesToBigInt(bytesOfRlpItem(items[0]));
  final nonce = rlpBytesToBigInt(bytesOfRlpItem(items[1]));
  final gasPrice = rlpBytesToBigInt(bytesOfRlpItem(items[2]));
  final gasLimit = rlpBytesToBigInt(bytesOfRlpItem(items[3]));
  final toBytes = bytesOfRlpItem(items[4]);
  final to = toBytes.isEmpty ? null : bytesToHex(toBytes);
  final value = rlpBytesToBigInt(bytesOfRlpItem(items[5]));
  final data = bytesOfRlpItem(items[6]);
  final accessList = decodeAccessListRlp(items[7]);

  if (items.length == 8) {
    return Eip2930Transaction(
      chainId: chainId,
      nonce: nonce,
      gasPrice: gasPrice,
      gasLimit: gasLimit,
      to: to,
      value: value,
      data: data,
      accessList: accessList,
    );
  }

  final yParity = rlpBytesToBigInt(bytesOfRlpItem(items[8])).toInt();
  final r = rlpBytesToBigInt(bytesOfRlpItem(items[9]));
  final s = rlpBytesToBigInt(bytesOfRlpItem(items[10]));

  return Eip2930Transaction(
    chainId: chainId,
    nonce: nonce,
    gasPrice: gasPrice,
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
