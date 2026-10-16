import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  final logJson = {
    'address': '0x70997970c51812dc3a010c7d01b50e0d17dc79c8',
    'topics': [
      '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
    ],
    'data':
        '0x0000000000000000000000000000000000000000000000000de0b6b3a7640000',
    'blockNumber': '0x112a880',
    'blockHash': '0xaaaa',
    'transactionHash': '0x1111',
    'transactionIndex': '0x0',
    'logIndex': '0x0',
    'removed': false,
  };

  // Shaped like a real eth_getTransactionReceipt result (post-1559, success).
  final json = {
    'transactionHash': '0x1111',
    'transactionIndex': '0x0',
    'blockHash': '0xaaaa',
    'blockNumber': '0x112a880',
    'from': '0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266',
    'to': '0x70997970c51812dc3a010c7d01b50e0d17dc79c8',
    'cumulativeGasUsed': '0x5208',
    'gasUsed': '0x5208',
    'contractAddress': null,
    'logs': [logJson],
    'logsBloom': '0x0',
    'status': '0x1',
    'effectiveGasPrice': '0x3b9aca00',
    'type': '0x2',
  };

  group('TransactionReceipt.fromJson', () {
    test('decodes hex-quantity fields, including status', () {
      final receipt = TransactionReceipt.fromJson(json);
      expect(receipt.transactionIndex, 0);
      expect(receipt.blockNumber, BigInt.parse('112a880', radix: 16));
      expect(receipt.gasUsed, BigInt.from(21000));
      expect(receipt.status, 1);
    });

    test('decodes nested logs', () {
      final receipt = TransactionReceipt.fromJson(json);
      expect(receipt.logs, hasLength(1));
      expect(receipt.logs.first.address, logJson['address']);
      expect(receipt.logs.first.logIndex, 0);
    });

    test('a failed transaction has status 0', () {
      final failed = {...json}..['status'] = '0x0';
      expect(TransactionReceipt.fromJson(failed).status, 0);
    });

    test('a contract-creation receipt has a non-null contractAddress', () {
      final creation = {...json}..['contractAddress'] = '0xabc';
      expect(TransactionReceipt.fromJson(creation).contractAddress, '0xabc');
    });

    test('round-trips through toJson', () {
      final receipt = TransactionReceipt.fromJson(json);
      expect(TransactionReceipt.fromJson(receipt.toJson()), receipt);
    });
  });
}
