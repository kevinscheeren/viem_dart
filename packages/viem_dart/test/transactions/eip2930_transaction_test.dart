import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // go-ethereum's own EIP-2930 test vector
  // (core/types/transaction_test.go, TestEIP2718TransactionEncode /
  // signedEip2718Tx), fetched directly from source (not summarized) and
  // byte-length-verified before use.
  final tx = Eip2930Transaction(
    chainId: BigInt.one,
    nonce: BigInt.from(3),
    gasPrice: BigInt.one,
    gasLimit: BigInt.from(25000),
    to: '0xb94f5374fce5edbc8e2a8697c15331677e6ebf0b',
    value: BigInt.from(10),
    data: hexToBytes('0x5544'),
    accessList: const [],
  );

  const signedHex =
      '0x01f8630103018261a894b94f5374fce5edbc8e2a8697c15331677e6ebf0b0a825'
      '544c001a0c9519f4f2b30335884581971573fadf60c6204f59a911df35ee8a5404'
      '56b2660a032f1e8e2c5dd761f9e4f88f41c8310aeaba26a8bfcdacfedfa12ec386'
      '2d37521';
  final signedR = BigInt.parse(
    'c9519f4f2b30335884581971573fadf60c6204f59a911df35ee8a540456b2660',
    radix: 16,
  );
  final signedS = BigInt.parse(
    '32f1e8e2c5dd761f9e4f88f41c8310aeaba26a8bfcdacfedfa12ec3862d37521',
    radix: 16,
  );

  group('serializeEip2930Transaction', () {
    test('encodes the type byte + RLP list for an unsigned transaction', () {
      final serialized = serializeEip2930Transaction(tx);
      expect(serialized[0], eip2930TransactionType);
      final decoded = decodeRlp(serialized.sublist(1)) as RlpList;
      expect(decoded.items, hasLength(8));
    });

    test('matches the go-ethereum vector once signed', () {
      final signed = tx.copyWith(yParity: 1, r: signedR, s: signedS);
      expect(bytesToHex(serializeEip2930Transaction(signed)), signedHex);
    });
  });

  group('signEip2930Transaction', () {
    test('recovers to the signer address after signing', () {
      final privateKey = hexToBytes(
        '0x0101010101010101010101010101010101010101010101010101010101010101',
      );
      final account = privateKeyToAccount(privateKey);
      final signed = signEip2930Transaction(tx, account);
      final hash = hashEip2930Transaction(signed);
      final recovered = recoverAddress(
        hash,
        Signature(r: signed.r!, s: signed.s!, yParity: signed.yParity!),
      );
      expect(recovered, account.address);
    });
  });

  group('parseEip2930Transaction', () {
    test('round-trips the go-ethereum signed vector', () {
      final parsed = parseEip2930Transaction(hexToBytes(signedHex));
      expect(parsed.chainId, BigInt.one);
      expect(parsed.nonce, BigInt.from(3));
      expect(parsed.gasPrice, BigInt.one);
      expect(parsed.gasLimit, BigInt.from(25000));
      expect(parsed.to, tx.to);
      expect(parsed.value, BigInt.from(10));
      expect(parsed.data, hexToBytes('0x5544'));
      expect(parsed.accessList, isEmpty);
      expect(parsed.yParity, 1);
      expect(parsed.r, signedR);
      expect(parsed.s, signedS);
    });

    test('round-trips a non-empty access list', () {
      final withAccessList = tx.copyWith(
        accessList: [
          AccessListEntry(
            address: '0xb94f5374fce5edbc8e2a8697c15331677e6ebf0b',
            storageKeys: [Uint8List(32)..[31] = 1],
          ),
        ],
      );
      final parsed = parseEip2930Transaction(
        serializeEip2930Transaction(withAccessList),
      );
      expect(parsed.accessList, hasLength(1));
      expect(parsed.accessList.first.address, withAccessList.to);
      expect(parsed.accessList.first.storageKeys.single[31], 1);
    });

    test('round-trips a contract-creation transaction (null to)', () {
      final creation = tx.copyWith(to: null);
      final parsed = parseEip2930Transaction(
        serializeEip2930Transaction(creation),
      );
      expect(parsed.to, isNull);
    });

    test('rejects a payload with the wrong type byte', () {
      final wrongType = Uint8List.fromList([0x02, ...hexToBytes('0xc0')]);
      expect(() => parseEip2930Transaction(wrongType), throwsFormatException);
    });
  });
}
