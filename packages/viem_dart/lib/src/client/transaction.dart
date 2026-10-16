import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// A transaction, as returned by `eth_getTransactionByHash` /
/// `eth_getBlockByNumber` (when requested with full transaction objects).
@freezed
abstract class Transaction with _$Transaction {
  /// Creates a [Transaction] from its raw fields.
  const factory Transaction({
    required String hash,
    @HexIntConverter() required int nonce,
    String? blockHash,
    @HexBigIntNConverter() BigInt? blockNumber,
    @HexIntNConverter() int? transactionIndex,
    required String from,
    String? to,
    @HexBigIntConverter() required BigInt value,
    @HexBigIntConverter() required BigInt gas,
    @HexBigIntNConverter() BigInt? gasPrice,
    @HexBigIntNConverter() BigInt? maxFeePerGas,
    @HexBigIntNConverter() BigInt? maxPriorityFeePerGas,
    required String input,
    @HexIntNConverter() int? type,
    @HexBigIntNConverter() BigInt? chainId,
    String? v,
    String? r,
    String? s,
    List<Object?>? accessList,
  }) = _Transaction;

  /// Parses a `eth_getTransactionByHash` JSON-RPC result.
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
