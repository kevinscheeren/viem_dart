import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/siwe.dart';
import 'package:viem_dart/utils.dart';

void main() {
  final account = privateKeyToAccount(
    hexToBytes(
      padHex(
        '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
      ),
    ),
  );

  String buildMessage({String? domain, String? nonce, DateTime? issuedAt}) =>
      createSiweMessage(
        address: account.address,
        chainId: 1,
        domain: domain ?? 'example.com',
        nonce: nonce ?? 'abcd12345678',
        uri: 'https://example.com/login',
        issuedAt: issuedAt ?? DateTime.utc(2024),
      );

  group('verifySiweMessage', () {
    test('true for a genuinely signed, still-valid message', () {
      final message = buildMessage();
      final signature = signMessage(account, message: message);
      expect(verifySiweMessage(message, signature: signature), isTrue);
    });

    test('false when the signature is by a different account', () {
      final other = privateKeyToAccount(hexToBytes(padHex('0x1')));
      final message = buildMessage();
      final signature = signMessage(other, message: message);
      expect(verifySiweMessage(message, signature: signature), isFalse);
    });

    test('false when the message was tampered with after signing', () {
      final message = buildMessage();
      final signature = signMessage(account, message: message);
      final tampered = message.replaceFirst('example.com', 'evil.com');
      expect(verifySiweMessage(tampered, signature: signature), isFalse);
    });

    test('false when domain does not match the caller\'s expectation', () {
      final message = buildMessage();
      final signature = signMessage(account, message: message);
      expect(
        verifySiweMessage(message, signature: signature, domain: 'other.com'),
        isFalse,
      );
    });

    test('false when address does not match the caller\'s expectation', () {
      final message = buildMessage();
      final signature = signMessage(account, message: message);
      expect(
        verifySiweMessage(
          message,
          signature: signature,
          address: '0x000000000000000000000000000000000000dEaD',
        ),
        isFalse,
      );
    });

    test('true when address matches the caller\'s expectation', () {
      final message = buildMessage();
      final signature = signMessage(account, message: message);
      expect(
        verifySiweMessage(
          message,
          signature: signature,
          address: account.address,
        ),
        isTrue,
      );
    });

    test('false for an unparseable message', () {
      final signature = signMessage(account, message: 'not a siwe message');
      expect(
        verifySiweMessage('not a siwe message', signature: signature),
        isFalse,
      );
    });
  });
}
