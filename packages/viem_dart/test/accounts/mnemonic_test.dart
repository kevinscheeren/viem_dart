import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';

void main() {
  group('generateMnemonic', () {
    test('produces a valid 12-word mnemonic by default', () {
      final mnemonic = generateMnemonic();
      expect(mnemonic.split(' '), hasLength(12));
      expect(isValidMnemonic(mnemonic), isTrue);
    });

    test('produces a valid 24-word mnemonic on request', () {
      final mnemonic = generateMnemonic(wordCount: 24);
      expect(mnemonic.split(' '), hasLength(24));
      expect(isValidMnemonic(mnemonic), isTrue);
    });

    test('generates different mnemonics on each call', () {
      expect(generateMnemonic(), isNot(generateMnemonic()));
    });
  });

  group('isValidMnemonic', () {
    test('rejects a mnemonic with a bad word', () {
      expect(
        isValidMnemonic('not a real bip39 mnemonic phrase at all here'),
        isFalse,
      );
    });

    test('accepts the well-known Hardhat/Anvil default test mnemonic', () {
      expect(
        isValidMnemonic(
          'test test test test test test test test test test test junk',
        ),
        isTrue,
      );
    });
  });

  group('mnemonicToSeed', () {
    test('produces a 64-byte seed', () {
      final seed = mnemonicToSeed(
        'test test test test test test test test test test test junk',
      );
      expect(seed.length, 64);
    });

    test('a passphrase changes the derived seed', () {
      const mnemonic =
          'test test test test test test test test test test test junk';
      final withoutPassphrase = mnemonicToSeed(mnemonic);
      final withPassphrase = mnemonicToSeed(mnemonic, passphrase: 'extra');
      expect(withoutPassphrase, isNot(withPassphrase));
    });

    test('is deterministic', () {
      const mnemonic =
          'test test test test test test test test test test test junk';
      expect(mnemonicToSeed(mnemonic), mnemonicToSeed(mnemonic));
    });
  });
}
