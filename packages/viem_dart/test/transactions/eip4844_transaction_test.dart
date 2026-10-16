import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // Independently generated with Python's eth-account 0.13.7 (the
  // audited, widely-used reference implementation's
  // `Account.sign_transaction` for EIP-4844's consensus/canonical
  // encoding — no blob sidecar) using private key 0x01*32. Cross-checked
  // by independently re-decoding the raw bytes field-by-field with a
  // from-scratch RLP parser, and by independently recomputing
  // keccak256(rawBytes) with a separate library (pycryptodome) — both
  // matched exactly.
  const senderPrivateKeyHex =
      '0x0101010101010101010101010101010101010101010101010101010101010101';
  const toAddress = '0x000000000000000000000000000000000000bEEF';
  final blobVersionedHash = hexToBytes(
    '0x01aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  );

  const signedHex =
      '0x03f8930180843b9aca008504a817c800825208940000000000000000000000000000'
      '00000000beef8080c085174876e800e1a001aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa01a02b4d04bdc98824bec53c6b0c968cf92724'
      'f3d635978e2919071b84a0031bbc28a009fe07f52ba6dd6659c40a1d120a08a2172c'
      '08aa9ebcf6df6349c9d19dbca588';
  const expectedTxHash =
      '0xbb8462bae244b7429b80c48ace165647c6eed3e8a5229dd103c5a07d92afd8aa';

  final tx = Eip4844Transaction(
    chainId: BigInt.one,
    nonce: BigInt.zero,
    maxPriorityFeePerGas: BigInt.from(1000000000),
    maxFeePerGas: BigInt.from(20000000000),
    gasLimit: BigInt.from(21000),
    to: toAddress,
    value: BigInt.zero,
    data: Uint8List(0),
    accessList: const [],
    maxFeePerBlobGas: BigInt.from(100000000000),
    blobVersionedHashes: [blobVersionedHash],
    yParity: 1,
    r: BigInt.parse(
      '2b4d04bdc98824bec53c6b0c968cf92724f3d635978e2919071b84a0031bbc28',
      radix: 16,
    ),
    s: BigInt.parse(
      '09fe07f52ba6dd6659c40a1d120a08a2172c08aa9ebcf6df6349c9d19dbca588',
      radix: 16,
    ),
  );

  group('serializeEip4844Transaction', () {
    test('encodes the type byte + RLP list for an unsigned transaction', () {
      final unsigned = tx.copyWith(yParity: null, r: null, s: null);
      final serialized = serializeEip4844Transaction(unsigned);
      expect(serialized[0], eip4844TransactionType);
      final decoded = decodeRlp(serialized.sublist(1)) as RlpList;
      expect(decoded.items, hasLength(11));
    });

    test('matches the eth-account vector once signed', () {
      expect(bytesToHex(serializeEip4844Transaction(tx)), signedHex);
    });

    test('the signed encoding hashes to the vector\'s transaction hash', () {
      expect(
        bytesToHex(keccak256(serializeEip4844Transaction(tx))),
        expectedTxHash,
      );
    });
  });

  group('signEip4844Transaction / recovery', () {
    test('reproduces the eth-account r/s/yParity via RFC 6979 determinism', () {
      final account = privateKeyToAccount(hexToBytes(senderPrivateKeyHex));
      final unsigned = tx.copyWith(yParity: null, r: null, s: null);
      final signed = signEip4844Transaction(unsigned, account);
      expect(signed.yParity, tx.yParity);
      expect(signed.r, tx.r);
      expect(signed.s, tx.s);
    });

    test('recovers to the signer address', () {
      final account = privateKeyToAccount(hexToBytes(senderPrivateKeyHex));
      final hash = hashEip4844Transaction(tx);
      final recovered = recoverAddress(
        hash,
        Signature(r: tx.r!, s: tx.s!, yParity: tx.yParity!),
      );
      expect(recovered, account.address);
    });
  });

  group('parseEip4844Transaction', () {
    test('round-trips the eth-account signed vector', () {
      final parsed = parseEip4844Transaction(hexToBytes(signedHex));
      expect(parsed.chainId, tx.chainId);
      expect(parsed.nonce, tx.nonce);
      expect(parsed.maxPriorityFeePerGas, tx.maxPriorityFeePerGas);
      expect(parsed.maxFeePerGas, tx.maxFeePerGas);
      expect(parsed.gasLimit, tx.gasLimit);
      expect(parsed.to, tx.to.toLowerCase());
      expect(parsed.value, tx.value);
      expect(parsed.data, isEmpty);
      expect(parsed.accessList, isEmpty);
      expect(parsed.maxFeePerBlobGas, tx.maxFeePerBlobGas);
      expect(parsed.blobVersionedHashes, hasLength(1));
      expect(parsed.blobVersionedHashes.single, blobVersionedHash);
      expect(parsed.yParity, tx.yParity);
      expect(parsed.r, tx.r);
      expect(parsed.s, tx.s);
    });

    test('rejects a payload with the wrong type byte', () {
      final wrongType = Uint8List.fromList([0x02, ...hexToBytes('0xc0')]);
      expect(() => parseEip4844Transaction(wrongType), throwsFormatException);
    });

    test('rejects a payload with the wrong field count', () {
      final tooShort = Uint8List.fromList([
        eip4844TransactionType,
        ...encodeRlp(const RlpItem.list([])),
      ]);
      expect(() => parseEip4844Transaction(tooShort), throwsFormatException);
    });
  });
}
