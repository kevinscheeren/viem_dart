import 'package:test/test.dart';
import 'package:viem_dart/siwe.dart';

void main() {
  const address = '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359';

  group('validateSiweMessage', () {
    test('true for a message with no constraints and no time window', () {
      const message = SiweMessage(address: address, domain: 'example.com');
      expect(validateSiweMessage(message: message), isTrue);
    });

    test('false when domain does not match', () {
      const message = SiweMessage(address: address, domain: 'example.com');
      expect(
        validateSiweMessage(message: message, domain: 'evil.com'),
        isFalse,
      );
    });

    test('false when nonce does not match', () {
      const message = SiweMessage(address: address, nonce: 'abc12345');
      expect(
        validateSiweMessage(message: message, nonce: 'different'),
        isFalse,
      );
    });

    test('false when scheme does not match', () {
      const message = SiweMessage(address: address, scheme: 'https');
      expect(validateSiweMessage(message: message, scheme: 'http'), isFalse);
    });

    test('false once past expirationTime', () {
      final message = SiweMessage(
        address: address,
        expirationTime: DateTime.utc(2024),
      );
      expect(
        validateSiweMessage(
          message: message,
          time: DateTime.utc(2024, 1, 1, 0, 0, 1),
        ),
        isFalse,
      );
    });

    test('true just before expirationTime', () {
      final message = SiweMessage(
        address: address,
        expirationTime: DateTime.utc(2024),
      );
      expect(
        validateSiweMessage(
          message: message,
          time: DateTime.utc(2023, 12, 31, 23, 59, 59),
        ),
        isTrue,
      );
    });

    test('false before notBefore', () {
      final message = SiweMessage(
        address: address,
        notBefore: DateTime.utc(2024),
      );
      expect(
        validateSiweMessage(
          message: message,
          time: DateTime.utc(2023, 12, 31, 23, 59, 59),
        ),
        isFalse,
      );
    });

    test('true at or after notBefore', () {
      final message = SiweMessage(
        address: address,
        notBefore: DateTime.utc(2024),
      );
      expect(
        validateSiweMessage(message: message, time: DateTime.utc(2024)),
        isTrue,
      );
    });

    test('false when the message has no address at all', () {
      const message = SiweMessage(domain: 'example.com');
      expect(validateSiweMessage(message: message), isFalse);
    });

    test('false when the message address is malformed', () {
      const message = SiweMessage(address: '0xnotanaddress');
      expect(validateSiweMessage(message: message), isFalse);
    });

    test('false when address does not match, ignoring case', () {
      const message = SiweMessage(address: address);
      expect(
        validateSiweMessage(
          message: message,
          address: '0x000000000000000000000000000000000000dEaD',
        ),
        isFalse,
      );
    });

    test('true when address matches regardless of checksum casing', () {
      const message = SiweMessage(address: address);
      expect(
        validateSiweMessage(message: message, address: address.toLowerCase()),
        isTrue,
      );
    });
  });
}
