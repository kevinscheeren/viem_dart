import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

/// A minimal fake JSON-RPC-over-WebSocket node: [onSubscribe] is called
/// with the subscription type and args from each `eth_subscribe` call and
/// returns the notification `result` payloads (raw JSON-encodable values —
/// a map for `newHeads`/`logs`, a plain string hash for
/// `newPendingTransactions`) to push immediately after responding with a
/// subscription id. `eth_unsubscribe` is acknowledged automatically and
/// recorded in [unsubscribed].
class _FakeSubscriptionServer {
  _FakeSubscriptionServer(this.onSubscribe, {this.onOtherMethod});

  final List<Object?> Function(
    String subscriptionType,
    List<Object?> subscribeArgs,
  )
  onSubscribe;

  /// Handles any request other than `eth_subscribe`/`eth_unsubscribe` —
  /// e.g. `eth_getBlockByNumber`, which `watchBlocks` still calls normally
  /// after being notified of a new block number.
  final Object? Function(String method, List<Object?> params)? onOtherMethod;

  final List<String> unsubscribed = [];

  late HttpServer _server;
  Uri get url => Uri.parse('ws://127.0.0.1:${_server.port}');
  int _nextSubscriptionId = 1;

  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server.listen((request) async {
      final socket = await WebSocketTransformer.upgrade(request);
      socket.listen((message) {
        final json = jsonDecode(message as String) as Map<String, dynamic>;
        final method = json['method'] as String;
        final params = json['params'] as List<Object?>? ?? const [];
        switch (method) {
          case 'eth_subscribe':
            final subscriptionId = '0xsub${_nextSubscriptionId++}';
            socket.add(
              jsonEncode({
                'jsonrpc': '2.0',
                'id': json['id'],
                'result': subscriptionId,
              }),
            );
            final subscriptionType = params[0] as String;
            final subscribeArgs = params.skip(1).toList();
            for (final result in onSubscribe(subscriptionType, subscribeArgs)) {
              socket.add(
                jsonEncode({
                  'method': 'eth_subscription',
                  'params': {'subscription': subscriptionId, 'result': result},
                }),
              );
            }
          case 'eth_unsubscribe':
            unsubscribed.add(params[0] as String);
            socket.add(
              jsonEncode({'jsonrpc': '2.0', 'id': json['id'], 'result': true}),
            );
          default:
            socket.add(
              jsonEncode({
                'jsonrpc': '2.0',
                'id': json['id'],
                'result': onOtherMethod?.call(method, params),
              }),
            );
        }
      });
    });
  }

  Future<void> stop() => _server.close(force: true);
}

void main() {
  group('watch* actions over WebSocketTransport', () {
    late _FakeSubscriptionServer server;
    late WebSocketTransport transport;
    late PublicClient client;

    tearDown(() async {
      await transport.close();
      await server.stop();
    });

    test('watchBlockNumber uses eth_subscribe("newHeads")', () async {
      server = _FakeSubscriptionServer((type, args) {
        expect(type, 'newHeads');
        expect(args, isEmpty);
        return [
          {'number': '0x1'},
          {'number': '0x2'},
          {'number': '0x3'},
        ];
      });
      await server.start();
      transport = WebSocketTransport(server.url);
      client = PublicClient(transport: transport);

      final emitted = await client.watchBlockNumber().take(3).toList();
      expect(emitted, [BigInt.one, BigInt.two, BigInt.from(3)]);

      // Give the stream's `finally` block a tick to send eth_unsubscribe.
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(server.unsubscribed, ['0xsub1']);
    });

    test('watchBlocks sources block numbers from the subscription, then '
        'fetches each full block normally', () async {
      Map<String, Object?> block(String number) => {
        'number': number,
        'parentHash': '0x0',
        'sha3Uncles': '0x0',
        'transactionsRoot': '0x0',
        'stateRoot': '0x0',
        'receiptsRoot': '0x0',
        'miner': '0x0',
        'difficulty': '0x0',
        'extraData': '0x',
        'size': '0x0',
        'gasLimit': '0x0',
        'gasUsed': '0x0',
        'timestamp': '0x0',
        'transactions': <String>[],
        'uncles': <String>[],
      };
      server = _FakeSubscriptionServer(
        (type, args) => [
          {'number': '0x1'},
          {'number': '0x2'},
        ],
        onOtherMethod: (method, params) {
          expect(method, 'eth_getBlockByNumber');
          final number = params[0] as String;
          return block(number);
        },
      );
      await server.start();
      transport = WebSocketTransport(server.url);
      client = PublicClient(transport: transport);

      final emitted = await client.watchBlocks().take(2).toList();
      expect(emitted.map((b) => b.number), [BigInt.one, BigInt.two]);
    });

    test(
      'watchPendingTransactions uses eth_subscribe("newPendingTransactions")',
      () async {
        server = _FakeSubscriptionServer((type, args) {
          expect(type, 'newPendingTransactions');
          return ['0xtx1', '0xtx2'];
        });
        await server.start();
        transport = WebSocketTransport(server.url);
        client = PublicClient(transport: transport);

        final emitted = await client
            .watchPendingTransactions()
            .take(2)
            .toList();
        expect(emitted, ['0xtx1', '0xtx2']);
      },
    );

    test('watchEvent uses eth_subscribe("logs", filter)', () async {
      server = _FakeSubscriptionServer((type, args) {
        expect(type, 'logs');
        expect(args.single, {
          'address': '0xcontract',
          'topics': ['0xtopic'],
        });
        return [
          {
            'address': '0xcontract',
            'topics': <String>['0xtopic'],
            'data': '0x',
          },
        ];
      });
      await server.start();
      transport = WebSocketTransport(server.url);
      client = PublicClient(transport: transport);

      final emitted = await client
          .watchEvent(address: '0xcontract', topics: const ['0xtopic'])
          .take(1)
          .toList();
      expect(emitted.single.address, '0xcontract');
    });

    test(
      'no notification is lost even when pushed immediately after the subscribe response',
      () async {
        // Regression test for the broadcast-stream-drops-late-listener race:
        // the fake server pushes 20 notifications in the same synchronous
        // burst as the subscribe response, before the client has any chance
        // to schedule work in response to it.
        server = _FakeSubscriptionServer(
          (type, args) => List.generate(
            20,
            (i) => {'number': '0x${(i + 1).toRadixString(16)}'},
          ),
        );
        await server.start();
        transport = WebSocketTransport(server.url);
        client = PublicClient(transport: transport);

        final emitted = await client.watchBlockNumber().take(20).toList();
        expect(emitted, List.generate(20, (i) => BigInt.from(i + 1)));
      },
    );

    test(
      'concurrent subscriptions on one transport don\'t cross-talk',
      () async {
        server = _FakeSubscriptionServer((type, args) {
          return type == 'newHeads'
              ? [
                  {'number': '0x1'},
                ]
              : ['0xtx1'];
        });
        await server.start();
        transport = WebSocketTransport(server.url);
        client = PublicClient(transport: transport);

        final blockNumbers = client.watchBlockNumber().take(1).toList();
        final pendingTx = client.watchPendingTransactions().take(1).toList();

        expect(await blockNumbers, [BigInt.one]);
        expect(await pendingTx, ['0xtx1']);
      },
    );
  });
}
