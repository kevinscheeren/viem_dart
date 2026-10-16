/// Converts a decimal-string ether amount (e.g. `"1.5"`) to wei.
BigInt parseEther(String value) => parseUnits(value, 18);

/// Converts a decimal-string gwei amount to wei.
BigInt parseGwei(String value) => parseUnits(value, 9);

/// Converts a decimal-string [value] to its integer representation with
/// [decimals] decimal places, rounding half-up if [value] has more
/// fractional digits than [decimals].
BigInt parseUnits(String value, int decimals) {
  var v = value.trim();
  var negative = false;
  if (v.startsWith('-')) {
    negative = true;
    v = v.substring(1);
  }

  final parts = v.split('.');
  if (parts.length > 2) {
    throw FormatException('Invalid decimal value `$value`.');
  }

  final integerPart = parts[0].isEmpty ? '0' : parts[0];
  var fractionPart = parts.length > 1 ? parts[1] : '';

  BigInt result;
  if (fractionPart.length > decimals) {
    final roundingDigit = fractionPart.codeUnitAt(decimals) - '0'.codeUnitAt(0);
    fractionPart = fractionPart.substring(0, decimals);
    result = BigInt.parse('$integerPart$fractionPart');
    if (roundingDigit >= 5) result += BigInt.one;
  } else {
    fractionPart = fractionPart.padRight(decimals, '0');
    result = BigInt.parse('$integerPart$fractionPart');
  }

  return negative ? -result : result;
}

/// Converts a wei amount to a decimal-string ether amount.
String formatEther(BigInt value) => formatUnits(value, 18);

/// Converts a wei amount to a decimal-string gwei amount.
String formatGwei(BigInt value) => formatUnits(value, 9);

/// Converts an integer [value] with [decimals] decimal places to a
/// decimal-string, trimming trailing fractional zeros.
String formatUnits(BigInt value, int decimals) {
  final negative = value.isNegative;
  final magnitude = negative ? -value : value;

  final digits = magnitude.toString().padLeft(decimals + 1, '0');
  final integerPart = digits.substring(0, digits.length - decimals);
  final fractionPart = digits
      .substring(digits.length - decimals)
      .replaceFirst(RegExp(r'0+$'), '');

  final result = fractionPart.isEmpty
      ? integerPart
      : '$integerPart.$fractionPart';
  return negative ? '-$result' : result;
}
