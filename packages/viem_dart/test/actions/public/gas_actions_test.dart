import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());
  final Object? Function(String method, List<Object?> params) handler;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async =>
      JsonRpcResponse(
        id: request.id,
        result: handler(request.method, request.params),
      );
}

Map<String, Object?> _blockWithBaseFee(String baseFeePerGas) => {
  'parentHash': '0x0',
  'sha3Uncles': '0x0',
  'transactionsRoot': '0x0',
  'stateRoot': '0x0',
  'receiptsRoot': '0x0',
  'miner': '0x0',
  'difficulty': '0x0',
  'extraData': '0x',
  'size': '0x0',
  'gasLimit': '0x1c9c380',
  'gasUsed': '0x0',
  'timestamp': '0x0',
  'transactions': <String>[],
  'uncles': <String>[],
  'baseFeePerGas': baseFeePerGas,
};

void main() {
  group('GasActions', () {
    test('getGasPrice decodes the hex result', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_gasPrice');
        return '0x3b9aca00';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getGasPrice(), BigInt.parse('3b9aca00', radix: 16));
    });

    test('estimateGas sends the call object and decodes the result', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_estimateGas');
        expect(params[0], {
          'from': '0xfrom',
          'to': '0xto',
          'value': '0xde0b6b3a7640000',
        });
        return '0x5208';
      });
      final client = PublicClient(transport: transport);
      final gas = await client.estimateGas(
        from: '0xfrom',
        to: '0xto',
        value: BigInt.parse('de0b6b3a7640000', radix: 16),
      );
      expect(gas, BigInt.from(21000));
    });

    test(
      'estimateFeesPerGas combines baseFeePerGas with maxPriorityFeePerGas',
      () async {
        final transport = _FakeTransport((method, params) {
          return switch (method) {
            'eth_getBlockByNumber' => _blockWithBaseFee('0x3b9aca00'),
            'eth_maxPriorityFeePerGas' => '0x59682f00',
            _ => throw StateError('unexpected method $method'),
          };
        });
        final client = PublicClient(transport: transport);
        final fees = await client.estimateFeesPerGas();

        final baseFee = BigInt.parse('3b9aca00', radix: 16);
        final priorityFee = BigInt.parse('59682f00', radix: 16);
        expect(fees.maxPriorityFeePerGas, priorityFee);
        expect(fees.maxFeePerGas, baseFee * BigInt.two + priorityFee);
      },
    );

    test(
      'estimateFeesPerGas falls back to 1.5 gwei priority fee if unsupported',
      () async {
        final transport = _FakeTransport((method, params) {
          return switch (method) {
            'eth_getBlockByNumber' => _blockWithBaseFee('0x3b9aca00'),
            'eth_maxPriorityFeePerGas' => throw Exception('method not found'),
            _ => throw StateError('unexpected method $method'),
          };
        });
        final client = PublicClient(transport: transport);
        final fees = await client.estimateFeesPerGas();
        expect(fees.maxPriorityFeePerGas, BigInt.from(1500000000));
      },
    );

    test('estimateFeesPerGas throws on a pre-EIP-1559 chain', () async {
      final transport = _FakeTransport((method, params) {
        final block = _blockWithBaseFee('0x1')..remove('baseFeePerGas');
        return block;
      });
      final client = PublicClient(transport: transport);
      expect(client.estimateFeesPerGas, throwsStateError);
    });

    test('getFeeHistory decodes hex fields', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_feeHistory');
        expect(params, ['0x5', 'latest', <double>[]]);
        return {
          'oldestBlock': '0x1',
          'baseFeePerGas': ['0x1', '0x2', '0x3'],
          'gasUsedRatio': [0.5, 0.6],
        };
      });
      final client = PublicClient(transport: transport);
      final history = await client.getFeeHistory(blockCount: 5);
      expect(history.oldestBlock, BigInt.one);
      expect(history.baseFeePerGas, [BigInt.one, BigInt.two, BigInt.from(3)]);
      expect(history.gasUsedRatio, [0.5, 0.6]);
    });
  });
}
