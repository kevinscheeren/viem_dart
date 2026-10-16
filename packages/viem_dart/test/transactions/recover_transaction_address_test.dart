import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('recoverTransactionAddress', () {
    test('recovers the sender of a signed legacy transaction', () {
      // Same EIP-155 worked example used in legacy_transaction_test.dart.
      final privateKey = hexToBytes(
        '0x4646464646464646464646464646464646464646464646464646464646464646',
      );
      final account = privateKeyToAccount(privateKey);
      final signed = signLegacyTransaction(
        LegacyTransaction(
          nonce: BigInt.from(9),
          gasPrice: BigInt.from(20000000000),
          gasLimit: BigInt.from(21000),
          to: '0x3535353535353535353535353535353535353535',
          value: BigInt.parse('1000000000000000000'),
          data: Uint8List(0),
          chainId: BigInt.one,
        ),
        account,
      );
      expect(recoverTransactionAddress(signed), account.address);
    });

    test('recovers the sender of a signed EIP-1559 transaction', () {
      // ethereum/tests TransactionTests/ttEIP1559/
      // GasLimitPriceProductOverflowtMinusOne.json — same vector used in
      // eip1559_transaction_test.dart.
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
      final expectedSender = getAddress(
        '0xae2aec498d20869d441eaaf708fb1e375ae1787d',
      );
      expect(recoverTransactionAddress(tx), expectedSender);
    });

    test('throws for an unsigned transaction', () {
      final unsigned = LegacyTransaction(
        nonce: BigInt.zero,
        gasPrice: BigInt.zero,
        gasLimit: BigInt.zero,
        value: BigInt.zero,
        data: Uint8List(0),
      );
      expect(
        () => recoverTransactionAddress(unsigned),
        throwsA(isA<StateError>()),
      );
    });
  });
}
