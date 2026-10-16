import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('getContractAddress (CREATE)', () {
    // From go-ethereum's crypto_test.go (TestNewContractAddress):
    // https://github.com/ethereum/go-ethereum/blob/master/crypto/crypto_test.go
    const sender = '0x970e8128ab834e8eac17ab8e3812f010678cf791';

    test('nonce 0', () {
      expect(
        isAddressEqual(
          getContractAddress(from: sender, nonce: BigInt.zero),
          '0x333c3310824b7c685133f2bedb2ca4b8b4df633d',
        ),
        isTrue,
      );
    });

    test('nonce 1', () {
      expect(
        isAddressEqual(
          getContractAddress(from: sender, nonce: BigInt.one),
          '0x8bda78331c916a08481428e4b07c96d3e916d165',
        ),
        isTrue,
      );
    });

    test('nonce 2', () {
      expect(
        isAddressEqual(
          getContractAddress(from: sender, nonce: BigInt.two),
          '0xc9ddedf451bc62ce88bf9292afb13df35b670699',
        ),
        isTrue,
      );
    });
  });

  group('getContractAddress (CREATE2)', () {
    // From EIP-1014's own "Examples" section: https://eips.ethereum.org/EIPS/eip-1014
    test('example 0: zero address/salt, init_code 0x00', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0x0000000000000000000000000000000000000000',
            salt:
                '0x0000000000000000000000000000000000000000000000000000000000000000',
            bytecode: '0x00',
          ),
          '0x4D1A2e2bB4F88F0250f26Ffff098B0b30B26BF38',
        ),
        isTrue,
      );
    });

    test('example 1: deadbeef sender, zero salt, init_code 0x00', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0xdeadbeef00000000000000000000000000000000',
            salt:
                '0x0000000000000000000000000000000000000000000000000000000000000000',
            bytecode: '0x00',
          ),
          '0xB928f69Bb1D91Cd65274e3c79d8986362984fDA3',
        ),
        isTrue,
      );
    });

    test('example 2: deadbeef sender, feed salt, init_code 0x00', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0xdeadbeef00000000000000000000000000000000',
            salt:
                '0x000000000000000000000000feed000000000000000000000000000000000000',
            bytecode: '0x00',
          ),
          '0xD04116cDd17beBE565EB2422F2497E06cC1C9833',
        ),
        isTrue,
      );
    });

    test('example 3: zero sender/salt, init_code 0xdeadbeef', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0x0000000000000000000000000000000000000000',
            salt:
                '0x0000000000000000000000000000000000000000000000000000000000000000',
            bytecode: '0xdeadbeef',
          ),
          '0x70f2b2914A2a4b783FaEFb75f459A580616Fcb5e',
        ),
        isTrue,
      );
    });

    test('example 4: deadbeef sender, cafebabe salt, init_code 0xdeadbeef', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0x00000000000000000000000000000000deadbeef',
            salt:
                '0x00000000000000000000000000000000000000000000000000000000cafebabe',
            bytecode: '0xdeadbeef',
          ),
          '0x60f3f640a8508fC6a86d45DF051962668E1e8AC7',
        ),
        isTrue,
      );
    });

    test('example 5: deadbeef sender, cafebabe salt, longer init_code', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0x00000000000000000000000000000000deadbeef',
            salt:
                '0x00000000000000000000000000000000000000000000000000000000cafebabe',
            bytecode:
                '0xdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef',
          ),
          '0x1d8bfDC5D46DC4f61D6b6115972536eBE6A8854C',
        ),
        isTrue,
      );
    });

    test('example 6: zero sender/salt, empty init_code', () {
      expect(
        isAddressEqual(
          getContractAddress(
            from: '0x0000000000000000000000000000000000000000',
            salt:
                '0x0000000000000000000000000000000000000000000000000000000000000000',
            bytecode: '0x',
          ),
          '0xE33C0C7F7df4809055C3ebA6c09CFe4BaF1BD9e0',
        ),
        isTrue,
      );
    });
  });

  group('getContractAddress argument validation', () {
    test('throws if neither nonce nor salt/bytecode are given', () {
      expect(
        () => getContractAddress(
          from: '0x0000000000000000000000000000000000000000',
        ),
        throwsArgumentError,
      );
    });

    test('throws if both nonce and salt/bytecode are given', () {
      expect(
        () => getContractAddress(
          from: '0x0000000000000000000000000000000000000000',
          nonce: BigInt.zero,
          salt:
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          bytecode: '0x00',
        ),
        throwsArgumentError,
      );
    });
  });
}
