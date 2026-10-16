@Tags(['integration'])
library;

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

void main() {
  group('AnvilHarness', () {
    late AnvilHarness harness;

    setUp(() async {
      harness = await AnvilHarness.start(port: 8548);
    });

    tearDown(() async {
      await harness.stop();
    });

    test('exposes 10 funded default accounts', () {
      expect(harness.accounts, hasLength(10));
      // The first two match anvil's own well-known default output —
      // cross-checked directly against a real anvil process before
      // relying on this in the harness itself.
      expect(
        harness.accounts[0].address,
        '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
      );
      expect(
        harness.accounts[1].address,
        '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
      );
    });

    test('is reachable over RPC and its accounts are pre-funded', () async {
      final client = createPublicClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
      );

      expect(await client.getChainId(), BigInt.from(31337));

      final balance = await client.getBalance(harness.accounts.first.address);
      expect(balance, greaterThan(BigInt.zero));
    });
  });
}
