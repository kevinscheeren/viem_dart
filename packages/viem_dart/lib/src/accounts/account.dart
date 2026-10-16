import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

/// An account that can sign: either [LocalAccount] (holds a private key
/// directly, matching `privateKeyToAccount`/`mnemonicToAccount`) or
/// [JsonRpcAccount] (delegates signing to a remote provider/wallet by
/// `address` — e.g. an injected wallet reached over `eth_sign`/
/// `eth_sendTransaction`, not something this package signs locally).
@freezed
sealed class Account with _$Account {
  /// An account backed by a locally-held private key.
  const factory Account.local({
    required String address,
    required Uint8List privateKey,
  }) = LocalAccount;

  /// An account whose signing is delegated to a remote provider/wallet.
  const factory Account.jsonRpc({required String address}) = JsonRpcAccount;
}
