import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';

/// DNS wire-format-encodes [name] (RFC 1035-style packet encoding, as ENS's
/// Universal Resolver requires for its `resolve`/`reverse` calls): each
/// dot-separated label is prefixed by its UTF-8 byte length, terminated by
/// a zero-length byte.
///
/// A label whose UTF-8 encoding would exceed DNS's 255-byte label limit is
/// replaced by its bracketed labelhash (`[keccak256(label)]`) instead, per
/// ENS convention — this is a rare edge case (labels this long essentially
/// never occur in practice), not the common path.
///
/// [name] is used exactly as given — call `normalize` first if it might
/// not already be in ENS normalized form.
Uint8List dnsEncodeName(String name) {
  final value = name.replaceAll(RegExp(r'^\.+|\.+$'), '');
  if (value.isEmpty) return Uint8List(1);

  final labels = value.split('.');
  final encodedLabels = labels.map((label) {
    var bytes = Uint8List.fromList(utf8.encode(label));
    if (bytes.length > 255) {
      bytes = Uint8List.fromList(utf8.encode(_encodeLabelhash(label)));
    }
    return bytes;
  }).toList();

  final totalLength =
      encodedLabels.fold<int>(0, (sum, l) => sum + l.length + 1) + 1;
  final result = Uint8List(totalLength);
  var offset = 0;
  for (final label in encodedLabels) {
    result[offset] = label.length;
    result.setRange(offset + 1, offset + 1 + label.length, label);
    offset += label.length + 1;
  }
  // result[offset] is already 0 (the terminator), left at Uint8List's
  // default zero-fill.
  return result;
}

/// `[<hex keccak256 of label's UTF-8 bytes, no 0x prefix>]` — ENS's
/// escape hatch for a label too long to DNS-encode directly.
String _encodeLabelhash(String label) {
  final hash = keccak256(Uint8List.fromList(utf8.encode(label)));
  final hex = hash.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '[$hex]';
}
