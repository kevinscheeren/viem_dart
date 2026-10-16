import 'dart:typed_data';

import '../crypto/secp256k1.dart';
import 'account.dart';

/// Derives a [LocalAccount] (address + the private key itself) from a raw
/// 32-byte secp256k1 [privateKey].
LocalAccount privateKeyToAccount(Uint8List privateKey) => LocalAccount(
  address: privateKeyToAddress(privateKey),
  privateKey: privateKey,
);
