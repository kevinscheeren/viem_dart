import 'package:test/test.dart';
import 'package:viem_dart/test_actions.dart';
import 'package:viem_dart/viem_dart.dart';

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

void main() {
  group('getTxpoolStatus', () {
    test('decodes hex-encoded pending/queued counts', () async {
      String? sentMethod;
      final client = TestClient(
        transport: _FakeResultTransport((method, params) {
          sentMethod = method;
          return {'pending': '0xa', 'queued': '0x3'};
        }),
      );
      final status = await client.getTxpoolStatus();
      expect(sentMethod, 'txpool_status');
      expect(status.pending, 10);
      expect(status.queued, 3);
    });
  });

  group('getTxpoolContent', () {
    test('returns the raw decoded content map', () async {
      String? sentMethod;
      final content = {
        'pending': <String, Object?>{},
        'queued': <String, Object?>{},
      };
      final client = TestClient(
        transport: _FakeResultTransport((method, params) {
          sentMethod = method;
          return content;
        }),
      );
      expect(await client.getTxpoolContent(), content);
      expect(sentMethod, 'txpool_content');
    });
  });

  group('inspectTxpool', () {
    test('returns the raw decoded inspection map', () async {
      String? sentMethod;
      final inspection = {
        'pending': <String, Object?>{},
        'queued': <String, Object?>{},
      };
      final client = TestClient(
        transport: _FakeResultTransport((method, params) {
          sentMethod = method;
          return inspection;
        }),
      );
      expect(await client.inspectTxpool(), inspection);
      expect(sentMethod, 'txpool_inspect');
    });
  });
}
