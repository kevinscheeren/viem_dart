import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/utils.dart';

void main() {
  final transfer =
      AbiItem.fromJson({
            'type': 'function',
            'name': 'transfer',
            'inputs': [
              {'name': 'to', 'type': 'address'},
              {'name': 'amount', 'type': 'uint256'},
            ],
            'outputs': [
              {'name': '', 'type': 'bool'},
            ],
            'stateMutability': 'nonpayable',
          })
          as AbiFunction;

  final balanceOf =
      AbiItem.fromJson({
            'type': 'function',
            'name': 'balanceOf',
            'inputs': [
              {'name': 'account', 'type': 'address'},
            ],
            'outputs': [
              {'name': '', 'type': 'uint256'},
            ],
            'stateMutability': 'view',
          })
          as AbiFunction;

  group('abiSelector', () {
    // Universally-known ERC-20 selectors, verified independently.
    test('transfer(address,uint256) selector is 0xa9059cbb', () {
      expect(
        bytesToHex(abiSelector('transfer', transfer.inputs)),
        '0xa9059cbb',
      );
    });

    test('balanceOf(address) selector is 0x70a08231', () {
      expect(
        bytesToHex(abiSelector('balanceOf', balanceOf.inputs)),
        '0x70a08231',
      );
    });

    test('tuple parameters expand to their canonical component types', () {
      const param = AbiParameter(
        name: '',
        type: 'tuple',
        components: [
          AbiParameter(name: 'owner', type: 'address'),
          AbiParameter(name: 'amount', type: 'uint256'),
        ],
      );
      expect(abiSignature('foo', [param]), 'foo((address,uint256))');
    });

    test(
      'tuple array parameters expand with the array suffix outside the parens',
      () {
        const param = AbiParameter(
          name: '',
          type: 'tuple[]',
          components: [AbiParameter(name: 'x', type: 'uint256')],
        );
        expect(abiSignature('foo', [param]), 'foo((uint256)[])');
      },
    );
  });

  group('encodeFunctionData / decodeFunctionResult', () {
    test('encodeFunctionData prepends the selector to the encoded args', () {
      const to = '0x70997970c51812dc3a010c7d01b50e0d17dc79c8';
      final data = encodeFunctionData(transfer, [to, BigInt.from(1000)]);
      expect(bytesToHex(data).startsWith('0xa9059cbb'), isTrue);

      final decodedArgs = decodeAbiParameters(transfer.inputs, data.sublist(4));
      expect(decodedArgs[1], BigInt.from(1000));
    });

    test('decodeFunctionResult decodes selector-less return data', () {
      final returnData = encodeAbiParameters(balanceOf.outputs, [
        BigInt.from(42),
      ]);
      expect(decodeFunctionResult(balanceOf, returnData), [BigInt.from(42)]);
    });
  });

  group('encodeErrorResult / decodeErrorResult', () {
    final insufficientBalance =
        AbiItem.fromJson({
              'type': 'error',
              'name': 'InsufficientBalance',
              'inputs': [
                {'name': 'available', 'type': 'uint256'},
                {'name': 'required', 'type': 'uint256'},
              ],
            })
            as AbiError;

    test('round-trips through encode/decode', () {
      final data = encodeErrorResult(insufficientBalance, [
        BigInt.from(1),
        BigInt.from(100),
      ]);
      expect(decodeErrorResult(insufficientBalance, data), [
        BigInt.from(1),
        BigInt.from(100),
      ]);
    });

    test('encoded data starts with the error selector', () {
      final data = encodeErrorResult(insufficientBalance, [
        BigInt.zero,
        BigInt.zero,
      ]);
      final selector = abiSelector(
        insufficientBalance.name,
        insufficientBalance.inputs,
      );
      expect(data.sublist(0, 4), selector);
    });

    test('rejects revert data with a mismatched selector', () {
      final wrongData = hexToBytes('0xdeadbeef${'00' * 64}');
      expect(
        () => decodeErrorResult(insufficientBalance, wrongData),
        throwsFormatException,
      );
    });
  });
}
