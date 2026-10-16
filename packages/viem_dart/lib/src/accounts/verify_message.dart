import 'dart:typed_data';

import '../crypto/signature.dart';
import '../utils/address.dart';
import 'recover_message_address.dart';

/// Verifies that [signature] over [message]/[data] was produced by
/// [address] — compares [recoverMessageAddress] against [address] via
/// [isAddressEqual]. Pass exactly one of [message]/[data].
bool verifyMessage({
  required String address,
  String? message,
  Uint8List? data,
  required Signature signature,
}) {
  final recovered = recoverMessageAddress(
    message: message,
    data: data,
    signature: signature,
  );
  return isAddressEqual(recovered, address);
}
