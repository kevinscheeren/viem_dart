import 'dart:convert';
import 'dart:typed_data';

/// Direction to pad or trim a hex string.
enum PadDirection { left, right }

final RegExp _strictHexPattern = RegExp(r'^0x[0-9a-fA-F]*$');

/// Whether [value] is a `0x`-prefixed hex string.
///
/// With [strict] (the default), every character after `0x` must be a hex
/// digit; with `strict: false`, only the `0x` prefix is checked.
bool isHex(String value, {bool strict = true}) {
  if (!value.startsWith('0x')) return false;
  if (!strict) return true;
  return _strictHexPattern.hasMatch(value);
}

/// Throws a [FormatException] if [hex] isn't a `0x`-prefixed hex string.
void assertHex(String hex) {
  if (!isHex(hex, strict: false)) {
    throw FormatException('Value `$hex` is not a valid hex string.');
  }
}

/// Number of bytes represented by [hex] (rounding up on an odd digit count).
int hexSize(String hex) {
  assertHex(hex);
  return (hex.length - 2 + 1) ~/ 2;
}

/// Pads [hex] with zeros until it represents [size] bytes.
///
/// Numeric values are conventionally left-padded (padding doesn't change
/// their value); byte/string data is conventionally right-padded (padding
/// doesn't change the leading, meaningful bytes).
String padHex(
  String hex, {
  int size = 32,
  PadDirection dir = PadDirection.left,
}) {
  assertHex(hex);
  final digits = hex.substring(2);
  if (digits.length > size * 2) {
    throw FormatException(
      'Hex value `$hex` is ${hexSize(hex)} bytes, exceeds padding size of $size bytes.',
    );
  }
  final padding = '0' * (size * 2 - digits.length);
  final padded = dir == PadDirection.left
      ? '$padding$digits'
      : '$digits$padding';
  return '0x$padded';
}

/// Removes leading (or, with `dir: PadDirection.right`, trailing) zero
/// digits from [hex], keeping at least one digit.
String trimHex(String hex, {PadDirection dir = PadDirection.left}) {
  assertHex(hex);
  final digits = hex.substring(2);
  final trimmed = dir == PadDirection.left
      ? digits.replaceFirst(RegExp(r'^0+(?!$)'), '')
      : digits.replaceFirst(RegExp(r'(?<!^)0+$'), '');
  return '0x$trimmed';
}

/// Concatenates [values] (already `0x`-prefixed hex strings) into one hex string.
String concatHex(List<String> values) {
  final buffer = StringBuffer('0x');
  for (final value in values) {
    assertHex(value);
    buffer.write(value.substring(2));
  }
  return buffer.toString();
}

/// Converts [bytes] to a `0x`-prefixed lowercase hex string, optionally
/// right-padded to [size] bytes.
String bytesToHex(Uint8List bytes, {int? size}) {
  final buffer = StringBuffer('0x');
  for (final byte in bytes) {
    buffer.write(byte.toRadixString(16).padLeft(2, '0'));
  }
  final hex = buffer.toString();
  return size != null ? padHex(hex, size: size, dir: PadDirection.right) : hex;
}

/// Decodes [hex] into bytes, optionally right-padded (with zero bytes) to [size].
Uint8List hexToBytes(String hex, {int? size}) {
  assertHex(hex);
  var digits = hex.substring(2);
  if (digits.length.isOdd) digits = '0$digits';
  final decoded = Uint8List(digits.length ~/ 2);
  for (var i = 0; i < decoded.length; i++) {
    decoded[i] = int.parse(digits.substring(i * 2, i * 2 + 2), radix: 16);
  }
  if (size == null) return decoded;
  if (decoded.length > size) {
    throw FormatException(
      'Hex value `$hex` is ${decoded.length} bytes, exceeds size of $size bytes.',
    );
  }
  final padded = Uint8List(size);
  padded.setRange(0, decoded.length, decoded);
  return padded;
}

/// Converts a [BigInt] to hex, optionally padded/validated against [size] bytes.
///
/// Negative values require `signed: true` and a [size], and are encoded as
/// [size]-byte two's complement.
String bigIntToHex(BigInt value, {int? size, bool signed = false}) {
  var v = value;
  if (v.isNegative) {
    if (!signed || size == null) {
      throw FormatException(
        'Cannot represent negative value `$value` as unsigned hex; pass signed: true with a size.',
      );
    }
    final max = (BigInt.one << (size * 8 - 1)) - BigInt.one;
    final min = -(BigInt.one << (size * 8 - 1));
    if (v > max || v < min) {
      throw FormatException(
        'Value `$value` is out of range for a $size-byte signed integer.',
      );
    }
    v += BigInt.one << (size * 8);
  }
  final result = '0x${v.toRadixString(16)}';
  return size != null ? padHex(result, size: size) : result;
}

/// Converts [hex] to a [BigInt]. With `signed: true`, interprets the value as
/// two's complement over its byte length.
BigInt hexToBigInt(String hex, {bool signed = false}) {
  assertHex(hex);
  final digits = hex.substring(2);
  if (digits.isEmpty) return BigInt.zero;
  var value = BigInt.parse(digits, radix: 16);
  if (signed) {
    final bitLength = ((digits.length + 1) ~/ 2) * 8;
    final signBit = BigInt.one << (bitLength - 1);
    if (value >= signBit) {
      value -= BigInt.one << bitLength;
    }
  }
  return value;
}

/// Converts an [int] to hex. See [bigIntToHex] for [size]/[signed] semantics.
String intToHex(int value, {int? size, bool signed = false}) =>
    bigIntToHex(BigInt.from(value), size: size, signed: signed);

/// Converts [hex] to an [int]. See [hexToBigInt] for [signed] semantics.
int hexToInt(String hex, {bool signed = false}) =>
    hexToBigInt(hex, signed: signed).toInt();

/// UTF-8 encodes [value] and returns it as hex, optionally right-padded to [size] bytes.
String stringToHex(String value, {int? size}) =>
    bytesToHex(Uint8List.fromList(utf8.encode(value)), size: size);

/// Decodes [hex] as UTF-8 text, dropping any trailing zero-byte padding.
String hexToString(String hex, {int? size}) {
  final bytes = hexToBytes(hex, size: size);
  var end = bytes.length;
  while (end > 0 && bytes[end - 1] == 0) {
    end--;
  }
  return utf8.decode(bytes.sublist(0, end));
}

/// Converts a [bool] to hex (`0x0` or `0x1`), optionally left-padded to [size] bytes.
String boolToHex(bool value, {int? size}) {
  final hex = value ? '0x1' : '0x0';
  return size != null ? padHex(hex, size: size) : hex;
}

/// Converts [hex] to a [bool]. Only `0x0`/`0x1` (after trimming leading
/// zeros) are valid.
bool hexToBool(String hex) {
  final trimmed = trimHex(hex);
  if (trimmed == '0x0') return false;
  if (trimmed == '0x1') return true;
  throw FormatException('Hex value `$hex` is not a valid boolean.');
}
