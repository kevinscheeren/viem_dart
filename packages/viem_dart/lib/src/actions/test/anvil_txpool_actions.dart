import '../../client/test_client.dart';
import '../../utils/hex.dart';

/// Anvil mempool-inspection actions available on every [TestClient] — for
/// driving a local anvil test node, not a real network.
extension AnvilTxpoolActions on TestClient {
  /// Counts pending (executable) and queued (nonce-gapped, not yet
  /// executable) transactions in the mempool (`txpool_status`).
  Future<({int pending, int queued})> getTxpoolStatus() async {
    final result = await rpc.request('txpool_status') as Map<String, Object?>;
    return (
      pending: hexToInt(result['pending'] as String),
      queued: hexToInt(result['queued'] as String),
    );
  }

  /// Full pending/queued mempool contents, keyed by sender address then
  /// nonce (`txpool_content`) — raw decoded JSON, since the shape is a
  /// large, loosely-structured transaction object not worth a dedicated
  /// model here.
  Future<Map<String, Object?>> getTxpoolContent() async {
    final result = await rpc.request('txpool_content');
    return result as Map<String, Object?>;
  }

  /// A human-readable one-line-per-transaction summary of the mempool
  /// (`txpool_inspect`), rather than [getTxpoolContent]'s full objects.
  Future<Map<String, Object?>> inspectTxpool() async {
    final result = await rpc.request('txpool_inspect');
    return result as Map<String, Object?>;
  }
}
