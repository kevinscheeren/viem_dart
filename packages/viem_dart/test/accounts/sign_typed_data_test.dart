import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';

// The canonical "Mail" example from the EIP-712 spec's reference
// Example.sol, verified against two independent fetches of the source.
const _expectedDomainSeparator =
    '0xf2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090f';
const _expectedMailHash =
    '0xc52c0ee5d84264471806290a3f2c4cecfc5490626bf912d01f240d7a274b371e';

void main() {
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

  group('hashTypedDataDomain', () {
    test('matches the EIP-712 spec Example.sol DOMAIN_SEPARATOR', () {
      expect(bytesToHex(hashTypedDataDomain(domain)), _expectedDomainSeparator);
    });
  });

  group('hashTypedDataStruct', () {
    test('matches the EIP-712 spec Example.sol hash(mail)', () {
      expect(
        bytesToHex(hashTypedDataStruct('Mail', types, message)),
        _expectedMailHash,
      );
    });
  });

  group('hashTypedData', () {
    test('combines "\\x19\\x01" + domainSeparator + messageHash', () {
      final domainSeparator = hexToBytes(_expectedDomainSeparator);
      final messageHash = hexToBytes(_expectedMailHash);
      final expected = keccak256(
        Uint8List.fromList([0x19, 0x01, ...domainSeparator, ...messageHash]),
      );

      final digest = hashTypedData(
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      expect(digest, expected);
    });
  });

  group('signTypedData', () {
    test('produces a signature that recovers back to the signer address', () {
      final account = privateKeyToAccount(
        hexToBytes(
          padHex(
            '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
          ),
        ),
      );
      final signature = signTypedData(
        account,
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      final digest = hashTypedData(
        domain: domain,
        types: types,
        primaryType: 'Mail',
        message: message,
      );
      expect(recoverAddress(digest, signature), account.address);
    });
  });
}
