import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/keccak.dart';

import '../utils/hex.dart';

/// Ethereum's Keccak-256 (the pre-NIST-finalization Keccak variant — NOT the
/// standardized SHA3-256, which uses different padding and produces a
/// different digest for the same input).
Uint8List keccak256(Uint8List input) {
  final digest = KeccakDigest(256);
  return digest.process(input);
}

/// Hashes UTF-8-encoded [value] with [keccak256] and returns it as hex.
String keccak256String(String value) =>
    bytesToHex(keccak256(Uint8List.fromList(utf8.encode(value))));

/// Hashes [hex] (decoded to bytes first) with [keccak256] and returns it as hex.
String keccak256Hex(String hex) => bytesToHex(keccak256(hexToBytes(hex)));
