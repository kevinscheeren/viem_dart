import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha3.dart';
import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('keccak256', () {
    // Verified against go-ethereum's crypto_test.go (TestKeccak256Hash),
    // the authoritative reference implementation.
    test('matches the known-good vector for "abc"', () {
      final input = Uint8List.fromList(utf8.encode('abc'));
      expect(
        bytesToHex(keccak256(input)),
        '0x4e03657aea45a94fc7d47ba826c8d667c0d1e6e33a64a036ec44f58fa12d6c45',
      );
    });

    test('keccak256String matches keccak256 of the UTF-8 bytes', () {
      expect(
        keccak256String('abc'),
        '0x4e03657aea45a94fc7d47ba826c8d667c0d1e6e33a64a036ec44f58fa12d6c45',
      );
    });

    // This is the guard test: pointycastle exposes both KeccakDigest and the
    // NIST-standardized SHA3Digest as distinct classes with different padding
    // (Keccak's original 0x01 vs NIST SHA-3's 0x06). Using the wrong one
    // silently produces wrong hashes with no error — assert they diverge.
    test('differs from NIST SHA3-256 for the same input', () {
      final input = Uint8List.fromList(utf8.encode('abc'));
      final keccakDigest = bytesToHex(keccak256(input));
      final sha3Digest = bytesToHex(SHA3Digest(256).process(input));
      expect(keccakDigest, isNot(equals(sha3Digest)));
    });
  });
}
