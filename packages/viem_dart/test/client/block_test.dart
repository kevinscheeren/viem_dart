import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  // Shaped like a real eth_getBlockByNumber result (post-merge, post-1559).
  final json = {
    'number': '0x112a880',
    'hash': '0xaaaa000000000000000000000000000000000000000000000000000000aaaa',
    'parentHash':
        '0xbbbb000000000000000000000000000000000000000000000000000000bbbb',
    'nonce': '0x0000000000000000',
    'sha3Uncles':
        '0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347',
    'logsBloom': '0x0',
    'transactionsRoot':
        '0xcccc000000000000000000000000000000000000000000000000000000cccc',
    'stateRoot':
        '0xdddd000000000000000000000000000000000000000000000000000000dddd',
    'receiptsRoot':
        '0xeeee000000000000000000000000000000000000000000000000000000eeee',
    'miner': '0x0000000000000000000000000000000000000000',
    'difficulty': '0x0',
    'totalDifficulty': '0x0',
    'extraData': '0x',
    'size': '0x220',
    'gasLimit': '0x1c9c380',
    'gasUsed': '0xb71b0',
    'timestamp': '0x656f9a80',
    'transactions': [
      '0x1111111111111111111111111111111111111111111111111111111111111111',
    ],
    'uncles': <String>[],
    'baseFeePerGas': '0x3b9aca00',
  };

  group('Block.fromJson', () {
    test('decodes hex-quantity fields', () {
      final block = Block.fromJson(json);
      expect(block.number, BigInt.parse('112a880', radix: 16));
      expect(block.difficulty, BigInt.zero);
      expect(block.gasLimit, BigInt.parse('1c9c380', radix: 16));
      expect(block.baseFeePerGas, BigInt.parse('3b9aca00', radix: 16));
    });

    test('passes through hex-string fields unchanged', () {
      final block = Block.fromJson(json);
      expect(block.hash, json['hash']);
      expect(block.parentHash, json['parentHash']);
      expect(block.miner, json['miner']);
    });

    test('round-trips through toJson', () {
      final block = Block.fromJson(json);
      final reencoded = Block.fromJson(block.toJson());
      expect(reencoded, block);
    });
  });

  test('a pending block has null number/hash and totalDifficulty', () {
    final pending = {...json}
      ..remove('number')
      ..remove('hash')
      ..remove('totalDifficulty');
    final block = Block.fromJson(pending);
    expect(block.number, isNull);
    expect(block.hash, isNull);
    expect(block.totalDifficulty, isNull);
  });
}
