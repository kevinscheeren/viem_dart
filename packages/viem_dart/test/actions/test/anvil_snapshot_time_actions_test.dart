import 'package:test/test.dart';
import 'package:viem_dart/test_actions.dart';
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
  group('snapshot', () {
    test('sends evm_snapshot with no params and returns the id', () async {
      String? sentMethod;
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          sentMethod = method;
          sentParams = params;
          return '0x1';
        }),
      );
      expect(await client.snapshot(), '0x1');
      expect(sentMethod, 'evm_snapshot');
      expect(sentParams, isEmpty);
    });
  });

  group('revert', () {
    test('sends evm_revert with the snapshot id, unencoded', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'evm_revert');
          sentParams = params;
          return null;
        }),
      );
      await client.revert(id: '0x1');
      expect(sentParams, ['0x1']);
    });
  });

  group('increaseTime', () {
    test('sends evm_increaseTime with hex-encoded seconds', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'evm_increaseTime');
          sentParams = params;
          return null;
        }),
      );
      await client.increaseTime(seconds: 3600);
      expect(sentParams, ['0xe10']);
    });
  });

  group('setAutomine', () {
    test('sends evm_setAutomine with the raw boolean', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'evm_setAutomine');
          sentParams = params;
          return null;
        }),
      );
      await client.setAutomine(enabled: false);
      expect(sentParams, [false]);
    });
  });

  group('dropTransaction', () {
    test('sends anvil_dropTransaction with the raw hash', () async {
      const hash =
          '0xabc0000000000000000000000000000000000000000000000000000000000abc';
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_dropTransaction');
          sentParams = params;
          return null;
        }),
      );
      await client.dropTransaction(hash: hash);
      expect(sentParams, [hash]);
    });
  });

  group('setNextBlockTimestamp', () {
    test('sends evm_setNextBlockTimestamp with the raw timestamp', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'evm_setNextBlockTimestamp');
          sentParams = params;
          return null;
        }),
      );
      await client.setNextBlockTimestamp(timestamp: 1700000000);
      expect(sentParams, [1700000000]);
    });
  });

  group('setBlockTimestampInterval', () {
    test(
      'sends anvil_setBlockTimestampInterval with the raw seconds',
      () async {
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeTransport((method, params) {
            expect(method, 'anvil_setBlockTimestampInterval');
            sentParams = params;
            return null;
          }),
        );
        await client.setBlockTimestampInterval(seconds: 15);
        expect(sentParams, [15]);
      },
    );
  });

  group('removeBlockTimestampInterval', () {
    test('sends anvil_removeBlockTimestampInterval with no params', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_removeBlockTimestampInterval');
          sentParams = params;
          return null;
        }),
      );
      await client.removeBlockTimestampInterval();
      expect(sentParams, isEmpty);
    });
  });

  group('setIntervalMining', () {
    test('sends anvil_setIntervalMining with the raw seconds', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setIntervalMining');
          sentParams = params;
          return null;
        }),
      );
      await client.setIntervalMining(seconds: 5);
      expect(sentParams, [5]);
    });
  });

  group('getAutomine', () {
    test(
      'sends anvil_getAutomine with no params and returns the flag',
      () async {
        String? sentMethod;
        List<Object?>? sentParams;
        final client = TestClient(
          transport: _FakeTransport((method, params) {
            sentMethod = method;
            sentParams = params;
            return true;
          }),
        );
        expect(await client.getAutomine(), true);
        expect(sentMethod, 'anvil_getAutomine');
        expect(sentParams, isEmpty);
      },
    );
  });

  group('setLoggingEnabled', () {
    test('sends anvil_setLoggingEnabled with the raw boolean', () async {
      List<Object?>? sentParams;
      final client = TestClient(
        transport: _FakeTransport((method, params) {
          expect(method, 'anvil_setLoggingEnabled');
          sentParams = params;
          return null;
        }),
      );
      await client.setLoggingEnabled(enabled: true);
      expect(sentParams, [true]);
    });
  });
}
