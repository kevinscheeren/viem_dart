import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';

void main() {
  group('AbiDecodingZeroDataError', () {
    test('has a fixed short message', () {
      const error = AbiDecodingZeroDataError();
      expect(
        error.shortMessage,
        'Cannot decode zero data ("0x") with ABI parameters.',
      );
    });
  });

  group('AbiDecodingDataSizeTooSmallError', () {
    test('reports size and params in meta messages', () {
      final error = AbiDecodingDataSizeTooSmallError(
        size: 4,
        params: const [AbiParameter(name: 'a', type: 'uint256')],
        data: '0x1234',
      );
      expect(error.shortMessage, contains('4 bytes'));
      expect(error.metaMessages, contains('Params: (uint256 a)'));
      expect(error.metaMessages, contains('Data:   0x1234 (4 bytes)'));
    });
  });

  group('AbiEncodingLengthMismatchError', () {
    test('reports expected vs given lengths', () {
      final error = AbiEncodingLengthMismatchError(
        expectedLength: 2,
        givenLength: 1,
      );
      expect(error.expectedLength, 2);
      expect(error.givenLength, 1);
      expect(error.metaMessages, contains('Expected length (params): 2'));
      expect(error.metaMessages, contains('Given length (values): 1'));
    });

    test('is thrown by encodeAbiParameters on length mismatch', () {
      expect(
        () => encodeAbiParameters(const [
          AbiParameter(name: 'a', type: 'uint256'),
        ], []),
        throwsA(isA<AbiEncodingLengthMismatchError>()),
      );
    });
  });

  group('AbiFunctionNotFoundError', () {
    test('mentions the function name when given', () {
      final error = AbiFunctionNotFoundError(functionName: 'transfer');
      expect(error.shortMessage, contains('"transfer"'));
    });

    test('falls back to a generic message with no function name', () {
      final error = AbiFunctionNotFoundError();
      expect(error.shortMessage, 'Function not found on ABI.');
    });
  });

  group('AbiFunctionSignatureNotFoundError', () {
    test('includes the encoded signature', () {
      final error = AbiFunctionSignatureNotFoundError(signature: '0xdeadbeef');
      expect(error.shortMessage, contains('0xdeadbeef'));
      expect(
        error.metaMessages,
        contains(
          'You can look up the signature here: '
          'https://4byte.sourcify.dev/?q=0xdeadbeef.',
        ),
      );
    });
  });
}
