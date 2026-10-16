/// Spawns and manages a local `anvil` (Foundry) process for viem_dart's
/// integration test suite.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:viem_dart/accounts.dart';

/// Anvil's own default startup mnemonic — the same one Hardhat uses, and
/// the one already relied on throughout viem_dart's own unit tests.
const String anvilDefaultMnemonic =
    'test test test test test test test test test test test junk';

/// Spawns and manages a local `anvil` process for integration tests:
/// starts it listening on [port], waits until it's ready to accept RPC
/// connections, and derives its funded default accounts — via viem_dart's
/// own [mnemonicToAccount], not hardcoded, so an account's address and
/// private key always agree exactly with what viem_dart itself derives
/// (verified against anvil's own printed accounts before relying on
/// this).
///
/// `dart:io`-only by nature (spawns a real OS process) — this package is
/// `publish_to: none` and never meant to run anywhere but a Dart VM test
/// runner.
class AnvilHarness {
  AnvilHarness._(this._process, this.rpcUrl, this.accounts);

  final Process _process;

  /// The local RPC URL anvil is listening on (`http://127.0.0.1:<port>`).
  final String rpcUrl;

  /// [accounts] funded default accounts, derived from
  /// [anvilDefaultMnemonic] at address indices `0..accounts.length - 1` —
  /// the same accounts anvil itself prints (and funds) on startup.
  final List<LocalAccount> accounts;

  /// The `anvil` command-line arguments for [port], optionally forking
  /// [forkUrl] at [forkBlockNumber] (both or neither; a fork without a pinned
  /// block would test against a moving target, so it is refused).
  ///
  /// A fork reads state over the network from a public, rate-limited
  /// endpoint, so it is started with a low request budget and generous
  /// retries; anvil caches what it fetched on disk, so a rerun at the same
  /// block is cheap.
  static List<String> anvilArguments({
    required int port,
    String? forkUrl,
    int? forkBlockNumber,
  }) {
    if ((forkUrl == null) != (forkBlockNumber == null)) {
      throw ArgumentError(
        'forkUrl and forkBlockNumber go together: a fork must be pinned to '
        'a block.',
      );
    }
    return [
      '--port',
      '$port',
      '--mnemonic',
      anvilDefaultMnemonic,
      if (forkUrl != null) ...[
        '--fork-url',
        forkUrl,
        '--fork-block-number',
        '$forkBlockNumber',
        '--compute-units-per-second',
        '20',
        '--retries',
        '20',
        '--fork-retry-backoff',
        '1000',
      ],
    ];
  }

  /// Starts a fresh anvil process on [port] (anvil's own default: 8545),
  /// waiting up to [startupTimeout] for its "Listening on ..." readiness
  /// line. [accountCount] accounts (default 10, matching anvil's own
  /// default) are derived and exposed via [accounts].
  ///
  /// With [forkUrl] and [forkBlockNumber], anvil forks that chain at that
  /// block (the chain id, contracts and balances are the real ones; the
  /// default accounts are still funded). The startup timeout then defaults
  /// to a minute, as fetching the fork's first state can be slow.
  ///
  /// Throws [ProcessException] if `anvil` isn't on `PATH` (install
  /// Foundry: https://getfoundry.sh), or [StateError] if it doesn't
  /// become ready within [startupTimeout].
  static Future<AnvilHarness> start({
    int port = 8545,
    int accountCount = 10,
    String? forkUrl,
    int? forkBlockNumber,
    Duration? startupTimeout,
  }) async {
    final arguments = anvilArguments(
      port: port,
      forkUrl: forkUrl,
      forkBlockNumber: forkBlockNumber,
    );
    final timeout =
        startupTimeout ??
        (forkUrl == null
            ? const Duration(seconds: 15)
            : const Duration(minutes: 1));
    final process = await Process.start('anvil', arguments);

    final ready = Completer<void>();
    final stdoutSub = process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
          if (line.contains('Listening on') && !ready.isCompleted) {
            ready.complete();
          }
        });
    // Anvil writes nothing meaningful to stderr on a normal startup, but
    // drain it regardless — an unread stderr pipe can deadlock the child
    // process once its buffer fills.
    final stderrSub = process.stderr.drain<void>();

    try {
      await ready.future.timeout(timeout);
    } on TimeoutException {
      process.kill();
      throw StateError(
        'anvil did not print its "Listening on" readiness line within '
        '$timeout.',
      );
    } finally {
      await stdoutSub.cancel();
    }
    unawaited(stderrSub);

    final accounts = List.generate(
      accountCount,
      (i) => mnemonicToAccount(anvilDefaultMnemonic, addressIndex: i),
    );

    return AnvilHarness._(process, 'http://127.0.0.1:$port', accounts);
  }

  /// Stops the anvil process and waits for it to exit.
  Future<void> stop() async {
    _process.kill();
    await _process.exitCode;
  }
}
