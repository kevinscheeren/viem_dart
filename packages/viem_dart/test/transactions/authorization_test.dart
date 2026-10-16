import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('Authorization', () {
    final unsigned = Authorization(
      chainId: BigInt.one,
      address: '0x0000000000000000000000000000000000000001',
      nonce: BigInt.zero,
    );

    test('defaults yParity/r/s to null when unsigned', () {
      expect(unsigned.yParity, isNull);
      expect(unsigned.r, isNull);
      expect(unsigned.s, isNull);
    });

    test('copyWith attaches a signature', () {
      final signed = unsigned.copyWith(
        yParity: 0,
        r: BigInt.two,
        s: BigInt.from(3),
      );
      expect(signed.yParity, 0);
      expect(signed.r, BigInt.two);
      expect(signed.s, BigInt.from(3));
      expect(
        unsigned.yParity,
        isNull,
        reason: 'copyWith must not mutate the original',
      );
    });

    test('supports value equality', () {
      final same = Authorization(
        chainId: BigInt.one,
        address: '0x0000000000000000000000000000000000000001',
        nonce: BigInt.zero,
      );
      expect(unsigned, same);
      expect(unsigned.hashCode, same.hashCode);
    });
  });
}
