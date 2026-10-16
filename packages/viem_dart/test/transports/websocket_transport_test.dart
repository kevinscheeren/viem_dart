import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('WebSocketTransport', () {
    late HttpServer server;
    late Uri url;

    setUp(() async {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      url = Uri.parse('ws://127.0.0.1:${server.port}');
      server.listen((request) async {
        final socket = await WebSocketTransformer.upgrade(request);
        socket.listen((message) {
          final json = jsonDecode(message as String) as Map<String, dynamic>;
          if (json['method'] == 'eth_subscribe') {
            // Echo back a subscription notification with no top-level id,
            // followed by the actual response — proves notifications are
            // routed separately from id-matched responses.
            socket.add(
              jsonEncode({
                'method': 'eth_subscription',
                'params': {'subscription': '0xabc', 'result': 'ping'},
              }),
            );
          }
          socket.add(
            jsonEncode({'jsonrpc': '2.0', 'id': json['id'], 'result': '0x1'}),
          );
        });
      });
    });

    tearDown(() async {
      await server.close(force: true);
    });

    test('sends a request and receives the matching response', () async {
      final transport = WebSocketTransport(url);
      final response = await transport.request(
        const JsonRpcRequest(id: 1, method: 'eth_chainId'),
      );
      expect(response.result, '0x1');
      await transport.close();
    });

    test('correlates concurrent requests by id', () async {
      final transport = WebSocketTransport(url);
      final results = await Future.wait([
        transport.request(const JsonRpcRequest(id: 1, method: 'a')),
        transport.request(const JsonRpcRequest(id: 2, method: 'b')),
        transport.request(const JsonRpcRequest(id: 3, method: 'c')),
      ]);
      expect(results.map((r) => r.result), ['0x1', '0x1', '0x1']);
      await transport.close();
    });

    test(
      'routes id-less messages to notifications, not the response future',
      () async {
        final transport = WebSocketTransport(url);
        final notification = transport.notifications.first;
        final response = await transport.request(
          const JsonRpcRequest(id: 1, method: 'eth_subscribe'),
        );
        expect(response.result, '0x1');
        final decoded = await notification;
        expect(decoded['method'], 'eth_subscription');
        await transport.close();
      },
    );
  });
}
