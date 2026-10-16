import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';

/// A transaction request with its nonce/gas/fee fields filled in by
/// `prepareTransactionRequest`, ready to be signed and sent.
@freezed
abstract class TransactionRequest with _$TransactionRequest {
  /// Creates a [TransactionRequest] from its raw fields.
  const factory TransactionRequest({
    required String from,
    String? to,
    BigInt? value,
    String? data,
    required int nonce,
    required BigInt gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
    BigInt? gasPrice,
    required BigInt chainId,
  }) = _TransactionRequest;
}
