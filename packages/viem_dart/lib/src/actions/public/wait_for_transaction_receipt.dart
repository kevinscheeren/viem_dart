import '../../client/client.dart';
import '../../client/transaction_receipt.dart';
import '../../errors/transaction_error.dart';
import 'public_actions.dart'; // for PublicClient.getTransactionReceipt()

/// Polls for a transaction receipt on every [PublicClient].
extension WaitForTransactionReceiptAction on PublicClient {
  /// Polls for [hash]'s receipt (`eth_getTransactionReceipt`) every
  /// [pollingInterval] until it's mined, or throws
  /// [WaitForTransactionReceiptTimeoutError] after [timeout].
  Future<TransactionReceipt> waitForTransactionReceipt(
    String hash, {
    Duration pollingInterval = const Duration(seconds: 1),
    Duration timeout = const Duration(minutes: 2),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (true) {
      final receipt = await getTransactionReceipt(hash);
      if (receipt != null) return receipt;
      if (DateTime.now().isAfter(deadline)) {
        throw WaitForTransactionReceiptTimeoutError(hash: hash);
      }
      await Future<void>.delayed(pollingInterval);
    }
  }
}
