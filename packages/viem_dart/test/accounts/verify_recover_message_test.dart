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

  group('recoverMessageAddress', () {
    test('recovers the signer address from a text message signature', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        recoverMessageAddress(message: 'hello world', signature: signature),
        account.address,
      );
    });

    test('recovers the signer address from a raw data signature', () {
      final data = Uint8List.fromList(utf8.encode('hello world'));
      final signature = signMessage(account, data: data);
      expect(
        recoverMessageAddress(data: data, signature: signature),
        account.address,
      );
    });

    test('recovers a different address for a tampered message', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        recoverMessageAddress(message: 'goodbye', signature: signature),
        isNot(account.address),
      );
    });
  });

  group('verifyMessage', () {
    test('returns true for a valid signature by the claimed address', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        verifyMessage(
          address: account.address,
          message: 'hello world',
          signature: signature,
        ),
        isTrue,
      );
    });

    test('is case-insensitive on the address checksum', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        verifyMessage(
          address: account.address.toLowerCase(),
          message: 'hello world',
          signature: signature,
        ),
        isTrue,
      );
    });

    test('returns false for a signature by a different address', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        verifyMessage(
          address: '0x000000000000000000000000000000000000dEaD',
          message: 'hello world',
          signature: signature,
        ),
        isFalse,
      );
    });

    test('returns false when the message does not match', () {
      final signature = signMessage(account, message: 'hello world');
      expect(
        verifyMessage(
          address: account.address,
          message: 'goodbye',
          signature: signature,
        ),
        isFalse,
      );
    });
  });
}
