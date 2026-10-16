import '../client/transaction_receipt.dart';
import 'base_error.dart';

/// Thrown when a transaction request specifies both a legacy `gasPrice`
/// and an EIP-1559 `maxFeePerGas`/`maxPriorityFeePerGas` — only one fee
/// model applies at a time.
class FeeConflictError extends ViemError {
  /// Creates a [FeeConflictError].
  const FeeConflictError()
    : super(
        'Cannot specify both a `gasPrice` and a `maxFeePerGas`/`maxPriorityFeePerGas`.',
        metaMessages: const [
          'Use `maxFeePerGas`/`maxPriorityFeePerGas` for EIP-1559 compatible '
              'networks, and `gasPrice` for others.',
        ],
      );
}

/// Thrown when a transaction lookup (by hash, or by block + index) finds
/// nothing.
class TransactionNotFoundError extends ViemError {
  /// Creates a [TransactionNotFoundError], optionally for a specific
  /// [hash].
  TransactionNotFoundError({this.hash})
    : super(
        hash != null
            ? 'Transaction with hash "$hash" could not be found.'
            : 'Transaction could not be found.',
      );

  final String? hash;
}

/// Thrown when a transaction's mined receipt has `status: reverted`.
class TransactionReceiptRevertedError extends ViemError {
  /// Creates a [TransactionReceiptRevertedError] for the reverted
  /// [receipt].
  TransactionReceiptRevertedError({required this.receipt})
    : super(
        'Transaction with hash "${receipt.transactionHash}" reverted.',
        metaMessages: [
          'The receipt marked the transaction as "reverted". This could '
              'mean that the function on the contract you are trying to '
              'call threw an error.',
          '',
          'You can attempt to extract the revert reason by re-running the '
              'call with `call` (or `readContract`/`simulateContract` for a '
              'known ABI) against the same block.',
        ],
      );

  final TransactionReceipt receipt;
}

/// Thrown when polling for a transaction's confirmation
/// (`waitForTransactionReceipt`) exceeds its timeout.
class WaitForTransactionReceiptTimeoutError extends ViemError {
  /// Creates a [WaitForTransactionReceiptTimeoutError] for the pending
  /// transaction [hash].
  WaitForTransactionReceiptTimeoutError({required this.hash})
    : super(
        'Timed out while waiting for transaction with hash "$hash" to be confirmed.',
      );

  final String hash;
}

/// Thrown by `waitForCallsStatus` when an EIP-5792 batch-call id stays
/// pending (status `100`) past its timeout.
class WaitForCallsStatusTimeoutError extends ViemError {
  /// Creates a [WaitForCallsStatusTimeoutError] for the pending batch [id].
  WaitForCallsStatusTimeoutError({required this.id})
    : super(
        'Timed out while waiting for calls batch with id "$id" to complete.',
      );

  final String id;
}
