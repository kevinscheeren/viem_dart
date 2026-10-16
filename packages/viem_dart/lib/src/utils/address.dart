import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';
import 'hex.dart';

final RegExp _addressPattern = RegExp(r'^0x[0-9a-fA-F]{40}$');

/// Whether [value] has the shape of an Ethereum address (`0x` + 40 hex
/// digits). Does not validate an EIP-55 checksum — use [isAddressEqual]
/// (case-insensitive) or compare against [getAddress] to check that.
bool isAddress(String value) => _addressPattern.hasMatch(value);

/// Whether [a] and [b] refer to the same address, ignoring checksum casing.
bool isAddressEqual(String a, String b) {
  if (!isAddress(a) || !isAddress(b)) {
    throw FormatException('`$a` or `$b` is not a valid address.');
  }
  return a.toLowerCase() == b.toLowerCase();
}

/// Returns [address] with EIP-55 checksum casing applied.
///
/// Throws if [address] isn't a validly shaped 20-byte hex address.
String getAddress(String address) {
  if (!isAddress(address)) {
    throw FormatException('`$address` is not a valid address.');
  }
  final lower = address.toLowerCase().substring(2);
  final hash = bytesToHex(
    keccak256(Uint8List.fromList(utf8.encode(lower))),
  ).substring(2);

  final buffer = StringBuffer('0x');
  for (var i = 0; i < lower.length; i++) {
    final char = lower[i];
    final isLetter = int.parse(char, radix: 16) > 9;
    if (isLetter && int.parse(hash[i], radix: 16) >= 8) {
      buffer.write(char.toUpperCase());
    } else {
      buffer.write(char);
    }
  }
  return buffer.toString();
}
