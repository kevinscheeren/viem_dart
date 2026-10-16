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
  group('PublicClient', () {
    test('holds the transport and chain it was created with', () {
      final transport = _FakeTransport();
      final client = PublicClient(transport: transport, chain: mainnet);

      expect(client.transport, same(transport));
      expect(client.chain, mainnet);
    });

    test('chain is optional', () {
      final client = PublicClient(transport: _FakeTransport());
      expect(client.chain, isNull);
    });

    test('exposes a working RpcClient wired to its transport', () async {
      final client = PublicClient(transport: _FakeTransport());
      expect(await client.rpc.request('eth_chainId'), '0x1');
    });
  });
}
