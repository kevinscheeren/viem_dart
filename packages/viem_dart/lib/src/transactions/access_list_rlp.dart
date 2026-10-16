import 'dart:typed_data';

import '../crypto/rlp_item.dart';
import '../utils/hex.dart';
import 'access_list.dart';

/// RLP-encodes [accessList] as EIP-2930 defines it: a list of
/// `[address, [storageKey, ...]]` entries. Shared by every typed
/// transaction that carries an access list (EIP-2930 onward).
RlpItem encodeAccessListRlp(List<AccessListEntry> accessList) => RlpItem.list(
  accessList
      .map(
        (entry) => RlpItem.list([
          RlpItem.bytes(hexToBytes(entry.address)),
          RlpItem.list(entry.storageKeys.map(RlpItem.bytes).toList()),
        ]),
      )
      .toList(),
);

/// Inverse of [encodeAccessListRlp].
List<AccessListEntry> decodeAccessListRlp(RlpItem item) {
  if (item is! RlpList) {
    throw const FormatException('Invalid access list: expected an RLP list.');
  }
  return item.items.map((entryItem) {
    if (entryItem is! RlpList || entryItem.items.length != 2) {
      throw const FormatException(
        'Invalid access list entry: expected a 2-element RLP list.',
      );
    }
    final address = bytesToHex(bytesOfRlpItem(entryItem.items[0]));
    final keysItem = entryItem.items[1];
    if (keysItem is! RlpList) {
      throw const FormatException(
        'Invalid access list entry: expected a storage-keys RLP list.',
      );
    }
    return AccessListEntry(
      address: address,
      storageKeys: keysItem.items.map(bytesOfRlpItem).toList(),
    );
  }).toList();
}

/// Extracts the byte string from an [RlpItem] expected to be a leaf
/// (`RlpBytes`), throwing if it's actually a nested list.
Uint8List bytesOfRlpItem(RlpItem item) => switch (item) {
  RlpBytes(:final data) => data,
  RlpList() => throw const FormatException(
    'Invalid transaction field: expected a byte string, got a list.',
  ),
};
