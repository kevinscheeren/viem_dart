import 'package:test/test.dart';
import 'package:viem_dart/chains.dart';

void main() {
  group('built-in chains', () {
    test('have the correct canonical chain ids', () {
      expect(mainnet.id, 1);
      expect(sepolia.id, 11155111);
      expect(base.id, 8453);
      expect(arbitrum.id, 42161);
      expect(optimism.id, 10);
      expect(polygon.id, 137);
      expect(bsc.id, 56);
      expect(avalanche.id, 43114);
      expect(anvil.id, 31337);
    });

    test('have a name and at least one RPC URL', () {
      for (final chain in [
        mainnet,
        sepolia,
        base,
        arbitrum,
        optimism,
        polygon,
        bsc,
        avalanche,
        anvil,
      ]) {
        expect(chain.name, isNotEmpty);
        expect(chain.rpcUrls, isNotEmpty);
        expect(chain.nativeCurrency.decimals, 18);
      }
    });

    test('mainnet and sepolia share ETH as native currency', () {
      expect(mainnet.nativeCurrency.symbol, 'ETH');
      expect(sepolia.nativeCurrency.symbol, 'ETH');
    });

    test('polygon uses its own native currency symbol', () {
      expect(polygon.nativeCurrency.symbol, 'POL');
    });

    test('anvil has no block explorer', () {
      expect(anvil.blockExplorer, isNull);
    });
  });

  group('Chain (freezed)', () {
    test('supports value equality', () {
      final a = mainnet;
      final b = mainnet.copyWith();
      expect(a, b);
    });

    test('copyWith produces an independent, updated instance', () {
      final custom = mainnet.copyWith(id: 999);
      expect(custom.id, 999);
      expect(mainnet.id, 1);
    });
  });
}
