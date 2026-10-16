import 'dart:convert';
import 'dart:typed_data';

import '../crypto/secp256k1.dart' as secp256k1;
import '../crypto/signature.dart';
import 'sign_message.dart';

/// Recovers the (EIP-55 checksummed) address that produced [signature] over
/// [message] (UTF-8 text) or raw [data] per EIP-191 — the reverse of
/// [signMessage]. Pass exactly one of [message]/[data].
String recoverMessageAddress({
  String? message,
  Uint8List? data,
  required Signature signature,
}) {
  assert(
    (message == null) != (data == null),
    'Pass exactly one of message or data.',
  );
  final messageBytes = data ?? Uint8List.fromList(utf8.encode(message!));
  return secp256k1.recoverAddress(hashEip191Message(messageBytes), signature);
}
