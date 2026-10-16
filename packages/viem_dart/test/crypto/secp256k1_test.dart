import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

Uint8List _privateKey(String hex) => hexToBytes(padHex(hex, size: 32));

void main() {
  group('privateKeyToAddress', () {
    // secp256k1's minimum valid scalar; address verified against the ISE.io
    // "Ethercombing" research paper, which documents this exact derivation.
    test('private key 1', () {
      final address = privateKeyToAddress(_privateKey('0x1'));
      expect(
        address.toLowerCase(),
        '0x7e5f4552091a69125d5dfcb7b8c2659029395bdf',
      );
    });

    // Hardhat/Anvil default Account #0 (mnemonic "test test test ... junk"),
    // verified against Hardhat's own docs for the address.
    test('Hardhat default Account #0', () {
      final address = privateKeyToAddress(
        _privateKey(
          '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
        ),
      );
      expect(
        address.toLowerCase(),
        '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266',
      );
    });

    test('rejects an out-of-range private key', () {
      expect(() => privateKeyToAddress(Uint8List(32)), throwsFormatException);
    });
  });

  group('sign / recoverPublicKey / recoverAddress', () {
    final privateKey = _privateKey(
      '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
    );
    final messageHash = keccak256(
      Uint8List.fromList(utf8.encode('hello world')),
    );

    test('is deterministic (RFC 6979)', () {
      final sig1 = sign(messageHash, privateKey);
      final sig2 = sign(messageHash, privateKey);
      expect(sig1, sig2);
    });

    test('produces a canonical low-s signature', () {
      final sig = sign(messageHash, privateKey);
      expect(sig.s <= secp256k1N ~/ BigInt.two, isTrue);
    });

    test('recoverPublicKey returns the signer\'s public key', () {
      final sig = sign(messageHash, privateKey);
      final expected = privateKeyToPublicKey(privateKey);
      final recovered = recoverPublicKey(messageHash, sig);
      expect(bytesToHex(recovered), bytesToHex(expected));
    });

    test('recoverAddress returns the signer\'s address', () {
      final sig = sign(messageHash, privateKey);
      final expected = privateKeyToAddress(privateKey);
      expect(recoverAddress(messageHash, sig), expected);
    });

    test('verify accepts a valid signature', () {
      final sig = sign(messageHash, privateKey);
      final publicKey = privateKeyToPublicKey(privateKey);
      expect(verify(messageHash, sig, publicKey), isTrue);
    });

    test('verify rejects a signature for a different message', () {
      final sig = sign(messageHash, privateKey);
      final publicKey = privateKeyToPublicKey(privateKey);
      final otherHash = keccak256(
        Uint8List.fromList(utf8.encode('goodbye world')),
      );
      expect(verify(otherHash, sig, publicKey), isFalse);
    });

    test(
      'a different private key produces a different signature and address',
      () {
        final otherKey = _privateKey('0x2');
        final sig = sign(messageHash, otherKey);
        expect(recoverAddress(messageHash, sig), privateKeyToAddress(otherKey));
        expect(
          recoverAddress(messageHash, sig),
          isNot(privateKeyToAddress(privateKey)),
        );
      },
    );
  });

  group('signatureToHex / hexToSignature', () {
    test('round-trips', () {
      final privateKey = _privateKey('0x1');
      final messageHash = keccak256(
        Uint8List.fromList(utf8.encode('round trip')),
      );
      final sig = sign(messageHash, privateKey);
      final roundTripped = hexToSignature(signatureToHex(sig));
      expect(roundTripped, sig);
    });

    test('produces exactly 65 bytes', () {
      final privateKey = _privateKey('0x1');
      final messageHash = keccak256(
        Uint8List.fromList(utf8.encode('length check')),
      );
      final sig = sign(messageHash, privateKey);
      expect(hexToBytes(signatureToHex(sig)).length, 65);
    });
  });

  group('signatureFromVComponents', () {
    test('accepts legacy v (27/28)', () {
      expect(signatureFromVComponents(BigInt.one, BigInt.two, 27).yParity, 0);
      expect(signatureFromVComponents(BigInt.one, BigInt.two, 28).yParity, 1);
    });
    test('accepts yParity (0/1) directly', () {
      expect(signatureFromVComponents(BigInt.one, BigInt.two, 0).yParity, 0);
      expect(signatureFromVComponents(BigInt.one, BigInt.two, 1).yParity, 1);
    });
    test('rejects an invalid recovery id', () {
      expect(
        () => signatureFromVComponents(BigInt.one, BigInt.two, 5),
        throwsFormatException,
      );
    });
  });
}
