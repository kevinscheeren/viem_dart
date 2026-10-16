import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  group('IpcTransport', () {
    late Directory tempDir;
    late String socketPath;
    late ServerSocket server;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('viem_dart_ipc_test_');
      socketPath = '${tempDir.path}/test.ipc';
      server = await ServerSocket.bind(
        InternetAddress(socketPath, type: InternetAddressType.unix),
        0,
      );
      server.listen((socket) {
        socket.listen((data) {
          final json = jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
          socket.write(
            jsonEncode({'jsonrpc': '2.0', 'id': json['id'], 'result': '0x1'}),
          );
        });
      });
    });

    tearDown(() async {
      await server.close();
      await tempDir.delete(recursive: true);
    });

    test(
      'sends a request over the Unix socket and receives the response',
      () async {
        final transport = IpcTransport(socketPath);
        final response = await transport.request(
          const JsonRpcRequest(id: 1, method: 'eth_chainId'),
        );
        expect(response.result, '0x1');
        await transport.close();
      },
    );

    test('correlates back-to-back requests over the same connection', () async {
      final transport = IpcTransport(socketPath);
      final first = await transport.request(
        const JsonRpcRequest(id: 1, method: 'a'),
      );
      final second = await transport.request(
        const JsonRpcRequest(id: 2, method: 'b'),
      );
      expect(first.result, '0x1');
      expect(second.result, '0x1');
      await transport.close();
    });
  }, testOn: '!browser');
}
