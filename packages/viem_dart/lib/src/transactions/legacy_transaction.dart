import 'dart:typed_data';

import '../accounts/account.dart';
import '../crypto/keccak.dart';
import '../crypto/rlp.dart';
import '../crypto/rlp_item.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../utils/hex.dart';
import 'access_list_rlp.dart';
import 'transaction_envelope.dart';

/// RLP-encodes a legacy (pre-EIP-2718) [tx].
///
/// When [tx] carries no signature (`yParity`/`r`/`s` are `null`), this is
/// the "to-be-signed" preimage: `[nonce, gasPrice, gasLimit, to, value,
/// data]`, plus `[chainId, 0, 0]` when [tx].chainId is set (EIP-155). Once
/// signed, it's the final submittable encoding, with `v` derived from
/// [tx].chainId/[tx].yParity (`chainId*2 + 35 + yParity` under EIP-155,
/// `yParity + 27` otherwise) — see [TransactionEnvelope.legacy]'s doc.
Uint8List serializeLegacyTransaction(LegacyTransaction tx) {
  final fields = <RlpItem>[
    RlpItem.bytes(rlpBytesFromBigInt(tx.nonce)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.gasPrice)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.gasLimit)),
    RlpItem.bytes(tx.to == null ? Uint8List(0) : hexToBytes(tx.to!)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.value)),
    RlpItem.bytes(tx.data),
  ];

  if (tx.yParity == null) {
    if (tx.chainId != null) {
      fields.addAll([
        RlpItem.bytes(rlpBytesFromBigInt(tx.chainId!)),
        RlpItem.bytes(Uint8List(0)),
        RlpItem.bytes(Uint8List(0)),
      ]);
    }
    return encodeRlp(RlpItem.list(fields));
  }

  final v = tx.chainId != null
      ? tx.chainId! * BigInt.two + BigInt.from(35) + BigInt.from(tx.yParity!)
      : BigInt.from(tx.yParity! + 27);
  fields.addAll([
    RlpItem.bytes(rlpBytesFromBigInt(v)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.r!)),
    RlpItem.bytes(rlpBytesFromBigInt(tx.s!)),
  ]);
  return encodeRlp(RlpItem.list(fields));
}

/// The keccak256 hash of [tx]'s to-be-signed preimage (its signature fields
/// are ignored, not required to already be `null`) — sign this with the
/// sender's private key to produce `r`/`s`/`yParity`.
Uint8List hashLegacyTransaction(LegacyTransaction tx) {
  final unsigned = tx.copyWith(yParity: null, r: null, s: null);
  return keccak256(serializeLegacyTransaction(unsigned));
}

/// Signs [tx] with [account]'s private key, returning a copy with
/// `yParity`/`r`/`s` populated. Set [tx].chainId beforehand for EIP-155
/// replay protection (the modern default).
LegacyTransaction signLegacyTransaction(
  LegacyTransaction tx,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashLegacyTransaction(tx),
    account.privateKey,
  );
  return tx.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}

/// Decodes a serialized legacy transaction back into a [LegacyTransaction].
LegacyTransaction parseLegacyTransaction(Uint8List serialized) {
  final decoded = decodeRlp(serialized);
  if (decoded is! RlpList) {
    throw const FormatException(
      'Invalid legacy transaction: expected an RLP list.',
    );
  }
  final items = decoded.items;
  if (items.length != 6 && items.length != 9) {
    throw FormatException(
      'Invalid legacy transaction: expected 6 (unsigned) or 9 (signed) '
      'fields, got ${items.length}.',
    );
  }

  final nonce = rlpBytesToBigInt(bytesOfRlpItem(items[0]));
  final gasPrice = rlpBytesToBigInt(bytesOfRlpItem(items[1]));
  final gasLimit = rlpBytesToBigInt(bytesOfRlpItem(items[2]));
  final toBytes = bytesOfRlpItem(items[3]);
  final to = toBytes.isEmpty ? null : bytesToHex(toBytes);
  final value = rlpBytesToBigInt(bytesOfRlpItem(items[4]));
  final data = bytesOfRlpItem(items[5]);

  if (items.length == 6) {
    return LegacyTransaction(
      nonce: nonce,
      gasPrice: gasPrice,
      gasLimit: gasLimit,
      to: to,
      value: value,
      data: data,
    );
  }

  final v = rlpBytesToBigInt(bytesOfRlpItem(items[6]));
  final r = rlpBytesToBigInt(bytesOfRlpItem(items[7]));
  final s = rlpBytesToBigInt(bytesOfRlpItem(items[8]));

  BigInt? chainId;
  final int yParity;
  if (v == BigInt.from(27) || v == BigInt.from(28)) {
    yParity = (v - BigInt.from(27)).toInt();
  } else {
    final adjusted = v - BigInt.from(35);
    yParity = (adjusted % BigInt.two).toInt();
    chainId = (adjusted - BigInt.from(yParity)) ~/ BigInt.two;
  }

  return LegacyTransaction(
    nonce: nonce,
    gasPrice: gasPrice,
    gasLimit: gasLimit,
    to: to,
    value: value,
    data: data,
    chainId: chainId,
    yParity: yParity,
    r: r,
    s: s,
  );
}
