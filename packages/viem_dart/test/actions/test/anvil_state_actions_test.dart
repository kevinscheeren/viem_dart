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
  group('mine', () {
    test('sends anvil_mine with hex-encoded blocks and interval', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_mine');
          sentParams = params;
        }),
      );
      await client.mine(blocks: 5);
      expect(sentParams, ['0x5', '0x0']);
    });

    test('interval is included when given', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          sentParams = params;
        }),
      );
      await client.mine(blocks: 3, interval: 12);
      expect(sentParams, ['0x3', '0xc']);
    });
  });

  group('setBalance', () {
    test('sends anvil_setBalance with the hex-encoded value', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setBalance');
          sentParams = params;
        }),
      );
      await client.setBalance(address: _address, value: BigInt.from(1000));
      expect(sentParams, [_address, '0x3e8']);
    });
  });

  group('setCode', () {
    test('sends anvil_setCode with the raw bytecode hex', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setCode');
          sentParams = params;
        }),
      );
      await client.setCode(address: _address, bytecode: '0x6080604052');
      expect(sentParams, [_address, '0x6080604052']);
    });
  });

  group('setNonce', () {
    test('sends anvil_setNonce with the hex-encoded nonce', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setNonce');
          sentParams = params;
        }),
      );
      await client.setNonce(address: _address, nonce: 42);
      expect(sentParams, [_address, '0x2a']);
    });
  });

  group('setStorageAt', () {
    test(
      'sends anvil_setStorageAt with the hex-encoded slot and raw value',
      () async {
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeTransport((method, params) {
            expect(method, 'anvil_setStorageAt');
            sentParams = params;
          }),
        );
        final value =
            '0x0000000000000000000000000000000000000000000000000000000000000001';
        await client.setStorageAt(
          address: _address,
          slot: BigInt.zero,
          value: value,
        );
        expect(sentParams, [_address, '0x0', value]);
      },
    );
  });

  group('reset', () {
    test('sends anvil_reset with no params when not forking', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_reset');
          sentParams = params;
        }),
      );
      await client.reset();
      expect(sentParams, isEmpty);
    });

    test('includes the forking config when forkUrl is given', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          sentParams = params;
        }),
      );
      await client.reset(
        forkUrl: 'https://example.com/rpc',
        forkBlockNumber: BigInt.from(18000000),
      );
      expect(sentParams, [
        {
          'forking': {
            'jsonRpcUrl': 'https://example.com/rpc',
            'blockNumber': 18000000,
          },
        },
      ]);
    });
  });

  group('dumpState/loadState', () {
    test('dumpState returns the raw hex-encoded state blob', () async {
      final client = TestClient(
        transport: _FakeResultTransport((method, params) {
          expect(method, 'anvil_dumpState');
          return '0x1f8b08';
        }),
      );
      expect(await client.dumpState(), '0x1f8b08');
    });

    test('loadState sends anvil_loadState with the state blob', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_loadState');
          sentParams = params;
        }),
      );
      await client.loadState(state: '0x1f8b08');
      expect(sentParams, ['0x1f8b08']);
    });
  });

  group('setBlockGasLimit', () {
    test('sends anvil_setBlockGasLimit with the hex-encoded limit', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setBlockGasLimit');
          sentParams = params;
        }),
      );
      await client.setBlockGasLimit(gasLimit: BigInt.from(30000000));
      expect(sentParams, ['0x1c9c380']);
    });
  });

  group('setMinGasPrice', () {
    test('sends anvil_setMinGasPrice with the hex-encoded price', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setMinGasPrice');
          sentParams = params;
        }),
      );
      await client.setMinGasPrice(gasPrice: BigInt.from(1000000000));
      expect(sentParams, ['0x3b9aca00']);
    });
  });

  group('setNextBlockBaseFeePerGas', () {
    test(
      'sends anvil_setNextBlockBaseFeePerGas with the hex-encoded fee',
      () async {
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeTransport((method, params) {
            expect(method, 'anvil_setNextBlockBaseFeePerGas');
            sentParams = params;
          }),
        );
        await client.setNextBlockBaseFeePerGas(
          baseFeePerGas: BigInt.from(1000000000),
        );
        expect(sentParams, ['0x3b9aca00']);
      },
    );
  });

  group('setCoinbase', () {
    test('sends anvil_setCoinbase with the raw address', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setCoinbase');
          sentParams = params;
        }),
      );
      await client.setCoinbase(address: _address);
      expect(sentParams, [_address]);
    });
  });

  group('setRpcUrl', () {
    test('sends anvil_setRpcUrl with the raw url', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setRpcUrl');
          sentParams = params;
        }),
      );
      await client.setRpcUrl(url: 'https://example.com/rpc');
      expect(sentParams, ['https://example.com/rpc']);
    });
  });
}
