import 'package:test/test.dart';
import 'package:viem_dart/src/client/converters.dart';

void main() {
  group('HexBigIntConverter', () {
    const converter = HexBigIntConverter();
    test('round-trips', () {
      expect(converter.fromJson('0x1a'), BigInt.from(26));
      expect(converter.toJson(BigInt.from(26)), '0x1a');
    });
  });

  group('HexBigIntNConverter', () {
    const converter = HexBigIntNConverter();
    test('passes through null', () {
      expect(converter.fromJson(null), isNull);
      expect(converter.toJson(null), isNull);
    });
    test('round-trips a value', () {
      expect(converter.fromJson('0x2a'), BigInt.from(42));
      expect(converter.toJson(BigInt.from(42)), '0x2a');
    });
  });

  group('HexIntConverter', () {
    const converter = HexIntConverter();
    test('round-trips', () {
      expect(converter.fromJson('0x10'), 16);
      expect(converter.toJson(16), '0x10');
    });
  });

  group('HexIntNConverter', () {
    const converter = HexIntNConverter();
    test('passes through null', () {
      expect(converter.fromJson(null), isNull);
      expect(converter.toJson(null), isNull);
    });
  });
}
