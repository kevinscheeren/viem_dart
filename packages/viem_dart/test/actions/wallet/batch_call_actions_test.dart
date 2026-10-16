import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
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

Map<String, Object?> _statusJson({
  required int status,
  bool withReceipts = false,
}) => {
  'version': '2.0.0',
  'id': '0xbatch',
  'chainId': '0x1',
  'status': status,
  'atomic': true,
  if (withReceipts)
    'receipts': [
      {
        'logs': <Object?>[],
        'status': '0x1',
        'blockHash': '0xblock',
        'blockNumber': '0x1',
        'gasUsed': '0x5208',
        'transactionHash': '0xtx',
      },
    ],
};

void main() {
  final account = privateKeyToAccount(hexToBytes(padHex('0x1')));

  group('sendCalls', () {
    test(
      'sends the EIP-5792 request shape and returns id/capabilities',
      () async {
        Map<String, Object?>? sentParams;
        final transport = _FakeTransport((method, params) {
          switch (method) {
            case 'eth_chainId':
              return '0x1';
            case 'wallet_sendCalls':
              sentParams = params[0] as Map<String, Object?>;
              return {
                'id': '0xbatch',
                'capabilities': {'atomic': true},
              };
            default:
              throw StateError('unexpected method $method');
          }
        });
        final client = WalletClient(transport: transport, account: account);

        final result = await client.sendCalls(
          calls: [
            (to: '0xaaa', data: '0xdeadbeef', value: BigInt.from(1000)),
            (to: '0xbbb', data: null, value: null),
          ],
        );

        expect(result.id, '0xbatch');
        expect(result.capabilities, {'atomic': true});
        expect(sentParams!['version'], '2.0.0');
        expect(sentParams!['from'], account.address);
        expect(sentParams!['chainId'], '0x1');
        expect(sentParams!['atomicRequired'], true);
        final calls = sentParams!['calls'] as List<Object?>;
        expect(calls, [
          {'to': '0xaaa', 'data': '0xdeadbeef', 'value': '0x3e8'},
          {'to': '0xbbb'},
        ]);
        expect(sentParams!.containsKey('id'), isFalse);
      },
    );

    test('omits capabilities when not given', () async {
      Map<String, Object?>? sentParams;
      final transport = _FakeTransport((method, params) {
        switch (method) {
          case 'eth_chainId':
            return '0x1';
          case 'wallet_sendCalls':
            sentParams = params[0] as Map<String, Object?>;
            return {'id': '0xbatch'};
          default:
            throw StateError('unexpected method $method');
        }
      });
      final client = WalletClient(transport: transport, account: account);

      await client.sendCalls(calls: [(to: '0xaaa', data: null, value: null)]);

      expect(sentParams!.containsKey('capabilities'), isFalse);
    });
  });

  group('getCallsStatus', () {
    test('parses a pending status with no receipts', () async {
      final transport = _FakeTransport(
        (method, params) => _statusJson(status: 100),
      );
      final client = WalletClient(transport: transport, account: account);

      final status = await client.getCallsStatus('0xbatch');

      expect(status.status, 100);
      expect(status.atomic, isTrue);
      expect(status.chainId, BigInt.one);
      expect(status.receipts, isNull);
    });

    test('parses a completed status with receipts/logs', () async {
      final transport = _FakeTransport(
        (method, params) => _statusJson(status: 200, withReceipts: true),
      );
      final client = WalletClient(transport: transport, account: account);

      final status = await client.getCallsStatus('0xbatch');

      expect(status.status, 200);
      expect(status.receipts, hasLength(1));
      expect(status.receipts!.single.status, 1);
      expect(status.receipts!.single.transactionHash, '0xtx');
      expect(status.receipts!.single.gasUsed, BigInt.from(21000));
    });
  });

  group('waitForCallsStatus', () {
    test('returns immediately once status is no longer pending', () async {
      final transport = _FakeTransport(
        (method, params) => _statusJson(status: 200),
      );
      final client = WalletClient(transport: transport, account: account);

      final status = await client.waitForCallsStatus(
        '0xbatch',
        pollingInterval: const Duration(milliseconds: 1),
      );
      expect(status.status, 200);
    });

    test('polls until the status is no longer pending', () async {
      var calls = 0;
      final transport = _FakeTransport((method, params) {
        calls++;
        return _statusJson(status: calls < 3 ? 100 : 200);
      });
      final client = WalletClient(transport: transport, account: account);

      final status = await client.waitForCallsStatus(
        '0xbatch',
        pollingInterval: const Duration(milliseconds: 1),
      );
      expect(status.status, 200);
      expect(calls, 3);
    });

    test('throws WaitForCallsStatusTimeoutError if it never completes', () {
      final transport = _FakeTransport(
        (method, params) => _statusJson(status: 100),
      );
      final client = WalletClient(transport: transport, account: account);

      expect(
        () => client.waitForCallsStatus(
          '0xbatch',
          pollingInterval: const Duration(milliseconds: 1),
          timeout: const Duration(milliseconds: 20),
        ),
        throwsA(isA<WaitForCallsStatusTimeoutError>()),
      );
    });
  });
}
