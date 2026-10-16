import 'dart:convert';

import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('HttpTransport', () {
    test('sends a JSON-RPC request and decodes a result', () async {
      final mockClient = MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['method'], 'eth_chainId');
        expect(body['jsonrpc'], '2.0');
        return http.Response(
          jsonEncode({'jsonrpc': '2.0', 'id': body['id'], 'result': '0x1'}),
          200,
        );
      });

      final transport = HttpTransport(
        Uri.parse('https://example.com/rpc'),
        client: mockClient,
      );
      final response = await transport.request(
        const JsonRpcRequest(id: 1, method: 'eth_chainId'),
      );

      expect(response.result, '0x1');
      expect(response.error, isNull);
    });

    test('decodes an error response', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'jsonrpc': '2.0',
            'id': 1,
            'error': {'code': -32601, 'message': 'Method not found'},
          }),
          200,
        );
      });

      final transport = HttpTransport(
        Uri.parse('https://example.com/rpc'),
        client: mockClient,
      );
      final response = await transport.request(
        const JsonRpcRequest(id: 1, method: 'nope'),
      );

      expect(response.result, isNull);
      expect(response.error?.code, -32601);
      expect(response.error?.message, 'Method not found');
    });
  });

  group('HttpTransport with batching', () {
    test(
      'combines concurrent requests into a single JSON-RPC batch POST',
      () async {
        var postCount = 0;
        final mockClient = MockClient((request) async {
          postCount++;
          final body = jsonDecode(request.body) as List<dynamic>;
          expect(body, hasLength(3));
          final responses = body
              .cast<Map<String, dynamic>>()
              .map(
                (r) => {
                  'jsonrpc': '2.0',
                  'id': r['id'],
                  'result': '0x${r['id']}',
                },
              )
              .toList();
          return http.Response(jsonEncode(responses), 200);
        });

        final transport = HttpTransport(
          Uri.parse('https://example.com/rpc'),
          client: mockClient,
          batch: const HttpBatchConfig(),
        );

        final results = await Future.wait([
          transport.request(const JsonRpcRequest(id: 1, method: 'a')),
          transport.request(const JsonRpcRequest(id: 2, method: 'b')),
          transport.request(const JsonRpcRequest(id: 3, method: 'c')),
        ]);

        expect(postCount, 1);
        expect(results.map((r) => r.result), ['0x1', '0x2', '0x3']);
      },
    );

    test('demultiplexes out-of-order batch responses by id', () async {
      final mockClient = MockClient((request) async {
        final body = jsonDecode(request.body) as List<dynamic>;
        final responses = body
            .cast<Map<String, dynamic>>()
            .map(
              (r) => {
                'jsonrpc': '2.0',
                'id': r['id'],
                'result': '0x${r['id']}',
              },
            )
            .toList()
            .reversed // Server responds out of request order.
            .toList();
        return http.Response(jsonEncode(responses), 200);
      });

      final transport = HttpTransport(
        Uri.parse('https://example.com/rpc'),
        client: mockClient,
        batch: const HttpBatchConfig(),
      );

      final one = transport.request(const JsonRpcRequest(id: 1, method: 'a'));
      final two = transport.request(const JsonRpcRequest(id: 2, method: 'b'));

      expect((await one).result, '0x1');
      expect((await two).result, '0x2');
    });

    test('flushes early once batchSize is reached, without waiting', () async {
      var postCount = 0;
      final mockClient = MockClient((request) async {
        postCount++;
        final body = jsonDecode(request.body) as List<dynamic>;
        final responses = body
            .cast<Map<String, dynamic>>()
            .map((r) => {'jsonrpc': '2.0', 'id': r['id'], 'result': 'ok'})
            .toList();
        return http.Response(jsonEncode(responses), 200);
      });

      final transport = HttpTransport(
        Uri.parse('https://example.com/rpc'),
        client: mockClient,
        // A long wait — if batchSize didn't force an early flush, this test
        // would hang until the wait elapses.
        batch: const HttpBatchConfig(batchSize: 2, wait: Duration(seconds: 30)),
      );

      final results = await Future.wait([
        transport.request(const JsonRpcRequest(id: 1, method: 'a')),
        transport.request(const JsonRpcRequest(id: 2, method: 'b')),
      ]);

      expect(postCount, 1);
      expect(results.map((r) => r.result), ['ok', 'ok']);
    });

    test(
      'a missing id in the batch response errors only that request',
      () async {
        final mockClient = MockClient((request) async {
          final body = jsonDecode(request.body) as List<dynamic>;
          final firstId = (body.first as Map<String, dynamic>)['id'];
          return http.Response(
            jsonEncode([
              {'jsonrpc': '2.0', 'id': firstId, 'result': 'ok'},
            ]),
            200,
          );
        });

        final transport = HttpTransport(
          Uri.parse('https://example.com/rpc'),
          client: mockClient,
          batch: const HttpBatchConfig(),
        );

        final one = transport.request(const JsonRpcRequest(id: 1, method: 'a'));
        final two = transport.request(const JsonRpcRequest(id: 2, method: 'b'));

        expect((await one).result, 'ok');
        await expectLater(two, throwsA(isA<StateError>()));
      },
    );

    test('a failed batch POST errors every pending request', () async {
      final mockClient = MockClient((request) async {
        throw Exception('network down');
      });

      final transport = HttpTransport(
        Uri.parse('https://example.com/rpc'),
        client: mockClient,
        batch: const HttpBatchConfig(),
      );

      final one = transport.request(const JsonRpcRequest(id: 1, method: 'a'));
      final two = transport.request(const JsonRpcRequest(id: 2, method: 'b'));

      await expectLater(one, throwsA(anything));
      await expectLater(two, throwsA(anything));
    });
  });
}
