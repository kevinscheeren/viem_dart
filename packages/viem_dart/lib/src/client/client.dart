import '../chain/chain.dart';
import '../transports/transport.dart';
import 'rpc_client.dart';

/// Configures [PublicClient.readContract] auto-batching: concurrent calls
/// arriving within [wait] of each other (or once [batchSize] accumulates,
/// whichever comes first) — and that share the same block context
/// (`blockNumber`/`blockTag`), since a multicall executes every sub-call
/// against one block — are combined into a single `multicall` instead of
/// each issuing its own `eth_call`.
///
/// Mirrors viem's `batch.multicall` client option, simplified: viem sizes
/// `batchSize` in calldata bytes (to stay under RPC/gas payload limits);
/// this counts calls instead, which is simpler and good enough for the
/// vast majority of real call volumes.
class MulticallBatchConfig {
  /// Creates a [MulticallBatchConfig].
  const MulticallBatchConfig({
    this.batchSize = 1024,
    this.wait = Duration.zero,
    this.multicallAddress,
  });

  /// The most calls to combine into a single multicall.
  final int batchSize;

  /// How long to wait for more calls to join a batch before sending it.
  final Duration wait;

  /// Overrides the deployed Multicall3 address to call — defaults to
  /// `MulticallActions.multicall3Address` (the same on every chain it's
  /// deployed on) when `null`.
  final String? multicallAddress;
}

/// The base client: a [Transport] plus an optional [Chain], with a shared
/// [RpcClient] for making requests. Read-only "public actions" (`getBalance`,
/// `getBlock`, `call`, ...) are Dart extension methods on [PublicClient] —
/// importing `viem_dart.dart` brings them into scope.
///
/// viem composes clients dynamically at runtime via `.extend()`, adding
/// bundles of "actions" (plain functions that take a client). Dart has no
/// direct equivalent of that dynamic object-spread — but it doesn't need
/// one: viem's actions are already just functions over a client, and Dart's
/// own extension methods are exactly that, resolved statically by whatever
/// you import.
///
/// [WalletClient] and [TestClient] extend [PublicClient] (rather than being
/// unrelated types) so a wallet- or anvil-created client can still use
/// ordinary read actions — more useful in practice than viem's default
/// (a wallet client doesn't get public actions unless explicitly composed).
/// Extension methods resolve by static type, so declaring an action
/// `on WalletClient` (rather than `on PublicClient`) makes it a *compile
/// error* to call a wallet-only action against a client with no account —
/// something viem's structural typing can't fully guarantee, since it
/// still needs a runtime check in the general case.
class PublicClient {
  /// Creates a [PublicClient] over [transport], with an optional [chain]
  /// and [multicallBatch] config.
  PublicClient({required this.transport, this.chain, this.multicallBatch})
    : rpc = RpcClient(transport);

  final Transport transport;
  final Chain? chain;
  final RpcClient rpc;

  /// When set, [PublicClient.readContract] (see `contract_actions.dart`)
  /// auto-batches concurrent calls into a single `multicall` instead of
  /// one `eth_call` per call. `null` (the default) sends every call
  /// individually.
  final MulticallBatchConfig? multicallBatch;
}
