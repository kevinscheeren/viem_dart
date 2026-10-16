import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('isAddress', () {
    test('accepts a validly shaped address', () {
      expect(isAddress('0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'), isTrue);
    });
    test('rejects the wrong length or missing prefix', () {
      expect(isAddress('0x5aAeb6'), isFalse);
      expect(isAddress('5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'), isFalse);
    });
  });

  group('isAddressEqual', () {
    test('ignores checksum casing', () {
      expect(
        isAddressEqual(
          '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
          '0x5aaeb6053f3e94c9b9a09f33669435e7ef1beaed',
        ),
        isTrue,
      );
    });
  });

  // Official test vectors from EIP-55 (https://eips.ethereum.org/EIPS/eip-55).
  group('getAddress (EIP-55 checksum)', () {
    const vectors = [
      '0x52908400098527886E0F7030069857D2E4169EE7',
      '0x8617E340B3D01FA5F11F306F4090FD50E238070D',
      '0xde709f2102306220921060314715629080e2fb77',
      '0x27b1fdb04752bbc536007a920d24acb045561c26',
      '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
      '0xdbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB',
      '0xD1220A0cf47c7B9Be7A2E6BA89F429762e7b9aDb',
    ];

    for (final expected in vectors) {
      test('checksums $expected from lowercase input', () {
        expect(getAddress(expected.toLowerCase()), expected);
      });

      test('is idempotent for $expected', () {
        expect(getAddress(expected), expected);
      });
    }

    test('rejects an invalidly shaped address', () {
      expect(() => getAddress('0x1234'), throwsFormatException);
    });
  });
}
