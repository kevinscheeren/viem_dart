import 'package:test/test.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport() : super(const TransportConfig());
  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async =>
      JsonRpcResponse(id: request.id, result: '0x1');
}

void main() {
  group('createTestClient', () {
    test('returns a TestClient wired to the given transport and chain', () {
      final transport = _FakeTransport();
      final client = createTestClient(transport: transport, chain: anvil);

      expect(client.transport, same(transport));
      expect(client.chain, anvil);
    });

    test('chain is optional', () {
      final client = createTestClient(transport: _FakeTransport());
      expect(client.chain, isNull);
    });
  });
}
