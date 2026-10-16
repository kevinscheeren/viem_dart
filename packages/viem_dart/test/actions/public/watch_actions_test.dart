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

const _fastPolling = Duration(milliseconds: 5);

void main() {
  group('watchBlockNumber', () {
    test('emits only strictly-increasing block numbers', () async {
      final sequence = ['0x1', '0x1', '0x2', '0x2', '0x3'];
      var i = 0;
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_blockNumber');
        final value = sequence[i];
        if (i < sequence.length - 1) i++;
        return value;
      });
      final client = PublicClient(transport: transport);

      final emitted = await client
          .watchBlockNumber(pollingInterval: _fastPolling)
          .take(3)
          .toList();
      expect(emitted, [BigInt.one, BigInt.two, BigInt.from(3)]);
    });
  });

  group('watchPendingTransactions', () {
    test('emits hashes from filter changes and cleans up on cancel', () async {
      var uninstalled = false;
      final transport = _FakeTransport((method, params) {
        return switch (method) {
          'eth_newPendingTransactionFilter' => '0xfilter',
          'eth_getFilterChanges' => ['0xtx1', '0xtx2'],
          'eth_uninstallFilter' => (uninstalled = true),
          _ => throw StateError('unexpected method $method'),
        };
      });
      final client = PublicClient(transport: transport);

      final emitted = await client
          .watchPendingTransactions(pollingInterval: _fastPolling)
          .take(2)
          .toList();
      expect(emitted, ['0xtx1', '0xtx2']);

      // Give the stream's `finally` block a tick to run after cancellation.
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(uninstalled, isTrue);
    });
  });

  group('watchEvent', () {
    test('emits decoded logs from filter changes', () async {
      final transport = _FakeTransport((method, params) {
        return switch (method) {
          'eth_newFilter' => '0xfilter',
          'eth_getFilterChanges' => [
            {'address': '0xcontract', 'topics': <String>[], 'data': '0x'},
          ],
          'eth_uninstallFilter' => true,
          _ => throw StateError('unexpected method $method'),
        };
      });
      final client = PublicClient(transport: transport);

      final emitted = await client
          .watchEvent(pollingInterval: _fastPolling)
          .take(1)
          .toList();
      expect(emitted.single.address, '0xcontract');
    });
  });
}
