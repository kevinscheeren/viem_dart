import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';
import 'log.dart';

part 'transaction_receipt.freezed.dart';
part 'transaction_receipt.g.dart';

/// A transaction receipt, as returned by `eth_getTransactionReceipt`.
@freezed
abstract class TransactionReceipt with _$TransactionReceipt {
  /// Creates a [TransactionReceipt] from its raw fields.
  const factory TransactionReceipt({
    required String transactionHash,
    @HexIntConverter() required int transactionIndex,
    required String blockHash,
    @HexBigIntConverter() required BigInt blockNumber,
    required String from,
    String? to,
    @HexBigIntConverter() required BigInt cumulativeGasUsed,
    @HexBigIntConverter() required BigInt gasUsed,
    String? contractAddress,
    required List<Log> logs,
    required String logsBloom,
    @HexIntNConverter() int? status,
    @HexBigIntNConverter() BigInt? effectiveGasPrice,
    @HexIntNConverter() int? type,
  }) = _TransactionReceipt;

  /// Parses a `eth_getTransactionReceipt` JSON-RPC result.
  factory TransactionReceipt.fromJson(Map<String, dynamic> json) =>
      _$TransactionReceiptFromJson(json);
}
