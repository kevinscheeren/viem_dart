import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // Shaped like a real eth_getTransactionByHash result (EIP-1559 type).
  final json = <String, Object?>{
    'hash':
        '0x1111111111111111111111111111111111111111111111111111111111111111',
    'nonce': '0x2a',
    'blockHash': '0xaaaa',
    'blockNumber': '0x112a880',
    'transactionIndex': '0x0',
    'from': '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266',
    'to': '0x70997970c51812dc3a010c7d01b50e0d17dc79c8',
    'value': '0xde0b6b3a7640000',
    'gas': '0x5208',
    'maxFeePerGas': '0x77359400',
    'maxPriorityFeePerGas': '0x3b9aca00',
    'input': '0x',
    'type': '0x2',
    'chainId': '0x1',
    'v': '0x1',
    'r': '0xabc',
    's': '0xdef',
    'accessList': <Object?>[],
  };

  group('Transaction.fromJson', () {
    test('decodes hex-quantity fields', () {
      final tx = Transaction.fromJson(json);
      expect(tx.nonce, 42);
      expect(tx.blockNumber, BigInt.parse('112a880', radix: 16));
      expect(tx.value, BigInt.parse('de0b6b3a7640000', radix: 16));
      expect(tx.gas, BigInt.from(21000));
      expect(tx.maxFeePerGas, BigInt.parse('77359400', radix: 16));
      expect(tx.type, 2);
      expect(tx.chainId, BigInt.one);
    });

    test('passes through address/hash/data fields unchanged', () {
      final tx = Transaction.fromJson(json);
      expect(tx.from, json['from']);
      expect(tx.to, json['to']);
      expect(tx.input, '0x');
    });

    test('a contract-creation tx has a null `to`', () {
      final creation = {...json}..['to'] = null;
      final tx = Transaction.fromJson(creation);
      expect(tx.to, isNull);
    });

    test('round-trips through toJson', () {
      final tx = Transaction.fromJson(json);
      expect(Transaction.fromJson(tx.toJson()), tx);
    });
  });
}
