import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport() : super(const TransportConfig());
  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async =>
      JsonRpcResponse(id: request.id, result: '0x1');
}

void main() {
  group('createWalletClient', () {
    test(
      'returns a WalletClient wired to the given transport, chain, and account',
      () {
        final transport = _FakeTransport();
        final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
        final client = createWalletClient(
          transport: transport,
          chain: mainnet,
          account: account,
        );

        expect(client.transport, same(transport));
        expect(client.chain, mainnet);
        expect(client.account, account);
      },
    );
  });
}
