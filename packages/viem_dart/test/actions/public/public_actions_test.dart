import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());
  final Object? Function(String method, List<Object?> params) handler;
  final List<(String, List<Object?>)> calls = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    calls.add((request.method, request.params));
    return JsonRpcResponse(
      id: request.id,
      result: handler(request.method, request.params),
    );
  }
}

void main() {
  group('PublicActions', () {
    test('getBlockNumber decodes the hex result', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_blockNumber');
        return '0x112a880';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getBlockNumber(), BigInt.parse('112a880', radix: 16));
    });

    test('getChainId decodes the hex result', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_chainId');
        return '0x1';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getChainId(), BigInt.one);
    });

    test('getBalance sends the address and resolved block param', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getBalance');
        expect(params, ['0xabc', 'latest']);
        return '0xde0b6b3a7640000';
      });
      final client = PublicClient(transport: transport);
      final balance = await client.getBalance('0xabc');
      expect(balance, BigInt.parse('de0b6b3a7640000', radix: 16));
    });

    test('getBalance uses a specific block number when given', () async {
      final transport = _FakeTransport((method, params) {
        expect(params, ['0xabc', '0x10']);
        return '0x0';
      });
      final client = PublicClient(transport: transport);
      await client.getBalance('0xabc', blockNumber: BigInt.from(16));
    });

    test('getBlock without blockHash calls eth_getBlockByNumber', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getBlockByNumber');
        expect(params, ['latest', false]);
        return null;
      });
      final client = PublicClient(transport: transport);
      expect(await client.getBlock(), isNull);
    });

    test('getBlock with blockHash calls eth_getBlockByHash', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getBlockByHash');
        expect(params, ['0xhash', true]);
        return null;
      });
      final client = PublicClient(transport: transport);
      await client.getBlock(blockHash: '0xhash', includeTransactions: true);
    });

    test('getTransaction decodes a found transaction', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getTransactionByHash');
        expect(params, ['0xtxhash']);
        return {
          'hash': '0xtxhash',
          'nonce': '0x0',
          'from': '0xabc',
          'to': '0xdef',
          'value': '0x0',
          'gas': '0x5208',
          'input': '0x',
        };
      });
      final client = PublicClient(transport: transport);
      final tx = await client.getTransaction('0xtxhash');
      expect(tx?.hash, '0xtxhash');
      expect(tx?.gas, BigInt.from(21000));
    });

    test('getTransaction returns null when not found', () async {
      final transport = _FakeTransport((method, params) => null);
      final client = PublicClient(transport: transport);
      expect(await client.getTransaction('0xnotfound'), isNull);
    });

    test('getTransactionReceipt decodes a found receipt', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getTransactionReceipt');
        return {
          'transactionHash': '0xtxhash',
          'transactionIndex': '0x0',
          'blockHash': '0xblockhash',
          'blockNumber': '0x1',
          'from': '0xabc',
          'to': '0xdef',
          'cumulativeGasUsed': '0x5208',
          'gasUsed': '0x5208',
          'logs': <Object?>[],
          'logsBloom': '0x0',
          'status': '0x1',
        };
      });
      final client = PublicClient(transport: transport);
      final receipt = await client.getTransactionReceipt('0xtxhash');
      expect(receipt?.status, 1);
    });

    test('getTransactionCount decodes the hex nonce', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getTransactionCount');
        expect(params, ['0xabc', 'latest']);
        return '0x2a';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getTransactionCount('0xabc'), 42);
    });
  });
}
