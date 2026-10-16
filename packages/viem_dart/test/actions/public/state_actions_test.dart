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

void main() {
  group('StateActions', () {
    test('call sends the call object and returns the raw return data', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_call');
        expect(params, [
          {'to': '0xcontract', 'data': '0xabcdef'},
          'latest',
        ]);
        return '0x000000000000000000000000000000000000000000000000000000000000002a';
      });
      final client = PublicClient(transport: transport);
      final result = await client.call(to: '0xcontract', data: '0xabcdef');
      expect(result, endsWith('2a'));
    });

    test('getCode returns null for an address with no code', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getCode');
        return '0x';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getCode('0xeoa'), isNull);
    });

    test('getCode returns the bytecode when present', () async {
      final transport = _FakeTransport((method, params) => '0x6001600101');
      final client = PublicClient(transport: transport);
      expect(await client.getCode('0xcontract'), '0x6001600101');
    });

    test('getStorageAt returns the raw slot value', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getStorageAt');
        expect(params, ['0xcontract', '0x0', 'latest']);
        return '0x2a';
      });
      final client = PublicClient(transport: transport);
      expect(await client.getStorageAt('0xcontract', '0x0'), '0x2a');
    });

    test('getLogs uses a block range filter by default', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getLogs');
        expect(params, [
          {
            'address': '0xcontract',
            'fromBlock': 'earliest',
            'toBlock': 'latest',
          },
        ]);
        return <Object?>[];
      });
      final client = PublicClient(transport: transport);
      expect(await client.getLogs(address: '0xcontract'), isEmpty);
    });

    test('getLogs uses blockHash instead of a range when given', () async {
      final transport = _FakeTransport((method, params) {
        expect(params, [
          {'blockHash': '0xblockhash'},
        ]);
        return <Object?>[];
      });
      final client = PublicClient(transport: transport);
      await client.getLogs(blockHash: '0xblockhash');
    });

    test('getLogs decodes returned logs', () async {
      final transport = _FakeTransport((method, params) {
        return [
          {
            'address': '0xcontract',
            'topics': <String>['0xtopic'],
            'data': '0x',
          },
        ];
      });
      final client = PublicClient(transport: transport);
      final logs = await client.getLogs();
      expect(logs, hasLength(1));
      expect(logs.first.address, '0xcontract');
    });
  });
}
