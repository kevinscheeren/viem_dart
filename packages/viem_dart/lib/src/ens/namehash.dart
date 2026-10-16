import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';
import '../utils/hex.dart';

/// Computes the ENS namehash of [name] per ERC-137: starting from 32 zero
/// bytes, each dot-separated label is hashed right-to-left —
/// `node = keccak256(node + keccak256(label))` — producing a unique,
/// fixed-length "node" for any domain.
///
/// Operates on [name] exactly as given; it does not normalize it. Call
/// `normalize` first if [name] might not already be in ENS normalized
/// form (mixed case, confusable characters, etc.) — hashing an
/// unnormalized name silently produces the wrong node.
String namehash(String name) {
  if (name.isEmpty) return bytesToHex(Uint8List(32));

  var node = Uint8List(32);
  final labels = name.split('.');
  for (final label in labels.reversed) {
    final labelHash = keccak256(Uint8List.fromList(utf8.encode(label)));
    node = keccak256(Uint8List.fromList([...node, ...labelHash]));
  }
  return bytesToHex(node);
}
