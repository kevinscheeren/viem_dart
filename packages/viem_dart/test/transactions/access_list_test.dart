import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('AccessListEntry', () {
    final entry = AccessListEntry(
      address: '0x0000000000000000000000000000000000000001',
      storageKeys: [Uint8List(32)],
    );

    test('exposes its fields', () {
      expect(entry.address, '0x0000000000000000000000000000000000000001');
      expect(entry.storageKeys, hasLength(1));
    });

    test('supports value equality', () {
      final same = AccessListEntry(
        address: '0x0000000000000000000000000000000000000001',
        storageKeys: [Uint8List(32)],
      );
      expect(entry, same);
      expect(entry.hashCode, same.hashCode);
    });

    test('supports copyWith', () {
      final copy = entry.copyWith(
        address: '0x0000000000000000000000000000000000000002',
      );
      expect(copy.address, '0x0000000000000000000000000000000000000002');
      expect(copy.storageKeys, entry.storageKeys);
    });
  });
}
