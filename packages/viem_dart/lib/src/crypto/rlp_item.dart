import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rlp_item.freezed.dart';

/// A node in an RLP (Recursive Length Prefix) tree: either a byte string or
/// an ordered list of further [RlpItem]s.
@freezed
sealed class RlpItem with _$RlpItem {
  /// A single RLP byte-string leaf.
  const factory RlpItem.bytes(Uint8List data) = RlpBytes;

  /// An ordered list of RLP items.
  const factory RlpItem.list(List<RlpItem> items) = RlpList;
}
