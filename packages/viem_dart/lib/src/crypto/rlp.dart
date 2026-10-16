import 'dart:typed_data';

import '../utils/hex.dart';
import 'rlp_item.dart';

/// Encodes [item] per the RLP (Recursive Length Prefix) specification used
/// throughout Ethereum (transaction/block/trie serialization).
Uint8List encodeRlp(RlpItem item) {
  return switch (item) {
    RlpBytes(:final data) => _encodeBytes(data),
    RlpList(:final items) => _encodeList(items),
  };
}

Uint8List _encodeBytes(Uint8List data) {
  if (data.length == 1 && data[0] < 0x80) return data;
  return Uint8List.fromList([..._lengthPrefix(data.length, 0x80), ...data]);
}

Uint8List _encodeList(List<RlpItem> items) {
  final payload = items.expand(encodeRlp).toList();
  return Uint8List.fromList([
    ..._lengthPrefix(payload.length, 0xc0),
    ...payload,
  ]);
}

Uint8List _lengthPrefix(int length, int offset) {
  if (length < 56) return Uint8List.fromList([offset + length]);
  final lengthBytes = _minimalBigEndianBytes(length);
  return Uint8List.fromList([offset + 55 + lengthBytes.length, ...lengthBytes]);
}

Uint8List _minimalBigEndianBytes(int value) {
  if (value == 0) return Uint8List(0);
  final bytes = <int>[];
  var v = value;
  while (v > 0) {
    bytes.insert(0, v & 0xff);
    v >>= 8;
  }
  return Uint8List.fromList(bytes);
}

/// Decodes RLP-encoded [data] into an [RlpItem] tree.
RlpItem decodeRlp(Uint8List data) {
  final cursor = _Cursor(data);
  final item = _decodeItem(cursor);
  if (cursor.offset != data.length) {
    throw const FormatException('Invalid RLP: trailing bytes after decoding.');
  }
  return item;
}

class _Cursor {
  _Cursor(this.data);
  final Uint8List data;
  int offset = 0;
}

RlpItem _decodeItem(_Cursor cursor) {
  if (cursor.offset >= cursor.data.length) {
    throw const FormatException('Invalid RLP: unexpected end of input.');
  }
  final prefix = cursor.data[cursor.offset];

  if (prefix < 0x80) {
    cursor.offset += 1;
    return RlpItem.bytes(Uint8List.fromList([prefix]));
  }
  if (prefix < 0xb8) {
    cursor.offset += 1;
    return RlpItem.bytes(_readBytes(cursor, prefix - 0x80));
  }
  if (prefix < 0xc0) {
    cursor.offset += 1;
    final length = _readLength(cursor, prefix - 0xb7);
    return RlpItem.bytes(_readBytes(cursor, length));
  }
  if (prefix < 0xf8) {
    cursor.offset += 1;
    return RlpItem.list(_readItems(cursor, prefix - 0xc0));
  }
  cursor.offset += 1;
  final length = _readLength(cursor, prefix - 0xf7);
  return RlpItem.list(_readItems(cursor, length));
}

List<RlpItem> _readItems(_Cursor cursor, int payloadLength) {
  final end = cursor.offset + payloadLength;
  final items = <RlpItem>[];
  while (cursor.offset < end) {
    items.add(_decodeItem(cursor));
  }
  if (cursor.offset != end) {
    throw const FormatException('Invalid RLP: list length mismatch.');
  }
  return items;
}

Uint8List _readBytes(_Cursor cursor, int length) {
  if (cursor.offset + length > cursor.data.length) {
    throw const FormatException(
      'Invalid RLP: declared length exceeds available data.',
    );
  }
  final result = cursor.data.sublist(cursor.offset, cursor.offset + length);
  cursor.offset += length;
  return result;
}

int _readLength(_Cursor cursor, int lengthOfLength) {
  final lengthBytes = _readBytes(cursor, lengthOfLength);
  var length = 0;
  for (final b in lengthBytes) {
    length = (length << 8) | b;
  }
  return length;
}

/// Converts a non-negative [value] to its RLP-minimal big-endian byte
/// representation (no leading zero bytes; zero itself is the empty byte string).
Uint8List rlpBytesFromBigInt(BigInt value) {
  if (value.isNegative) {
    throw const FormatException('RLP cannot encode negative integers.');
  }
  if (value == BigInt.zero) return Uint8List(0);
  var hex = value.toRadixString(16);
  if (hex.length.isOdd) hex = '0$hex';
  return hexToBytes('0x$hex');
}

/// Inverse of [rlpBytesFromBigInt].
BigInt rlpBytesToBigInt(Uint8List bytes) {
  if (bytes.isEmpty) return BigInt.zero;
  return hexToBigInt(bytesToHex(bytes));
}
