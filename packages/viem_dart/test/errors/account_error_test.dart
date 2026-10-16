import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('AccountNotFoundError', () {
    test('has a fixed short message and hint', () {
      const error = AccountNotFoundError();
      expect(
        error.shortMessage,
        'Could not find an Account to execute with this action.',
      );
      expect(error.metaMessages, isNotEmpty);
    });
  });

  group('AccountTypeNotSupportedError', () {
    test('mentions the unsupported type', () {
      final error = AccountTypeNotSupportedError(type: 'jsonRpc');
      expect(error.shortMessage, contains('"jsonRpc"'));
    });
  });
}
