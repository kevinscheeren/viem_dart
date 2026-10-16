import 'dart:typed_data';

import 'package:pointycastle/api.dart'
    show PrivateKeyParameter, PublicKeyParameter;
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart' show ECDSASigner;

import '../utils/address.dart';
import '../utils/hex.dart';
import 'keccak.dart';
import 'signature.dart';

final ECDomainParameters _params = ECCurve_secp256k1();

/// The order of the secp256k1 curve's base point — the number of valid
/// private key / signature-scalar values (`r`, `s` are taken mod this).
final BigInt secp256k1N = _params.n;

BigInt _bytesToBigInt(Uint8List bytes) => hexToBigInt(bytesToHex(bytes));

void _assertPrivateKeyInRange(BigInt d) {
  if (d <= BigInt.zero || d >= secp256k1N) {
    throw FormatException('Private key out of range for secp256k1.');
  }
}

/// Derives the public key point for [privateKey] (32 bytes) and serializes
/// it — uncompressed (`0x04 || X || Y`, 65 bytes) by default, or compressed
/// (`0x02`/`0x03 || X`, 33 bytes) with `compressed: true`.
Uint8List privateKeyToPublicKey(
  Uint8List privateKey, {
  bool compressed = false,
}) {
  final d = _bytesToBigInt(privateKey);
  _assertPrivateKeyInRange(d);
  final point = (_params.G * d)!;
  return point.getEncoded(compressed);
}

/// Derives the (EIP-55 checksummed) Ethereum address for [privateKey].
String privateKeyToAddress(Uint8List privateKey) =>
    _addressFromPublicKey(privateKeyToPublicKey(privateKey));

String _addressFromPublicKey(Uint8List uncompressedPublicKey) {
  final hash = keccak256(uncompressedPublicKey.sublist(1));
  return getAddress(bytesToHex(hash.sublist(12)));
}

/// Signs a 32-byte [messageHash] with [privateKey] using RFC 6979
/// deterministic `k` (HMAC-SHA256), matching libsecp256k1/Ethereum's
/// convention — the same nonce function every EVM signature uses,
/// independent of Keccak-256 being the hash used to produce [messageHash].
///
/// Normalizes to canonical low-`s` form (required by Ethereum to prevent
/// signature malleability) and determines the correct recovery id by
/// testing which candidate recovers back to [privateKey]'s own public key.
Signature sign(Uint8List messageHash, Uint8List privateKey) {
  if (messageHash.length != 32) {
    throw FormatException(
      'messageHash must be 32 bytes, got ${messageHash.length}.',
    );
  }
  final d = _bytesToBigInt(privateKey);
  _assertPrivateKeyInRange(d);

  final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
  signer.init(true, PrivateKeyParameter(ECPrivateKey(d, _params)));
  final raw = signer.generateSignature(messageHash) as ECSignature;

  var s = raw.s;
  if (s > secp256k1N ~/ BigInt.two) {
    s = secp256k1N - s;
  }
  final r = raw.r;

  final expectedPublicKey = privateKeyToPublicKey(privateKey);
  for (final candidate in [0, 1]) {
    final recovered = _recoverPublicKeyPoint(messageHash, r, s, candidate);
    if (recovered != null &&
        bytesToHex(recovered.getEncoded(false)) ==
            bytesToHex(expectedPublicKey)) {
      return Signature(r: r, s: s, yParity: candidate);
    }
  }
  throw StateError('Failed to determine signature recovery id.');
}

/// Verifies that [signature] over [messageHash] was produced by the holder
/// of [publicKey] (compressed or uncompressed).
bool verify(Uint8List messageHash, Signature signature, Uint8List publicKey) {
  final point = _params.curve.decodePoint(publicKey);
  if (point == null) return false;
  final signer = ECDSASigner(null);
  signer.init(false, PublicKeyParameter(ECPublicKey(point, _params)));
  return signer.verifySignature(
    messageHash,
    ECSignature(signature.r, signature.s),
  );
}

/// Recovers the public key that produced [signature] over [messageHash].
Uint8List recoverPublicKey(
  Uint8List messageHash,
  Signature signature, {
  bool compressed = false,
}) {
  final point = _recoverPublicKeyPoint(
    messageHash,
    signature.r,
    signature.s,
    signature.yParity,
  );
  if (point == null) {
    throw const FormatException(
      'Could not recover a public key for this signature.',
    );
  }
  return point.getEncoded(compressed);
}

/// Recovers the (EIP-55 checksummed) address that produced [signature] over
/// [messageHash].
String recoverAddress(Uint8List messageHash, Signature signature) =>
    _addressFromPublicKey(recoverPublicKey(messageHash, signature));

ECPoint? _recoverPublicKeyPoint(
  Uint8List messageHash,
  BigInt r,
  BigInt s,
  int yParity,
) {
  final n = secp256k1N;
  if (r <= BigInt.zero || r >= n) return null;
  if (s <= BigInt.zero || s >= n) return null;

  final ECPoint pointR;
  try {
    pointR = _params.curve.decompressPoint(yParity, r);
  } on ArgumentError {
    return null;
  }

  final e = _bytesToBigInt(messageHash);
  final rInv = r.modInverse(n);
  final u1 = ((-e) % n * rInv) % n;
  final u2 = (s * rInv) % n;

  final point = (_params.G * u1)! + (pointR * u2)!;
  if (point == null || point.isInfinity) return null;
  return point;
}
