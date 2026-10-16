import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';

void main() {
  final account = privateKeyToAccount(
    hexToBytes(
      padHex(
        '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
      ),
    ),
  );

  final domain = Eip712Domain(
    name: 'Ether Mail',
    version: '1',
    chainId: BigInt.one,
    verifyingContract: '0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC',
  );

  final types = {
    'Person': const [
      TypedDataField(name: 'name', type: 'string'),
      TypedDataField(name: 'wallet', type: 'address'),
    ],
    'Mail': const [
      TypedDataField(name: 'from', type: 'Person'),
      TypedDataField(name: 'to', type: 'Person'),
      TypedDataField(name: 'contents', type: 'string'),
    ],
  };

  final message = {
    'from': {
      'name': 'Cow',
      'wallet': '0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826',
    },
    'to': {
      'name': 'Bob',
      'wallet': '0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB',
    },
    'contents': 'Hello, Bob!',
  };

  group('recoverTypedDataAddress', () {
    test('recovers the signer address from a typed data signature', () {
      final signature = signTypedData(
        account,
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      expect(
        recoverTypedDataAddress(
          domain: domain,
          types: types,
          primaryType: 'Mail',
          message: message,
          signature: signature,
        ),
        account.address,
      );
    });

    test('recovers a different address when the message is tampered', () {
      final signature = signTypedData(
        account,
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      final tampered = {...message, 'contents': 'Goodbye, Bob!'};
      expect(
        recoverTypedDataAddress(
          domain: domain,
          types: types,
          primaryType: 'Mail',
          message: tampered,
          signature: signature,
        ),
        isNot(account.address),
      );
    });
  });

  group('verifyTypedData', () {
    test('returns true for a valid signature by the claimed address', () {
      final signature = signTypedData(
        account,
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      expect(
        verifyTypedData(
          address: account.address,
          domain: domain,
          types: types,
          primaryType: 'Mail',
          message: message,
          signature: signature,
        ),
        isTrue,
      );
    });

    test('returns false for a signature by a different address', () {
      final signature = signTypedData(
        account,
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      expect(
        verifyTypedData(
          address: '0x000000000000000000000000000000000000dEaD',
          domain: domain,
          types: types,
          primaryType: 'Mail',
          message: message,
          signature: signature,
        ),
        isFalse,
      );
    });
  });
}
