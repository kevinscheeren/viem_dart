import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  final to = '0x0000000000000000000000000000000000000001';
  final accessList = [
    AccessListEntry(address: to, storageKeys: [Uint8List(32)]),
  ];
  final authorizationList = [
    Authorization(chainId: BigInt.one, address: to, nonce: BigInt.zero),
  ];

  group('TransactionEnvelope.legacy', () {
    final tx = TransactionEnvelope.legacy(
      nonce: BigInt.zero,
      gasPrice: BigInt.from(20000000000),
      gasLimit: BigInt.from(21000),
      to: to,
      value: BigInt.zero,
      data: Uint8List(0),
    );

    test('is unsigned by default', () {
      expect(tx.yParity, isNull);
      expect(tx.r, isNull);
      expect(tx.s, isNull);
      expect(tx.chainId, isNull);
    });

    test('copyWith attaches an EIP-155 signature', () {
      final signed = tx.copyWith(
        chainId: BigInt.one,
        yParity: 1,
        r: BigInt.two,
        s: BigInt.from(3),
      );
      expect(signed.chainId, BigInt.one);
      expect(signed.yParity, 1);
      expect(
        tx.chainId,
        isNull,
        reason: 'copyWith must not mutate the original',
      );
    });

    test('supports value equality', () {
      final same = TransactionEnvelope.legacy(
        nonce: BigInt.zero,
        gasPrice: BigInt.from(20000000000),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
      );
      expect(tx, same);
      expect(tx.hashCode, same.hashCode);
    });
  });

  group('TransactionEnvelope.eip2930', () {
    test('carries a required chainId and accessList', () {
      final tx = Eip2930Transaction(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        gasPrice: BigInt.from(20000000000),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: accessList,
      );
      expect(tx.chainId, BigInt.one);
      expect(tx.accessList, accessList);
    });
  });

  group('TransactionEnvelope.eip1559', () {
    test('carries maxPriorityFeePerGas/maxFeePerGas instead of gasPrice', () {
      final tx = Eip1559Transaction(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.from(1000000000),
        maxFeePerGas: BigInt.from(30000000000),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: accessList,
      );
      expect(tx.maxPriorityFeePerGas, BigInt.from(1000000000));
      expect(tx.maxFeePerGas, BigInt.from(30000000000));
    });
  });

  group('TransactionEnvelope.eip7702', () {
    test('carries an authorizationList', () {
      final tx = Eip7702Transaction(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.from(1000000000),
        maxFeePerGas: BigInt.from(30000000000),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: accessList,
        authorizationList: authorizationList,
      );
      expect(tx.authorizationList, authorizationList);
    });
  });

  group('TransactionEnvelope.eip4844', () {
    test('requires to and carries blob fields', () {
      final tx = Eip4844Transaction(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.from(1000000000),
        maxFeePerGas: BigInt.from(30000000000),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: accessList,
        maxFeePerBlobGas: BigInt.from(1),
        blobVersionedHashes: [Uint8List(32)],
      );
      expect(tx.to, to);
      expect(tx.maxFeePerBlobGas, BigInt.from(1));
      expect(tx.blobVersionedHashes, hasLength(1));
    });
  });

  group('sealed union pattern matching', () {
    TransactionEnvelope build(String kind) => switch (kind) {
      'legacy' => TransactionEnvelope.legacy(
        nonce: BigInt.zero,
        gasPrice: BigInt.one,
        gasLimit: BigInt.one,
        value: BigInt.zero,
        data: Uint8List(0),
      ),
      'eip2930' => TransactionEnvelope.eip2930(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        gasPrice: BigInt.one,
        gasLimit: BigInt.one,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: const [],
      ),
      'eip1559' => TransactionEnvelope.eip1559(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.one,
        maxFeePerGas: BigInt.one,
        gasLimit: BigInt.one,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: const [],
      ),
      'eip7702' => TransactionEnvelope.eip7702(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.one,
        maxFeePerGas: BigInt.one,
        gasLimit: BigInt.one,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: const [],
        authorizationList: const [],
      ),
      _ => TransactionEnvelope.eip4844(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.one,
        maxFeePerGas: BigInt.one,
        gasLimit: BigInt.one,
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: const [],
        maxFeePerBlobGas: BigInt.one,
        blobVersionedHashes: const [],
      ),
    };

    String describe(TransactionEnvelope tx) => switch (tx) {
      LegacyTransaction() => 'legacy',
      Eip2930Transaction() => 'eip2930',
      Eip1559Transaction() => 'eip1559',
      Eip7702Transaction() => 'eip7702',
      Eip4844Transaction() => 'eip4844',
    };

    for (final kind in ['legacy', 'eip2930', 'eip1559', 'eip7702', 'eip4844']) {
      test('exhaustively matches $kind', () {
        expect(describe(build(kind)), kind);
      });
    }
  });
}
