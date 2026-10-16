import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());

  final JsonRpcResponse Function(JsonRpcRequest request) handler;
  final List<JsonRpcRequest> received = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    received.add(request);
    return handler(request);
  }
}

void main() {
  group('RpcClient', () {
    test('assigns sequential, increasing request ids', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(id: request.id, result: request.id),
      );
      final rpc = RpcClient(transport);

      final first = await rpc.request('eth_chainId');
      final second = await rpc.request('eth_blockNumber');

      expect(first, 1);
      expect(second, 2);
      expect(transport.received.map((r) => r.method), [
        'eth_chainId',
        'eth_blockNumber',
      ]);
    });

    test('returns the raw result on success', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(id: request.id, result: '0x2a'),
      );
      final rpc = RpcClient(transport);

      expect(await rpc.request('eth_getBalance', ['0x0', 'latest']), '0x2a');
    });

    test('throws RpcError on an error response', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(
          id: request.id,
          error: const JsonRpcErrorPayload(
            code: -32000,
            message: 'execution reverted',
          ),
        ),
      );
      final rpc = RpcClient(transport);

      expect(
        () => rpc.request('eth_call'),
        throwsA(isA<RpcError>().having((e) => e.code, 'code', -32000)),
      );
    });
  });

  group('RpcClient in-flight request dedup', () {
    test(
      'identical concurrent calls share one underlying transport request',
      () async {
        final transport = _FakeTransport(
          (request) => JsonRpcResponse(id: request.id, result: '0x2a'),
        );
        final rpc = RpcClient(transport);

        final first = rpc.request('eth_getBalance', ['0xabc', 'latest']);
        final second = rpc.request('eth_getBalance', ['0xabc', 'latest']);

        expect(await first, '0x2a');
        expect(await second, '0x2a');
        expect(transport.received, hasLength(1));
      },
    );

    test('calls with different method or params are not deduped', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(id: request.id, result: request.id),
      );
      final rpc = RpcClient(transport);

      final calls = [
        rpc.request('eth_getBalance', ['0xabc', 'latest']),
        rpc.request('eth_chainId'),
        rpc.request('eth_getBalance', ['0xdef', 'latest']),
        rpc.request('eth_getBalance', ['0xabc', 'earliest']),
      ];

      await Future.wait(calls);
      expect(transport.received, hasLength(4));
    });

    test('a completed call does not dedupe a later, separate call', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(id: request.id, result: request.id),
      );
      final rpc = RpcClient(transport);

      await rpc.request('eth_blockNumber');
      await rpc.request('eth_blockNumber');

      expect(transport.received, hasLength(2));
    });

    test('a deduped call propagates the same error to every caller', () async {
      final transport = _FakeTransport(
        (request) => JsonRpcResponse(
          id: request.id,
          error: const JsonRpcErrorPayload(code: -32000, message: 'boom'),
        ),
      );
      final rpc = RpcClient(transport);

      final first = rpc.request('eth_call');
      final second = rpc.request('eth_call');

      await expectLater(
        first,
        throwsA(isA<RpcError>().having((e) => e.code, 'code', -32000)),
      );
      await expectLater(
        second,
        throwsA(isA<RpcError>().having((e) => e.code, 'code', -32000)),
      );
      expect(transport.received, hasLength(1));
    });
  });
}
