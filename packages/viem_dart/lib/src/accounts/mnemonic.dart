import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';

/// Generates a new random BIP-39 mnemonic phrase ([wordCount] words — 12 or
/// 24; BIP-39 also permits 15/18/21, exposed here as the two conventional
/// choices).
String generateMnemonic({int wordCount = 12}) {
  final wordsNum = wordCount == 24
      ? Bip39WordsNum.wordsNum24
      : Bip39WordsNum.wordsNum12;
  return Bip39MnemonicGenerator().fromWordsNumber(wordsNum).toStr();
}

/// Whether [mnemonic] is a well-formed BIP-39 phrase (valid wordlist
/// membership and checksum).
bool isValidMnemonic(String mnemonic) =>
    Bip39MnemonicValidator().isValid(mnemonic);

/// Derives the 64-byte BIP-39 seed for [mnemonic] (PBKDF2-HMAC-SHA512, 2048
/// iterations, salted with `"mnemonic" + passphrase`).
Uint8List mnemonicToSeed(String mnemonic, {String passphrase = ''}) =>
    Uint8List.fromList(
      Bip39SeedGenerator(
        Bip39Mnemonic.fromString(mnemonic),
      ).generate(passphrase),
    );
