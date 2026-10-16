import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'access_list.dart';
import 'authorization.dart';

part 'transaction_envelope.freezed.dart';

/// An Ethereum transaction of any type — legacy, EIP-2930, EIP-1559,
/// EIP-4844, or EIP-7702 — before or after signing.
///
/// Every variant carries an optional [yParity]/`r`/`s`: `null` means
/// unsigned (serializing produces the payload to hash-and-sign); once set
/// (by `signTransaction`), serializing produces the final, submittable
/// signed transaction. `yParity` is the canonical 0/1 recovery id for
/// every type — legacy transactions' actual RLP `v` field (27/28, or
/// `chainId*2 + 35/36` under EIP-155) is derived from it at serialization
/// time, not stored directly.
@freezed
sealed class TransactionEnvelope with _$TransactionEnvelope {
  /// A pre-EIP-2718 legacy transaction.
  const factory TransactionEnvelope.legacy({
    required BigInt nonce,
    required BigInt gasPrice,
    required BigInt gasLimit,
    String? to,
    required BigInt value,
    required Uint8List data,

    /// `null` = pre-EIP-155 (no replay protection — effectively unused
    /// today); set = EIP-155's `v = chainId*2 + 35 + yParity` scheme,
    /// which every modern signer uses unconditionally.
    BigInt? chainId,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = LegacyTransaction;

  /// An EIP-2930 (access-list) transaction.
  const factory TransactionEnvelope.eip2930({
    required BigInt chainId,
    required BigInt nonce,
    required BigInt gasPrice,
    required BigInt gasLimit,
    String? to,
    required BigInt value,
    required Uint8List data,
    required List<AccessListEntry> accessList,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = Eip2930Transaction;

  /// An EIP-1559 (dynamic-fee) transaction.
  const factory TransactionEnvelope.eip1559({
    required BigInt chainId,
    required BigInt nonce,
    required BigInt maxPriorityFeePerGas,
    required BigInt maxFeePerGas,
    required BigInt gasLimit,
    String? to,
    required BigInt value,
    required Uint8List data,
    required List<AccessListEntry> accessList,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = Eip1559Transaction;

  /// An EIP-7702 (set-code) transaction.
  const factory TransactionEnvelope.eip7702({
    required BigInt chainId,
    required BigInt nonce,
    required BigInt maxPriorityFeePerGas,
    required BigInt maxFeePerGas,
    required BigInt gasLimit,
    String? to,
    required BigInt value,
    required Uint8List data,
    required List<AccessListEntry> accessList,
    required List<Authorization> authorizationList,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = Eip7702Transaction;

  /// An EIP-4844 (blob) transaction.
  const factory TransactionEnvelope.eip4844({
    required BigInt chainId,
    required BigInt nonce,
    required BigInt maxPriorityFeePerGas,
    required BigInt maxFeePerGas,
    required BigInt gasLimit,

    /// Required (never `null`) — blob transactions can't create contracts.
    required String to,
    required BigInt value,
    required Uint8List data,
    required List<AccessListEntry> accessList,
    required BigInt maxFeePerBlobGas,
    required List<Uint8List> blobVersionedHashes,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = Eip4844Transaction;
}
