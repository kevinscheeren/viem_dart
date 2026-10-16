import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';

void main() {
  final account = privateKeyToAccount(
    hexToBytes(
      padHex(
        '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
      ),
    ),
  );

  group('hashEip191Message', () {
    test(
      'builds the "\\x19Ethereum Signed Message:\\n<length>" prefix per EIP-191',
      () {
        final messageBytes = Uint8List.fromList(utf8.encode('hello'));
        final expectedPrefixed = Uint8List.fromList([
          ...utf8.encode('\x19Ethereum Signed Message:\n5'),
          ...messageBytes,
        ]);
        expect(hashEip191Message(messageBytes), keccak256(expectedPrefixed));
      },
    );
  });

  group('signMessage', () {
    test('produces a signature that recovers back to the signer address', () {
      final signature = signMessage(account, message: 'hello world');
      final hash = hashEip191Message(
        Uint8List.fromList(utf8.encode('hello world')),
      );
      expect(recoverAddress(hash, signature), account.address);
    });

    test('signing raw data bytes works the same way as UTF-8 text', () {
      final text = 'hello world';
      final fromMessage = signMessage(account, message: text);
      final fromData = signMessage(
        account,
        data: Uint8List.fromList(utf8.encode(text)),
      );
      expect(fromMessage, fromData);
    });

    test('different messages produce different signatures', () {
      final a = signMessage(account, message: 'hello');
      final b = signMessage(account, message: 'goodbye');
      expect(a, isNot(b));
    });

    test('is deterministic for the same message', () {
      final a = signMessage(account, message: 'hello');
      final b = signMessage(account, message: 'hello');
      expect(a, b);
    });
  });
}
