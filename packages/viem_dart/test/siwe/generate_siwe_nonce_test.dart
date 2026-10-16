import 'package:test/test.dart';
import 'package:viem_dart/siwe.dart';

final RegExp _nonceRegExp = RegExp(r'^[a-zA-Z0-9]{8,}$');

void main() {
  group('generateSiweNonce', () {
    test('produces a 96-character string satisfying the EIP-4361 nonce '
        'format (alphanumeric, at least 8 characters)', () {
      final nonce = generateSiweNonce();
      expect(nonce, hasLength(96));
      expect(_nonceRegExp.hasMatch(nonce), isTrue);
    });

    test('is different on every call', () {
      final nonces = List.generate(20, (_) => generateSiweNonce());
      expect(nonces.toSet(), hasLength(20));
    });
  });
}
