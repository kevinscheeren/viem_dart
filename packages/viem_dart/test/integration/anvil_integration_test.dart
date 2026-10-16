@Tags(['integration'])
library;

import 'package:test/test.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/test_actions.dart';
import 'package:viem_dart/viem_dart.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

void main() {
  group('anvil integration', () {
    late AnvilHarness harness;
    late TestClient client;

    setUpAll(() async {
      harness = await AnvilHarness.start(port: 8549);
      client = TestClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
      );
    });

    tearDownAll(() async {
      await harness.stop();
    });

    group('public actions', () {
      test('getChainId matches anvil\'s chain id', () async {
        expect(await client.getChainId(), BigInt.from(31337));
      });

      test('getBlockNumber returns a non-negative block number', () async {
        expect(
          await client.getBlockNumber(),
          greaterThanOrEqualTo(BigInt.zero),
        );
      });

      test('getBalance reflects a funded default account', () async {
        final balance = await client.getBalance(harness.accounts[0].address);
        expect(balance, greaterThan(BigInt.zero));
      });

      test('getBlock returns the latest block', () async {
        final block = await client.getBlock();
        expect(block, isNotNull);
      });
    });

    group('HTTP request batching', () {
      test(
        'a batching HttpTransport gets correct results from real anvil',
        () async {
          final batchingClient = PublicClient(
            transport: HttpTransport(
              Uri.parse(harness.rpcUrl),
              batch: const HttpBatchConfig(),
            ),
            chain: anvil,
          );

          final results = await Future.wait([
            batchingClient.getChainId(),
            batchingClient.getBlockNumber(),
            batchingClient.getBalance(harness.accounts[0].address),
          ]);

          expect(results[0], BigInt.from(31337));
          expect(results[1], greaterThanOrEqualTo(BigInt.zero));
          expect(results[2], greaterThan(BigInt.zero));
        },
      );
    });

    group('watch actions (real websocket subscriptions)', () {
      test(
        'watchBlockNumber over a real anvil WebSocket receives pushed block numbers',
        () async {
          final wsTransport = WebSocketTransport(
            Uri.parse(harness.rpcUrl.replaceFirst('http://', 'ws://')),
          );
          final wsClient = PublicClient(transport: wsTransport, chain: anvil);

          final emittedFuture = wsClient.watchBlockNumber().take(2).toList();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          await client.mine(blocks: 2);

          final emitted = await emittedFuture.timeout(
            const Duration(seconds: 10),
          );
          expect(emitted.length, 2);
          expect(emitted[1] - emitted[0], BigInt.one);
        },
      );
    });

    group('wallet actions', () {
      test('sendTransaction moves ETH between funded accounts', () async {
        final sender = harness.accounts[0];
        final recipient = harness.accounts[1];
        final senderClient = WalletClient(
          transport: HttpTransport(Uri.parse(harness.rpcUrl)),
          chain: anvil,
          account: sender,
        );

        final before = await client.getBalance(recipient.address);
        const value = 1000000000000000000; // 1 ETH, in wei.

        final hash = await senderClient.sendTransaction(
          to: recipient.address,
          value: BigInt.from(value),
        );
        expect(hash, startsWith('0x'));

        await client.waitForTransactionReceipt(hash);

        final after = await client.getBalance(recipient.address);
        expect(after - before, BigInt.from(value));
      });
    });

    group('anvil test-client actions', () {
      test('setBalance overrides an account\'s balance directly', () async {
        const target = '0x1010101010101010101010101010101010101010';
        final newBalance = BigInt.parse('123456789000000000');

        await client.setBalance(address: target, value: newBalance);

        expect(await client.getBalance(target), newBalance);
      });

      test('mine advances the block number by the requested count', () async {
        final before = await client.getBlockNumber();
        await client.mine(blocks: 3);
        final after = await client.getBlockNumber();
        expect(after - before, BigInt.from(3));
      });

      test('snapshot/revert restores prior chain state', () async {
        const target = '0x2020202020202020202020202020202020202020';
        await client.setBalance(address: target, value: BigInt.from(1));

        final snapshotId = await client.snapshot();
        await client.setBalance(address: target, value: BigInt.from(2));
        expect(await client.getBalance(target), BigInt.from(2));

        await client.revert(id: snapshotId);
        expect(await client.getBalance(target), BigInt.from(1));
      });

      test(
        'impersonateAccount lets a client send from an unowned address',
        () async {
          final target = harness.accounts[2].address;
          await client.setBalance(
            address: target,
            value: BigInt.parse('5000000000000000000'),
          );
          await client.impersonateAccount(address: target);

          // No private key for `target` on this client — impersonation is
          // what makes this a valid send anyway.
          final impersonatingClient = PublicClient(
            transport: HttpTransport(Uri.parse(harness.rpcUrl)),
            chain: anvil,
          );
          final hash = await impersonatingClient.rpc.request(
            'eth_sendTransaction',
            [
              {
                'from': target,
                'to': harness.accounts[3].address,
                'value': '0xde0b6b3a7640000', // 1 ETH
              },
            ],
          );
          expect(hash, isA<String>());

          await client.stopImpersonatingAccount(address: target);
        },
      );
    });
  });
}
