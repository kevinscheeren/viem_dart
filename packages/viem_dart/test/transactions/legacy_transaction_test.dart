import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // EIP-155's own worked example (https://eips.ethereum.org/EIPS/eip-155),
  // cross-checked byte-length-exact against the spec text before use — the
  // canonical vector for legacy + EIP-155 signing that most libraries
  // validate against.
  final privateKey = hexToBytes(
    '0x4646464646464646464646464646464646464646464646464646464646464646',
  );
  final account = privateKeyToAccount(privateKey);

  final unsigned = LegacyTransaction(
    nonce: BigInt.from(9),
    gasPrice: BigInt.from(20000000000),
    gasLimit: BigInt.from(21000),
    to: '0x3535353535353535353535353535353535353535',
    value: BigInt.parse('1000000000000000000'),
    data: Uint8List(0),
    chainId: BigInt.one,
  );

  const unsignedRlpHex =
      '0xec098504a817c800825208943535353535353535353535353535353535353535'
      '880de0b6b3a764000080018080';
  const signingHash =
      '0xdaf5a779ae972f972197303d7b574746c7ef83eadac0f2791ad23db92e4c8e53';
  const signedRlpHex =
      '0xf86c098504a817c800825208943535353535353535353535353535353535353535'
      '880de0b6b3a76400008025a028ef61340bd939bc2195fe537567866003e1a15d3c71'
      'ff63e1590620aa636276a067cbe9d8997f761aecb703304b3800ccf555c9f3dc6421'
      '4b297fb1966a3b6d83';

  group('serializeLegacyTransaction', () {
    test('encodes the EIP-155 to-be-signed preimage', () {
      expect(bytesToHex(serializeLegacyTransaction(unsigned)), unsignedRlpHex);
    });

    test('encodes the final signed transaction once signed', () {
      final signed = signLegacyTransaction(unsigned, account);
      expect(bytesToHex(serializeLegacyTransaction(signed)), signedRlpHex);
    });

    test('omits chainId/0/0 for a pre-EIP-155 unsigned transaction', () {
      final preEip155 = unsigned.copyWith(chainId: null);
      final decoded = decodeRlp(
        hexToBytes(bytesToHex(serializeLegacyTransaction(preEip155))),
      );
      expect((decoded as RlpList).items, hasLength(6));
    });
  });

  group('hashLegacyTransaction', () {
    test('matches the EIP-155 signing hash', () {
      expect(bytesToHex(hashLegacyTransaction(unsigned)), signingHash);
    });
  });

  group('signLegacyTransaction', () {
    test('reproduces the EIP-155 r/s/v via RFC 6979 deterministic k', () {
      final signed = signLegacyTransaction(unsigned, account);
      expect(
        signed.r,
        BigInt.parse(
          '18515461264373351373200002665853028612451056578545711640558177340181847433846',
        ),
      );
      expect(
        signed.s,
        BigInt.parse(
          '46948507304638947509940763649030358759909902576025900602547168820602576006531',
        ),
      );
      expect(signed.yParity, 0);
      expect(signed.chainId, BigInt.one);
    });
  });

  group('parseLegacyTransaction', () {
    test('round-trips the signed EIP-155 vector', () {
      final parsed = parseLegacyTransaction(hexToBytes(signedRlpHex));
      expect(parsed.nonce, BigInt.from(9));
      expect(parsed.gasPrice, BigInt.from(20000000000));
      expect(parsed.gasLimit, BigInt.from(21000));
      expect(parsed.to, unsigned.to);
      expect(parsed.value, BigInt.parse('1000000000000000000'));
      expect(parsed.data, isEmpty);
      expect(parsed.chainId, BigInt.one);
      expect(parsed.yParity, 0);
      expect(parsed.r, signLegacyTransaction(unsigned, account).r);
      expect(parsed.s, signLegacyTransaction(unsigned, account).s);
    });

    test('round-trips an unsigned pre-EIP-155 transaction', () {
      final tx = unsigned.copyWith(chainId: null);
      final serialized = serializeLegacyTransaction(tx);
      final parsed = parseLegacyTransaction(serialized);
      expect(parsed.nonce, tx.nonce);
      expect(parsed.to, tx.to);
      expect(parsed.chainId, isNull);
      expect(parsed.yParity, isNull);
    });

    test('round-trips a contract-creation transaction (null to)', () {
      final tx = unsigned.copyWith(to: null);
      final signed = signLegacyTransaction(tx, account);
      final parsed = parseLegacyTransaction(serializeLegacyTransaction(signed));
      expect(parsed.to, isNull);
    });

    test('recovers the sender address from a signed transaction', () {
      final signed = signLegacyTransaction(unsigned, account);
      final hash = hashLegacyTransaction(
        signed.copyWith(yParity: null, r: null, s: null),
      );
      final recovered = recoverAddress(
        hash,
        Signature(r: signed.r!, s: signed.s!, yParity: signed.yParity!),
      );
      expect(recovered, account.address);
    });
  });
}
