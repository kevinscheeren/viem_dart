import 'package:test/test.dart';
import 'package:viem_dart/test_actions.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());
  final void Function(String method, List<Object?> params) handler;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    handler(request.method, request.params);
    return JsonRpcResponse(id: request.id, result: null);
  }
}

class _FakeResultTransport extends Transport {
  _FakeResultTransport(this.handler) : super(const TransportConfig());
  final Object? Function(String method, List<Object?> params) handler;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async =>
      JsonRpcResponse(
        id: request.id,
        result: handler(request.method, request.params),
      );
}

const _address = '0x70997970c51812dc3a010c7d01b50e0d17dc79c8';

void main() {
  group('impersonateAccount', () {
    test('sends anvil_impersonateAccount with the address', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_impersonateAccount');
          sentParams = params;
        }),
      );
      await client.impersonateAccount(address: _address);
      expect(sentParams, [_address]);
    });
  });

  group('stopImpersonatingAccount', () {
    test('sends anvil_stopImpersonatingAccount with the address', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_stopImpersonatingAccount');
          sentParams = params;
        }),
      );
      await client.stopImpersonatingAccount(address: _address);
      expect(sentParams, [_address]);
    });
  });

  group('sendUnsignedTransaction', () {
    test(
      'sends eth_sendUnsignedTransaction with only from when nothing else given',
      () async {
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeResultTransport((method, params) {
            expect(method, 'eth_sendUnsignedTransaction');
            sentParams = params;
            return '0xhash';
          }),
        );
        final hash = await client.sendUnsignedTransaction(from: _address);
        expect(hash, '0xhash');
        expect(sentParams, [
          {'from': _address},
        ]);
      },
    );

    test(
      'hex-encodes value/nonce/gas/gasPrice and passes to/data raw',
      () async {
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeResultTransport((method, params) {
            sentParams = params;
            return '0xhash';
          }),
        );
        await client.sendUnsignedTransaction(
          from: _address,
          to: _address,
          value: BigInt.from(1000),
          data: '0xabcdef',
          nonce: 5,
          gas: BigInt.from(21000),
          gasPrice: BigInt.from(1000000000),
        );
        expect(sentParams, [
          {
            'from': _address,
            'to': _address,
            'data': '0xabcdef',
            'value': '0x3e8',
            'nonce': '0x5',
            'gas': '0x5208',
            'gasPrice': '0x3b9aca00',
          },
        ]);
      },
    );
  });
}
