import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // Independently generated with Python's eth-account 0.13.7 (the
  // audited, widely-used reference implementation `Account.sign_authorization`
  // + `Account.sign_transaction` for EIP-7702) using private keys
  // 0x01*32 (sender) and 0x02*32 (authority). Cross-checked two further
  // ways before use: the raw transaction bytes were independently
  // re-decoded field-by-field with a from-scratch RLP parser, and
  // `authorization_hash` was independently recomputed via a from-scratch
  // RLP encoder + keccak256(0x05 || ...) — both matched exactly.
  const senderPrivateKeyHex =
      '0x0101010101010101010101010101010101010101010101010101010101010101';
  const authorityPrivateKeyHex =
      '0x0202020202020202020202020202020202020202020202020202020202020202';
  const delegateAddress = '0x000000000000000000000000000000000000c0de';
  const toAddress = '0x000000000000000000000000000000000000bEEF';

  const signedHex =
      '0x04f8ca0180843b9aca008504a817c800830186a094000000000000000000000000'
      '000000000000beef8080c0f85cf85a0194000000000000000000000000000000000'
      '000c0de8080a0e07b293b8d68eb0c24cf97ff6e094475104ded8bb5e0c60594415ff'
      '04eaf6e72a05c3ebc414ea86fd2aa6606b80b211526299d4fb694b93cfa52e1cce44'
      '81d784e80a082bc6394d27ce3e3a3f1d357470933029abd22143595291ebc8bdde43'
      'deaed02a06c82abca968c060b0931de493fac5fd0b1e2d785dece501c515cfe2c980'
      '6a37a';
  const expectedTxHash =
      '0xa20ba5f6addb31db53dd6ff20eb17eb5f860bc193450c76005d37b56fbebbd85';
  const expectedAuthorizationHash =
      '0xef1b8d3feeb6ac8f9d509a9e90d9f2d0dc255230d2e8f1a1949ad2a94f93d7bd';

  final signedAuthorization = Authorization(
    chainId: BigInt.one,
    address: delegateAddress,
    nonce: BigInt.zero,
    yParity: 0,
    r: BigInt.parse(
      'e07b293b8d68eb0c24cf97ff6e094475104ded8bb5e0c60594415ff04eaf6e72',
      radix: 16,
    ),
    s: BigInt.parse(
      '5c3ebc414ea86fd2aa6606b80b211526299d4fb694b93cfa52e1cce4481d784e',
      radix: 16,
    ),
  );

  final tx = Eip7702Transaction(
    chainId: BigInt.one,
    nonce: BigInt.zero,
    maxPriorityFeePerGas: BigInt.from(1000000000),
    maxFeePerGas: BigInt.from(20000000000),
    gasLimit: BigInt.from(100000),
    to: toAddress,
    value: BigInt.zero,
    data: Uint8List(0),
    accessList: const [],
    authorizationList: [signedAuthorization],
    yParity: 0,
    r: BigInt.parse(
      '82bc6394d27ce3e3a3f1d357470933029abd22143595291ebc8bdde43deaed02',
      radix: 16,
    ),
    s: BigInt.parse(
      '6c82abca968c060b0931de493fac5fd0b1e2d785dece501c515cfe2c9806a37a',
      radix: 16,
    ),
  );

  group('hashAuthorization / signAuthorization', () {
    test('matches the eth-account authorization_hash vector', () {
      final unsigned = Authorization(
        chainId: BigInt.one,
        address: delegateAddress,
        nonce: BigInt.zero,
      );
      expect(
        bytesToHex(hashAuthorization(unsigned)),
        expectedAuthorizationHash,
      );
    });

    test('signAuthorization reproduces the eth-account r/s/yParity', () {
      final unsigned = Authorization(
        chainId: BigInt.one,
        address: delegateAddress,
        nonce: BigInt.zero,
      );
      final account = privateKeyToAccount(hexToBytes(authorityPrivateKeyHex));
      final signed = signAuthorization(unsigned, account);
      expect(signed.yParity, signedAuthorization.yParity);
      expect(signed.r, signedAuthorization.r);
      expect(signed.s, signedAuthorization.s);
    });
  });

  group('serializeEip7702Transaction', () {
    test('encodes the type byte + RLP list for an unsigned transaction', () {
      final unsigned = tx.copyWith(yParity: null, r: null, s: null);
      final serialized = serializeEip7702Transaction(unsigned);
      expect(serialized[0], eip7702TransactionType);
      final decoded = decodeRlp(serialized.sublist(1)) as RlpList;
      expect(decoded.items, hasLength(10));
    });

    test('matches the eth-account vector once signed', () {
      expect(bytesToHex(serializeEip7702Transaction(tx)), signedHex);
    });

    test('the signed encoding hashes to the vector\'s transaction hash', () {
      expect(
        bytesToHex(keccak256(serializeEip7702Transaction(tx))),
        expectedTxHash,
      );
    });
  });

  group('signEip7702Transaction', () {
    test('reproduces the eth-account r/s/yParity via RFC 6979 determinism', () {
      final account = privateKeyToAccount(hexToBytes(senderPrivateKeyHex));
      final unsigned = tx.copyWith(yParity: null, r: null, s: null);
      final signed = signEip7702Transaction(unsigned, account);
      expect(signed.yParity, tx.yParity);
      expect(signed.r, tx.r);
      expect(signed.s, tx.s);
    });
  });

  group('parseEip7702Transaction', () {
    test('round-trips the eth-account signed vector', () {
      final parsed = parseEip7702Transaction(hexToBytes(signedHex));
      expect(parsed.chainId, tx.chainId);
      expect(parsed.nonce, tx.nonce);
      expect(parsed.maxPriorityFeePerGas, tx.maxPriorityFeePerGas);
      expect(parsed.maxFeePerGas, tx.maxFeePerGas);
      expect(parsed.gasLimit, tx.gasLimit);
      expect(parsed.to, tx.to!.toLowerCase());
      expect(parsed.value, tx.value);
      expect(parsed.data, isEmpty);
      expect(parsed.accessList, isEmpty);
      expect(parsed.authorizationList, hasLength(1));
      final parsedAuth = parsed.authorizationList.single;
      expect(parsedAuth.chainId, signedAuthorization.chainId);
      expect(parsedAuth.address, signedAuthorization.address);
      expect(parsedAuth.nonce, signedAuthorization.nonce);
      expect(parsedAuth.yParity, signedAuthorization.yParity);
      expect(parsedAuth.r, signedAuthorization.r);
      expect(parsedAuth.s, signedAuthorization.s);
      expect(parsed.yParity, tx.yParity);
      expect(parsed.r, tx.r);
      expect(parsed.s, tx.s);
    });

    test('round-trips a contract-creation transaction (null to)', () {
      final creation = tx.copyWith(to: null);
      final parsed = parseEip7702Transaction(
        serializeEip7702Transaction(creation),
      );
      expect(parsed.to, isNull);
    });

    test('rejects a payload with the wrong type byte', () {
      final wrongType = Uint8List.fromList([0x02, ...hexToBytes('0xc0')]);
      expect(() => parseEip7702Transaction(wrongType), throwsFormatException);
    });
  });
}
