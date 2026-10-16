import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';

void main() {
  // Hardhat/Anvil's default mnemonic — same one independently confirmed
  // against Hardhat's own docs (address) and a web search cross-reference
  // (private key).
  const hardhatMnemonic =
      'test test test test test test test test test test test junk';

  group('mnemonicToAccount', () {
    test('derives Hardhat/Anvil default Account #0 at the default path', () {
      final account = mnemonicToAccount(hardhatMnemonic);
      expect(
        account.address.toLowerCase(),
        '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266',
      );
    });

    test('different address indices derive different accounts', () {
      final account0 = mnemonicToAccount(hardhatMnemonic);
      final account1 = mnemonicToAccount(hardhatMnemonic, addressIndex: 1);
      expect(account0.address, isNot(account1.address));
    });

    test('different account indices derive different accounts', () {
      final account0 = mnemonicToAccount(hardhatMnemonic);
      final account1 = mnemonicToAccount(hardhatMnemonic, accountIndex: 1);
      expect(account0.address, isNot(account1.address));
    });

    test('internal vs receiving change chain derives different accounts', () {
      final receiving = mnemonicToAccount(hardhatMnemonic);
      final internal = mnemonicToAccount(
        hardhatMnemonic,
        change: Bip44Change.internal,
      );
      expect(receiving.address, isNot(internal.address));
    });

    test('is deterministic', () {
      expect(
        mnemonicToAccount(hardhatMnemonic).address,
        mnemonicToAccount(hardhatMnemonic).address,
      );
    });
  });

  group('hdKeyToAccount', () {
    test('matches mnemonicToAccount when given the same seed', () {
      final seed = mnemonicToSeed(hardhatMnemonic);
      final fromSeed = hdKeyToAccount(seed);
      final fromMnemonic = mnemonicToAccount(hardhatMnemonic);
      expect(fromSeed.address, fromMnemonic.address);
      expect(fromSeed.privateKey, fromMnemonic.privateKey);
    });
  });
}
