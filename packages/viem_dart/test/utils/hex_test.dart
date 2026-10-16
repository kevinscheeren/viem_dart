import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

void main() {
  group('isHex', () {
    test('accepts 0x-prefixed hex', () {
      expect(isHex('0x1a2b'), isTrue);
      expect(isHex('0x'), isTrue);
    });
    test('rejects non-hex', () {
      expect(isHex('1a2b'), isFalse);
      expect(isHex('0xzz'), isFalse);
    });
    test('non-strict only checks the prefix', () {
      expect(isHex('0xzz', strict: false), isTrue);
    });
  });

  group('hexSize', () {
    test('rounds up on odd digit counts', () {
      expect(hexSize('0x1'), 1);
      expect(hexSize('0x12'), 1);
      expect(hexSize('0x123'), 2);
    });
  });

  group('padHex', () {
    test('left-pads by default', () {
      expect(padHex('0x1', size: 4), '0x00000001');
    });
    test('right-pads on request', () {
      expect(padHex('0x1', size: 4, dir: PadDirection.right), '0x10000000');
    });
    test('throws when the value exceeds the target size', () {
      expect(() => padHex('0x1234567890', size: 2), throwsFormatException);
    });
  });

  group('trimHex', () {
    test('trims leading zeros by default', () {
      expect(trimHex('0x00000001'), '0x1');
    });
    test('trims trailing zeros on request', () {
      expect(trimHex('0x10000000', dir: PadDirection.right), '0x1');
    });
    test('keeps at least one digit', () {
      expect(trimHex('0x00000000'), '0x0');
    });
  });

  group('concatHex', () {
    test('joins hex values', () {
      expect(concatHex(['0x12', '0x34', '0xff']), '0x1234ff');
    });
  });

  group('bytesToHex / hexToBytes', () {
    test('round-trips', () {
      final bytes = Uint8List.fromList([1, 2, 3, 255]);
      expect(bytesToHex(bytes), '0x010203ff');
      expect(hexToBytes('0x010203ff'), bytes);
    });
    test('bytesToHex right-pads to size', () {
      expect(bytesToHex(Uint8List.fromList([1]), size: 4), '0x01000000');
    });
    test('hexToBytes right-pads (zero-fills) to size', () {
      expect(hexToBytes('0x01', size: 4), Uint8List.fromList([1, 0, 0, 0]));
    });
  });

  group('bigIntToHex / hexToBigInt', () {
    test('round-trips unsigned values', () {
      expect(bigIntToHex(BigInt.from(255)), '0xff');
      expect(hexToBigInt('0xff'), BigInt.from(255));
    });
    test('left-pads to size', () {
      expect(bigIntToHex(BigInt.from(255), size: 4), '0x000000ff');
    });
    test('encodes negative values as twos-complement with signed+size', () {
      expect(bigIntToHex(BigInt.from(-1), size: 1, signed: true), '0xff');
      expect(hexToBigInt('0xff', signed: true), BigInt.from(-1));
    });
    test('rejects negative values without signed', () {
      expect(() => bigIntToHex(BigInt.from(-1)), throwsFormatException);
    });
  });

  group('intToHex / hexToInt', () {
    test('round-trips', () {
      expect(intToHex(1024), '0x400');
      expect(hexToInt('0x400'), 1024);
    });
  });

  group('stringToHex / hexToString', () {
    test('round-trips', () {
      expect(stringToHex('hello'), '0x68656c6c6f');
      expect(hexToString('0x68656c6c6f'), 'hello');
    });
    test('round-trips through zero-padding', () {
      final padded = stringToHex('hi', size: 32);
      expect(hexToString(padded), 'hi');
    });
  });

  group('boolToHex / hexToBool', () {
    test('round-trips', () {
      expect(boolToHex(true), '0x1');
      expect(boolToHex(false), '0x0');
      expect(hexToBool('0x1'), isTrue);
      expect(hexToBool('0x0'), isFalse);
    });
    test('rejects invalid boolean hex', () {
      expect(() => hexToBool('0x2'), throwsFormatException);
    });
  });
}
