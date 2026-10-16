import 'dart:math';

final Random _random = Random.secure();

/// Generates a random EIP-4361 nonce: a 96-character lowercase-hex string
/// (48 bytes of entropy from [Random.secure]) — the same length as viem's
/// own `generateSiweNonce()` default, comfortably over the EIP's own
/// `>=8`-alphanumeric-character minimum. viem's JS implementation buffers
/// random bytes for its own performance reasons (`utils/uid.ts`); that
/// buffering is a JS-side optimization, not part of the contract, so it's
/// not reproduced here.
String generateSiweNonce() {
  final buffer = StringBuffer();
  for (var i = 0; i < 48; i++) {
    buffer.write(_random.nextInt(256).toRadixString(16).padLeft(2, '0'));
  }
  return buffer.toString();
}
