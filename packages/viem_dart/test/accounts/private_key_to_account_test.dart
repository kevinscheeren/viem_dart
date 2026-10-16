import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('privateKeyToAccount', () {
    test('derives the correct address (Hardhat default Account #0)', () {
      final privateKey = hexToBytes(
        padHex(
          '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
        ),
      );
      final account = privateKeyToAccount(privateKey);
      expect(
        account.address.toLowerCase(),
        '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266',
      );
      expect(account.privateKey, privateKey);
    });

    test('is a LocalAccount variant of Account', () {
      final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
      expect(account, isA<LocalAccount>());
      expect(account, isA<Account>());
    });
  });
}
