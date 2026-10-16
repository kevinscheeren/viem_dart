import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/hex.dart';

part 'signature.freezed.dart';

/// An ECDSA signature over secp256k1: `r`, `s`, and the recovery id
/// (`yParity`, 0 or 1) needed to recover the signer's public key.
@freezed
abstract class Signature with _$Signature {
  const Signature._();

  /// Creates a signature from its raw ECDSA components.
  const factory Signature({
    required BigInt r,
    required BigInt s,
    required int yParity,
  }) = _Signature;

  /// The legacy `v` value (27/28), derived from [yParity].
  int get v => yParity + 27;
}

/// Builds a [Signature] from a `v` value in either the yParity (0/1) or
/// legacy (27/28) convention.
Signature signatureFromVComponents(BigInt r, BigInt s, int v) {
  final yParity = v >= 27 ? v - 27 : v;
  if (yParity != 0 && yParity != 1) {
    throw FormatException('Invalid recovery id `$v`.');
  }
  return Signature(r: r, s: s, yParity: yParity);
}

/// Serializes [signature] as 65 bytes: `r` (32) || `s` (32) || legacy `v` (1).
String signatureToHex(Signature signature) {
  final rHex = bigIntToHex(signature.r, size: 32).substring(2);
  final sHex = bigIntToHex(signature.s, size: 32).substring(2);
  final vHex = signature.v.toRadixString(16).padLeft(2, '0');
  return '0x$rHex$sHex$vHex';
}

/// Inverse of [signatureToHex].
Signature hexToSignature(String hex) {
  final bytes = hexToBytes(hex);
  if (bytes.length != 65) {
    throw FormatException(
      'Signature hex must decode to 65 bytes (r, s, v), got ${bytes.length}.',
    );
  }
  final r = hexToBigInt(bytesToHex(bytes.sublist(0, 32)));
  final s = hexToBigInt(bytesToHex(bytes.sublist(32, 64)));
  return signatureFromVComponents(r, s, bytes[64]);
}
