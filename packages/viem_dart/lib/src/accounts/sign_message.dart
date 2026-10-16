import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import '../crypto/signature.dart';
import 'account.dart';

/// Hashes [message] (UTF-8 text) or raw [data] per EIP-191's "personal
/// sign" scheme (`"\x19Ethereum Signed Message:\n" + length + message`,
/// then keccak256) and signs it with [account]'s private key. Pass exactly
/// one of [message]/[data].
Signature signMessage(
  LocalAccount account, {
  String? message,
  Uint8List? data,
}) {
  assert(
    (message == null) != (data == null),
    'Pass exactly one of message or data.',
  );
  final messageBytes = data ?? Uint8List.fromList(utf8.encode(message!));
  final hash = hashEip191Message(messageBytes);
  return secp256k1.sign(hash, account.privateKey);
}

/// The EIP-191 "personal sign" digest of [messageBytes]:
/// `keccak256("\x19Ethereum Signed Message:\n" + messageBytes.length + messageBytes)`.
Uint8List hashEip191Message(Uint8List messageBytes) {
  final prefix = utf8.encode(
    '\x19Ethereum Signed Message:\n${messageBytes.length}',
  );
  return keccak256(Uint8List.fromList([...prefix, ...messageBytes]));
}
