import 'package:test/test.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

void main() {
  // The anvil-backed behavioral tests (spawning a real process, checking
  // RPC reachability) live in test/integration/ — this file holds the
  // plain-Dart-logic checks that don't need anvil itself, so `dart test
  // --exclude-tags=integration` (this package's default `test:dart` run)
  // always has something to run.
  test('anvilDefaultMnemonic matches anvil/Hardhat\'s well-known default', () {
    expect(
      anvilDefaultMnemonic,
      'test test test test test test test test test test test junk',
    );
  });

  group('anvilArguments', () {
    test('starts an empty chain on the port with the default mnemonic', () {
      expect(AnvilHarness.anvilArguments(port: 8600), [
        '--port',
        '8600',
        '--mnemonic',
        anvilDefaultMnemonic,
      ]);
    });

    test('forks the URL at the pinned block with a low request budget', () {
      final args = AnvilHarness.anvilArguments(
        port: 8600,
        forkUrl: 'https://rpc.example.invalid',
        forkBlockNumber: 123,
      );
      expect(
        args.join(' '),
        contains(
          '--fork-url https://rpc.example.invalid --fork-block-number 123',
        ),
      );
      expect(args, containsAll(['--compute-units-per-second', '--retries']));
    });

    test(
      'refuses a fork without a pinned block, and a block without a URL',
      () {
        expect(
          () => AnvilHarness.anvilArguments(
            port: 1,
            forkUrl: 'https://x.invalid',
          ),
          throwsArgumentError,
        );
        expect(
          () => AnvilHarness.anvilArguments(port: 1, forkBlockNumber: 5),
          throwsArgumentError,
        );
      },
    );
  });
}
