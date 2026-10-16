import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/utils.dart';

Uint8List _utf8(String s) => Uint8List.fromList(utf8.encode(s));

void main() {
  // Canonical vectors from the Ethereum wiki's RLP reference examples.
  group('encodeRlp', () {
    test('short string', () {
      expect(bytesToHex(encodeRlp(RlpItem.bytes(_utf8('dog')))), '0x83646f67');
    });

    test('single byte below 0x80 encodes as itself', () {
      expect(
        bytesToHex(encodeRlp(RlpItem.bytes(Uint8List.fromList([0x0f])))),
        '0x0f',
      );
    });

    test('empty string', () {
      expect(bytesToHex(encodeRlp(RlpItem.bytes(Uint8List(0)))), '0x80');
    });

    test('empty list', () {
      expect(bytesToHex(encodeRlp(const RlpItem.list([]))), '0xc0');
    });

    test('list of short strings', () {
      final item = RlpItem.list([
        RlpItem.bytes(_utf8('cat')),
        RlpItem.bytes(_utf8('dog')),
      ]);
      expect(bytesToHex(encodeRlp(item)), '0xc88363617483646f67');
    });

    test('long string (>55 bytes) uses the long-form length prefix', () {
      final longString = 'a' * 56;
      final encoded = encodeRlp(RlpItem.bytes(_utf8(longString)));
      // prefix 0xb8 (0xb7 + 1 length-of-length byte) + length byte (56) + payload.
      expect(encoded[0], 0xb8);
      expect(encoded[1], 56);
      expect(encoded.length, 2 + 56);
    });

    test('long list (>55 bytes payload) uses the long-form length prefix', () {
      final items = List.generate(20, (i) => RlpItem.bytes(_utf8('item$i')));
      final encoded = encodeRlp(RlpItem.list(items));
      expect(encoded[0], greaterThanOrEqualTo(0xf8));
    });
  });

  group('decodeRlp', () {
    test('round-trips short strings', () {
      final original = RlpItem.bytes(_utf8('dog'));
      expect(decodeRlp(encodeRlp(original)), original);
    });

    test('round-trips nested lists', () {
      final original = RlpItem.list([
        RlpItem.bytes(_utf8('cat')),
        RlpItem.list([RlpItem.bytes(_utf8('dog'))]),
        const RlpItem.list([]),
      ]);
      expect(decodeRlp(encodeRlp(original)), original);
    });

    test('round-trips long strings', () {
      final original = RlpItem.bytes(_utf8('a' * 100));
      expect(decodeRlp(encodeRlp(original)), original);
    });

    test('throws on trailing bytes', () {
      final encoded = Uint8List.fromList([
        ...encodeRlp(RlpItem.bytes(_utf8('dog'))),
        0x00,
      ]);
      expect(() => decodeRlp(encoded), throwsFormatException);
    });
  });

  group('rlpBytesFromBigInt / rlpBytesToBigInt', () {
    test('zero is the empty byte string', () {
      expect(rlpBytesFromBigInt(BigInt.zero), isEmpty);
      expect(
        bytesToHex(encodeRlp(RlpItem.bytes(rlpBytesFromBigInt(BigInt.zero)))),
        '0x80',
      );
    });

    test('1024 matches the canonical vector', () {
      final bytes = rlpBytesFromBigInt(BigInt.from(1024));
      expect(bytesToHex(encodeRlp(RlpItem.bytes(bytes))), '0x820400');
    });

    test('round-trips arbitrary values', () {
      final value = BigInt.parse('123456789012345678901234567890');
      expect(rlpBytesToBigInt(rlpBytesFromBigInt(value)), value);
    });

    test('rejects negative values', () {
      expect(() => rlpBytesFromBigInt(BigInt.from(-1)), throwsFormatException);
    });
  });
}
