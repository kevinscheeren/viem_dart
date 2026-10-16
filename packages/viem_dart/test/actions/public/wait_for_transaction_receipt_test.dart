import 'package:test/test.dart';
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

Map<String, Object?> _receiptJson() => {
  'transactionHash': '0xtx',
  'transactionIndex': '0x0',
  'blockHash': '0xblock',
  'blockNumber': '0x1',
  'from': '0xfrom',
  'to': '0xto',
  'cumulativeGasUsed': '0x5208',
  'gasUsed': '0x5208',
  'logs': <Object?>[],
  'logsBloom': '0x0',
  'status': '0x1',
};

void main() {
  group('waitForTransactionReceipt', () {
    test('returns immediately when the receipt is already available', () async {
      final transport = _FakeTransport((method, params) => _receiptJson());
      final client = PublicClient(transport: transport);
      final receipt = await client.waitForTransactionReceipt(
        '0xtx',
        pollingInterval: const Duration(milliseconds: 1),
      );
      expect(receipt.transactionHash, '0xtx');
    });

    test('polls until the receipt appears', () async {
      var calls = 0;
      final transport = _FakeTransport((method, params) {
        calls++;
        return calls < 3 ? null : _receiptJson();
      });
      final client = PublicClient(transport: transport);
      final receipt = await client.waitForTransactionReceipt(
        '0xtx',
        pollingInterval: const Duration(milliseconds: 1),
      );
      expect(receipt.transactionHash, '0xtx');
      expect(calls, 3);
    });

    test('throws TimeoutException if the receipt never appears', () async {
      final transport = _FakeTransport((method, params) => null);
      final client = PublicClient(transport: transport);
      expect(
        () => client.waitForTransactionReceipt(
          '0xtx',
          pollingInterval: const Duration(milliseconds: 1),
          timeout: const Duration(milliseconds: 20),
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
