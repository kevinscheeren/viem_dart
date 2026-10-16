import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart' as bc;

import 'account.dart';
import 'mnemonic.dart';
import 'private_key_to_account.dart';

/// BIP-44's change-chain selector: [receiving] is chain `0` (the default —
/// almost always what's used for Ethereum, unlike Bitcoin-style wallets
/// that also actively use a distinct "change" chain); [internal] is
/// chain `1`.
enum Bip44Change { receiving, internal }

/// Derives a [LocalAccount] from a BIP-39/32 [seed] via Ethereum's standard
/// BIP-44 path `m/44'/60'/{accountIndex}'/{change}/{addressIndex}`.
///
/// Uses `package:blockchain_utils` for the HD key-tree walk (HMAC-SHA512 +
/// secp256k1 point derivation per BIP-32/44 — non-trivial to safely
/// reimplement, so not hand-rolled here), then
/// hands the resulting raw private key to this package's own
/// [privateKeyToAccount] (keccak256 + secp256k1, already tested)
/// to derive the address — keeping the address-derivation trust surface
/// centered on code this package already owns and has tested.
LocalAccount hdKeyToAccount(
  Uint8List seed, {
  int accountIndex = 0,
  Bip44Change change = Bip44Change.receiving,
  int addressIndex = 0,
}) {
  final bipChange = change == Bip44Change.receiving
      ? bc.Bip44Changes.chainExt
      : bc.Bip44Changes.chainInt;
  final derived = bc.Bip44.fromSeed(seed, bc.Bip44Coins.ethereum).purpose.coin
      .account(accountIndex)
      .change(bipChange)
      .addressIndex(addressIndex);
  return privateKeyToAccount(Uint8List.fromList(derived.privateKey.raw));
}

/// Derives a [LocalAccount] directly from a BIP-39 [mnemonic] phrase (and
/// optional [passphrase]) via [mnemonicToSeed] + [hdKeyToAccount].
LocalAccount mnemonicToAccount(
  String mnemonic, {
  String passphrase = '',
  int accountIndex = 0,
  Bip44Change change = Bip44Change.receiving,
  int addressIndex = 0,
}) => hdKeyToAccount(
  mnemonicToSeed(mnemonic, passphrase: passphrase),
  accountIndex: accountIndex,
  change: change,
  addressIndex: addressIndex,
);
