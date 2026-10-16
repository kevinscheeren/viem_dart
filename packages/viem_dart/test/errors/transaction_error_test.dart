import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

TransactionReceipt _receipt({int? status}) => TransactionReceipt(
  transactionHash: '0xhash',
  transactionIndex: 0,
  blockHash: '0xblock',
  blockNumber: BigInt.one,
  from: '0xfrom',
  cumulativeGasUsed: BigInt.zero,
  gasUsed: BigInt.zero,
  logs: const [],
  logsBloom: '0x0',
  status: status,
);

void main() {
  group('FeeConflictError', () {
    test('has a fixed short message and hint', () {
      const error = FeeConflictError();
      expect(error.shortMessage, contains('Cannot specify both a `gasPrice`'));
      expect(error.metaMessages, isNotEmpty);
    });
  });

  group('TransactionNotFoundError', () {
    test('mentions the hash when given', () {
      final error = TransactionNotFoundError(hash: '0xabc');
      expect(error.shortMessage, contains('0xabc'));
    });

    test('falls back to a generic message with no hash', () {
      final error = TransactionNotFoundError();
      expect(error.shortMessage, 'Transaction could not be found.');
    });
  });

  group('TransactionReceiptRevertedError', () {
    test('includes the transaction hash from the receipt', () {
      final error = TransactionReceiptRevertedError(
        receipt: _receipt(status: 0),
      );
      expect(error.shortMessage, contains('0xhash'));
      expect(error.receipt.status, 0);
    });
  });

  group('WaitForTransactionReceiptTimeoutError', () {
    test('includes the transaction hash', () {
      final error = WaitForTransactionReceiptTimeoutError(hash: '0xabc');
      expect(error.shortMessage, contains('0xabc'));
    });
  });
}
