import '../../client/test_client.dart';
import '../../utils/hex.dart';

/// Anvil snapshot and time-control actions available on every [TestClient] —
/// for driving a local anvil test node, not a real network.
extension AnvilSnapshotTimeActions on TestClient {
  /// Snapshots the current chain state (`evm_snapshot`), returning an id
  /// to later restore it with [revert].
  Future<String> snapshot() async {
    final result = await rpc.request('evm_snapshot');
    return result as String;
  }

  /// Restores chain state to the snapshot [id] returned by an earlier
  /// [snapshot] call (`evm_revert`).
  Future<void> revert({required String id}) async {
    await rpc.request('evm_revert', [id]);
  }

  /// Advances the chain's clock by [seconds] (`evm_increaseTime`) — the
  /// *next* mined block's timestamp reflects the jump, not the current
  /// one.
  Future<void> increaseTime({required int seconds}) async {
    await rpc.request('evm_increaseTime', [intToHex(seconds)]);
  }

  /// Toggles automining — mining a new block for every submitted
  /// transaction — on or off (`evm_setAutomine`).
  Future<void> setAutomine({required bool enabled}) async {
    await rpc.request('evm_setAutomine', [enabled]);
  }

  /// Drops the pending transaction [hash] from the node's mempool
  /// (`anvil_dropTransaction`) without mining it.
  Future<void> dropTransaction({required String hash}) async {
    await rpc.request('anvil_dropTransaction', [hash]);
  }

  /// Sets the *next* mined block's timestamp (`evm_setNextBlockTimestamp`)
  /// — a one-off override, unlike [setBlockTimestampInterval].
  Future<void> setNextBlockTimestamp({required int timestamp}) async {
    await rpc.request('evm_setNextBlockTimestamp', [timestamp]);
  }

  /// Fixes every subsequently mined block's timestamp to be exactly
  /// [seconds] after the previous one (`anvil_setBlockTimestampInterval`),
  /// until [removeBlockTimestampInterval] is called.
  Future<void> setBlockTimestampInterval({required int seconds}) async {
    await rpc.request('anvil_setBlockTimestampInterval', [seconds]);
  }

  /// Reverses [setBlockTimestampInterval]
  /// (`anvil_removeBlockTimestampInterval`) — mined blocks go back to
  /// using the real wall-clock time.
  Future<void> removeBlockTimestampInterval() async {
    await rpc.request('anvil_removeBlockTimestampInterval');
  }

  /// Mines a new block automatically every [seconds]
  /// (`anvil_setIntervalMining`), instead of per-submitted-transaction
  /// ([setAutomine]) or only on an explicit [TestClient] `mine` call.
  Future<void> setIntervalMining({required int seconds}) async {
    await rpc.request('anvil_setIntervalMining', [seconds]);
  }

  /// Whether automining (a new block per submitted transaction) is
  /// currently enabled (`anvil_getAutomine`) — see [setAutomine].
  Future<bool> getAutomine() async {
    final result = await rpc.request('anvil_getAutomine');
    return result as bool;
  }

  /// Toggles anvil's own request/response logging to its console
  /// (`anvil_setLoggingEnabled`) — unrelated to this package's own logging,
  /// if any; this only affects the anvil process's own output.
  Future<void> setLoggingEnabled({required bool enabled}) async {
    await rpc.request('anvil_setLoggingEnabled', [enabled]);
  }
}
