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
  group('FilterActions', () {
    test(
      'createEventFilter sends the filter criteria and returns the id',
      () async {
        final transport = _FakeTransport((method, params) {
          expect(method, 'eth_newFilter');
          expect(params, [
            {
              'address': '0xcontract',
              'fromBlock': 'earliest',
              'toBlock': 'latest',
            },
          ]);
          return '0xfilter1';
        });
        final client = PublicClient(transport: transport);
        expect(
          await client.createEventFilter(address: '0xcontract'),
          '0xfilter1',
        );
      },
    );

    test('createBlockFilter returns the filter id', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_newBlockFilter');
        return '0xfilter2';
      });
      final client = PublicClient(transport: transport);
      expect(await client.createBlockFilter(), '0xfilter2');
    });

    test('createPendingTransactionFilter returns the filter id', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_newPendingTransactionFilter');
        return '0xfilter3';
      });
      final client = PublicClient(transport: transport);
      expect(await client.createPendingTransactionFilter(), '0xfilter3');
    });

    test('getFilterChanges returns raw items', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getFilterChanges');
        expect(params, ['0xfilter1']);
        return ['0xhash1', '0xhash2'];
      });
      final client = PublicClient(transport: transport);
      expect(await client.getFilterChanges('0xfilter1'), [
        '0xhash1',
        '0xhash2',
      ]);
    });

    test('getFilterLogs decodes logs', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getFilterLogs');
        return [
          {'address': '0xcontract', 'topics': <String>[], 'data': '0x'},
        ];
      });
      final client = PublicClient(transport: transport);
      final logs = await client.getFilterLogs('0xfilter1');
      expect(logs, hasLength(1));
      expect(logs.first.address, '0xcontract');
    });

    test('uninstallFilter returns whether the filter existed', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_uninstallFilter');
        return true;
      });
      final client = PublicClient(transport: transport);
      expect(await client.uninstallFilter('0xfilter1'), isTrue);
    });
  });
}
