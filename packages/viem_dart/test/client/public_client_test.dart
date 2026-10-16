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
  group('createPublicClient', () {
    test('returns a PublicClient wired to the given transport and chain', () {
      final transport = _FakeTransport();
      final client = createPublicClient(transport: transport, chain: mainnet);

      expect(client.transport, same(transport));
      expect(client.chain, mainnet);
    });

    test('chain is optional', () {
      final client = createPublicClient(transport: _FakeTransport());
      expect(client.chain, isNull);
    });
  });
}
