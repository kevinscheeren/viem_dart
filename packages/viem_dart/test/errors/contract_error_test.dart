import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('ContractFunctionZeroDataError', () {
    test('mentions the function name and possible causes', () {
      final error = ContractFunctionZeroDataError(functionName: 'balanceOf');
      expect(error.shortMessage, contains('"balanceOf"'));
      expect(error.metaMessages, isNotEmpty);
    });
  });

  group('ContractFunctionRevertedError', () {
    test('includes the reason when given', () {
      final error = ContractFunctionRevertedError(
        functionName: 'transfer',
        reason: 'insufficient balance',
      );
      expect(error.shortMessage, contains('insufficient balance'));
    });

    test('carries the raw revert data when given', () {
      final error = ContractFunctionRevertedError(
        functionName: 'transfer',
        data: Uint8List.fromList([1, 2, 3]),
      );
      expect(error.data, [1, 2, 3]);
      expect(ContractFunctionRevertedError(functionName: 'x').data, isNull);
    });

    test('falls back to a generic message with no reason', () {
      final error = ContractFunctionRevertedError(functionName: 'transfer');
      expect(error.shortMessage, 'The contract function "transfer" reverted.');
    });
  });

  group('ContractFunctionExecutionError', () {
    test('wraps a ViemError cause, reusing its short message', () {
      final cause = ContractFunctionRevertedError(
        functionName: 'transfer',
        reason: 'insufficient balance',
      );
      final error = ContractFunctionExecutionError(
        functionName: 'transfer',
        cause: cause,
        contractAddress: '0xabc',
        args: const [1, 2],
      );
      expect(error.shortMessage, cause.shortMessage);
      expect(error.cause, cause);
      expect(error.metaMessages, contains('  address:  0xabc'));
      expect(error.metaMessages, contains('  function: transfer'));
      expect(error.metaMessages, contains('  args:     [1, 2]'));
    });

    test('summarizes a non-ViemError cause generically', () {
      final error = ContractFunctionExecutionError(
        functionName: 'transfer',
        cause: StateError('boom'),
      );
      expect(
        error.shortMessage,
        'An unknown error occurred while executing the contract function '
        '"transfer".',
      );
    });
  });
}
