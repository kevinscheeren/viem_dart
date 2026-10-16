import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this._handler) : super(const TransportConfig());
  final Future<JsonRpcResponse> Function(JsonRpcRequest) _handler;
  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) => _handler(request);
}

void main() {
  group('FallbackTransport', () {
    test('uses the first transport when it succeeds', () async {
      final first = _FakeTransport(
        (r) async => JsonRpcResponse(id: r.id, result: 'first'),
      );
      final second = _FakeTransport(
        (r) async => JsonRpcResponse(id: r.id, result: 'second'),
      );
      final fallback = FallbackTransport([first, second]);

      final response = await fallback.request(
        const JsonRpcRequest(id: 1, method: 'eth_chainId'),
      );
      expect(response.result, 'first');
    });

    test('falls through to the next transport on failure', () async {
      final first = _FakeTransport((r) async => throw Exception('down'));
      final second = _FakeTransport(
        (r) async => JsonRpcResponse(id: r.id, result: 'second'),
      );
      final fallback = FallbackTransport([first, second]);

      final response = await fallback.request(
        const JsonRpcRequest(id: 1, method: 'eth_chainId'),
      );
      expect(response.result, 'second');
    });

    test('throws when every transport fails', () async {
      final first = _FakeTransport((r) async => throw Exception('down 1'));
      final second = _FakeTransport((r) async => throw Exception('down 2'));
      final fallback = FallbackTransport([first, second]);

      expect(
        () => fallback.request(
          const JsonRpcRequest(id: 1, method: 'eth_chainId'),
        ),
        throwsStateError,
      );
    });

    test('requires at least one transport', () {
      expect(() => FallbackTransport([]), throwsA(isA<AssertionError>()));
    });
  });

  group('CustomTransport', () {
    test('delegates to the supplied handler', () async {
      final transport = CustomTransport(
        (request) async => JsonRpcResponse(
          id: request.id,
          result: 'handled: ${request.method}',
        ),
      );
      final response = await transport.request(
        const JsonRpcRequest(id: 1, method: 'eth_chainId'),
      );
      expect(response.result, 'handled: eth_chainId');
    });
  });
}
