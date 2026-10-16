import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_list.freezed.dart';

/// One entry of an EIP-2930 access list: an address and the storage slots
/// (each a 32-byte key) a transaction pre-declares it will touch.
@freezed
abstract class AccessListEntry with _$AccessListEntry {
  /// Creates an [AccessListEntry] for [address] and its [storageKeys].
  const factory AccessListEntry({
    required String address,
    required List<Uint8List> storageKeys,
  }) = _AccessListEntry;
}
