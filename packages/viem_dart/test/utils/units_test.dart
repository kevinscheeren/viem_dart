import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('parseEther / formatEther', () {
    test('whole amounts', () {
      expect(parseEther('1'), BigInt.parse('1000000000000000000'));
      expect(formatEther(BigInt.parse('1000000000000000000')), '1');
    });
    test('fractional amounts', () {
      expect(parseEther('1.5'), BigInt.parse('1500000000000000000'));
      expect(formatEther(BigInt.parse('1500000000000000000')), '1.5');
    });
    test('negative amounts', () {
      expect(parseEther('-1.5'), BigInt.parse('-1500000000000000000'));
      expect(formatEther(BigInt.parse('-1500000000000000000')), '-1.5');
    });
  });

  group('parseGwei / formatGwei', () {
    test('round-trips', () {
      expect(parseGwei('1'), BigInt.from(1000000000));
      expect(formatGwei(BigInt.from(1000000000)), '1');
    });
  });

  group('parseUnits', () {
    test('pads short fractional parts', () {
      expect(parseUnits('1.5', 6), BigInt.from(1500000));
    });
    test('rounds half-up on excess precision', () {
      expect(parseUnits('1.23456789', 6), BigInt.from(1234568));
    });
    test('rounds down when the truncated digit is below 5', () {
      expect(parseUnits('1.23456449', 6), BigInt.from(1234564));
    });
    test('handles a bare integer', () {
      expect(parseUnits('42', 6), BigInt.from(42000000));
    });
    test('rejects malformed decimals', () {
      expect(() => parseUnits('1.2.3', 6), throwsFormatException);
    });
  });

  group('formatUnits', () {
    test('trims trailing fractional zeros', () {
      expect(formatUnits(BigInt.from(1500000), 6), '1.5');
      expect(formatUnits(BigInt.from(1000000), 6), '1');
    });
    test('handles values smaller than one unit', () {
      expect(formatUnits(BigInt.from(1), 6), '0.000001');
    });
  });
}
