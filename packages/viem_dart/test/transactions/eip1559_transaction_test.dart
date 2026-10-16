import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // ethereum/tests' own TransactionTests fixture
  // (TransactionTests/ttEIP1559/GasLimitPriceProductOverflowtMinusOne.json),
  // fetched directly from source (not summarized), and its RLP structure
  // independently re-decoded field-by-field with a from-scratch parser
  // before use to rule out transcription corruption. `hash` is the
  // keccak256 of the full signed transaction bytes; `sender` is the
  // address the EF's own client-cross-validated suite asserts recovers
  // from the signature.
  const signedHex =
      '0x02f885018084773594009f02ffffffffffffffffffffffffffffffffffffffffffff'
      'ffffffffffffffff82520894095e7baea6a6c7c4c2dfeb977efac326af552d878080'
      'c080a05cbd172231fc0735e0fb994dd5b1a4939170a260b36f0427a8a80866b063b9'
      '48a07c230f7f578dd61785c93361b9871c0706ebfa6d06e3f4491dc9558c5202ed36';
  const expectedHash =
      '0xdad8bff3ecfcf95169b1d5625b47f3372be795802bc4fe570991cf332f609334';
  final expectedSender = getAddress(
    '0xae2aec498d20869d441eaaf708fb1e375ae1787d',
  );

  final tx = Eip1559Transaction(
    chainId: BigInt.one,
    nonce: BigInt.zero,
    maxPriorityFeePerGas: BigInt.from(2000000000),
    maxFeePerGas: BigInt.parse(
      '02ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      radix: 16,
    ),
    gasLimit: BigInt.from(21000),
    to: '0x095e7baea6a6c7c4c2dfeb977efac326af552d87',
    value: BigInt.zero,
    data: Uint8List(0),
    accessList: const [],
    yParity: 0,
    r: BigInt.parse(
      '5cbd172231fc0735e0fb994dd5b1a4939170a260b36f0427a8a80866b063b948',
      radix: 16,
    ),
    s: BigInt.parse(
      '7c230f7f578dd61785c93361b9871c0706ebfa6d06e3f4491dc9558c5202ed36',
      radix: 16,
    ),
  );

  group('serializeEip1559Transaction', () {
    test('encodes the type byte + RLP list for an unsigned transaction', () {
      final unsigned = tx.copyWith(yParity: null, r: null, s: null);
      final serialized = serializeEip1559Transaction(unsigned);
      expect(serialized[0], eip1559TransactionType);
      final decoded = decodeRlp(serialized.sublist(1)) as RlpList;
      expect(decoded.items, hasLength(9));
    });

    test('matches the ethereum/tests vector once signed', () {
      expect(bytesToHex(serializeEip1559Transaction(tx)), signedHex);
    });

    test('the signed encoding hashes to the vector\'s transaction hash', () {
      expect(
        bytesToHex(keccak256(serializeEip1559Transaction(tx))),
        expectedHash,
      );
    });
  });

  group('signEip1559Transaction / recovery', () {
    test('recovers to the vector\'s expected sender address', () {
      final hash = hashEip1559Transaction(tx);
      final recovered = recoverAddress(
        hash,
        Signature(r: tx.r!, s: tx.s!, yParity: tx.yParity!),
      );
      expect(recovered, expectedSender);
    });

    test(
      'signEip1559Transaction round-trips through hashEip1559Transaction',
      () {
        final privateKey = hexToBytes(
          '0x0101010101010101010101010101010101010101010101010101010101010101',
        );
        final account = privateKeyToAccount(privateKey);
        final unsigned = tx.copyWith(yParity: null, r: null, s: null);
        final signed = signEip1559Transaction(unsigned, account);
        final recovered = recoverAddress(
          hashEip1559Transaction(signed),
          Signature(r: signed.r!, s: signed.s!, yParity: signed.yParity!),
        );
        expect(recovered, account.address);
      },
    );
  });

  group('parseEip1559Transaction', () {
    test('round-trips the ethereum/tests signed vector', () {
      final parsed = parseEip1559Transaction(hexToBytes(signedHex));
      expect(parsed.chainId, tx.chainId);
      expect(parsed.nonce, tx.nonce);
      expect(parsed.maxPriorityFeePerGas, tx.maxPriorityFeePerGas);
      expect(parsed.maxFeePerGas, tx.maxFeePerGas);
      expect(parsed.gasLimit, tx.gasLimit);
      expect(parsed.to, tx.to);
      expect(parsed.value, tx.value);
      expect(parsed.data, isEmpty);
      expect(parsed.accessList, isEmpty);
      expect(parsed.yParity, tx.yParity);
      expect(parsed.r, tx.r);
      expect(parsed.s, tx.s);
    });

    test('round-trips a non-empty access list', () {
      final withAccessList = tx.copyWith(
        accessList: [
          AccessListEntry(
            address: '0x095e7baea6a6c7c4c2dfeb977efac326af552d87',
            storageKeys: [Uint8List(32)..[31] = 7],
          ),
        ],
      );
      final parsed = parseEip1559Transaction(
        serializeEip1559Transaction(withAccessList),
      );
      expect(parsed.accessList, hasLength(1));
      expect(parsed.accessList.first.storageKeys.single[31], 7);
    });

    test('round-trips a contract-creation transaction (null to)', () {
      final creation = tx.copyWith(to: null);
      final parsed = parseEip1559Transaction(
        serializeEip1559Transaction(creation),
      );
      expect(parsed.to, isNull);
    });

    test('rejects a payload with the wrong type byte', () {
      final wrongType = Uint8List.fromList([0x01, ...hexToBytes('0xc0')]);
      expect(() => parseEip1559Transaction(wrongType), throwsFormatException);
    });
  });
}
