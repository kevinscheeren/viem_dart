import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';

void main() {
  group('AbiItem.fromJson', () {
    test('parses a function item (ERC-20 transfer)', () {
      final item = AbiItem.fromJson({
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
      });
      expect(item, isA<AbiFunction>());
      final fn = item as AbiFunction;
      expect(fn.name, 'transfer');
      expect(fn.inputs, hasLength(2));
      expect(fn.inputs[0].type, 'address');
      expect(fn.outputs.single.type, 'bool');
    });

    test('parses an event item (ERC-20 Transfer) with indexed params', () {
      final item = AbiItem.fromJson({
        'type': 'event',
        'name': 'Transfer',
        'inputs': [
          {'name': 'from', 'type': 'address', 'indexed': true},
          {'name': 'to', 'type': 'address', 'indexed': true},
          {'name': 'value', 'type': 'uint256', 'indexed': false},
        ],
        'anonymous': false,
      });
      expect(item, isA<AbiEvent>());
      final event = item as AbiEvent;
      expect(event.inputs[0].indexed, isTrue);
      expect(event.inputs[2].indexed, isFalse);
    });

    test('parses an error item', () {
      final item = AbiItem.fromJson({
        'type': 'error',
        'name': 'InsufficientBalance',
        'inputs': [
          {'name': 'available', 'type': 'uint256'},
          {'name': 'required', 'type': 'uint256'},
        ],
      });
      expect(item, isA<AbiError>());
      expect((item as AbiError).name, 'InsufficientBalance');
    });

    test('parses a constructor item', () {
      final item = AbiItem.fromJson({
        'type': 'constructor',
        'inputs': [
          {'name': 'initialSupply', 'type': 'uint256'},
        ],
        'stateMutability': 'nonpayable',
      });
      expect(item, isA<AbiConstructor>());
    });

    test('parses fallback and receive items', () {
      expect(
        AbiItem.fromJson({'type': 'fallback', 'stateMutability': 'payable'}),
        isA<AbiFallback>(),
      );
      expect(AbiItem.fromJson({'type': 'receive'}), isA<AbiReceive>());
    });

    test('parses a tuple parameter with nested components', () {
      final item = AbiItem.fromJson({
        'type': 'function',
        'name': 'setConfig',
        'inputs': [
          {
            'name': 'config',
            'type': 'tuple',
            'components': [
              {'name': 'owner', 'type': 'address'},
              {'name': 'fee', 'type': 'uint96'},
            ],
          },
        ],
        'outputs': <Object?>[],
        'stateMutability': 'nonpayable',
      });
      final fn = item as AbiFunction;
      expect(fn.inputs.single.components, hasLength(2));
      expect(fn.inputs.single.components![1].type, 'uint96');
    });

    test('rejects an unknown type', () {
      expect(() => AbiItem.fromJson({'type': 'nope'}), throwsFormatException);
    });
  });

  group('abiItemToJson', () {
    test('round-trips a function item', () {
      final original = {
        'type': 'function',
        'name': 'balanceOf',
        'inputs': [
          {'name': 'account', 'type': 'address'},
        ],
        'outputs': [
          {'name': '', 'type': 'uint256'},
        ],
        'stateMutability': 'view',
      };
      final item = AbiItem.fromJson(original);
      final reencoded = AbiItem.fromJson(abiItemToJson(item));
      expect(reencoded, item);
    });
  });
}
