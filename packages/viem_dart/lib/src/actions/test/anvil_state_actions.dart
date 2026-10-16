import '../../client/test_client.dart';
import '../../utils/hex.dart';

/// Anvil state-mutation actions available on every [TestClient] — for driving
/// a local anvil test node, not a real network.
extension AnvilStateActions on TestClient {
  /// Mines [blocks] new blocks (`anvil_mine`), each spaced [interval]
  /// seconds apart (default `0`, i.e. as fast as possible).
  Future<void> mine({required int blocks, int interval = 0}) async {
    await rpc.request('anvil_mine', [intToHex(blocks), intToHex(interval)]);
  }

  /// Sets [address]'s balance to [value] wei (`anvil_setBalance`).
  Future<void> setBalance({
    required String address,
    required BigInt value,
  }) async {
    await rpc.request('anvil_setBalance', [address, bigIntToHex(value)]);
  }

  /// Sets the contract bytecode deployed at [address] to [bytecode] (hex)
  /// (`anvil_setCode`).
  Future<void> setCode({
    required String address,
    required String bytecode,
  }) async {
    await rpc.request('anvil_setCode', [address, bytecode]);
  }

  /// Sets [address]'s account nonce to [nonce] (`anvil_setNonce`).
  Future<void> setNonce({required String address, required int nonce}) async {
    await rpc.request('anvil_setNonce', [address, intToHex(nonce)]);
  }

  /// Sets the storage value at [slot] in [address]'s contract storage to
  /// [value] (a 32-byte hex string) (`anvil_setStorageAt`).
  Future<void> setStorageAt({
    required String address,
    required BigInt slot,
    required String value,
  }) async {
    await rpc.request('anvil_setStorageAt', [
      address,
      bigIntToHex(slot),
      value,
    ]);
  }

  /// Resets the chain to a fresh, empty state (`anvil_reset`), or — if
  /// [forkUrl] is given — re-forks from it (optionally pinned to
  /// [forkBlockNumber]).
  Future<void> reset({String? forkUrl, BigInt? forkBlockNumber}) async {
    await rpc.request('anvil_reset', [
      if (forkUrl != null)
        {
          'forking': {
            'jsonRpcUrl': forkUrl,
            if (forkBlockNumber != null) 'blockNumber': forkBlockNumber.toInt(),
          },
        },
    ]);
  }

  /// Serializes the entire chain state (all accounts, balances, storage,
  /// and block data) to a hex-encoded blob (`anvil_dumpState`), for
  /// restoring later with [loadState] — including across separate anvil
  /// processes, unlike `snapshot`/`revert`.
  Future<String> dumpState() async {
    final result = await rpc.request('anvil_dumpState');
    return result as String;
  }

  /// Restores chain state previously serialized by [dumpState]
  /// (`anvil_loadState`).
  Future<void> loadState({required String state}) async {
    await rpc.request('anvil_loadState', [state]);
  }

  /// Sets the gas limit every subsequently mined block uses
  /// (`anvil_setBlockGasLimit`).
  Future<void> setBlockGasLimit({required BigInt gasLimit}) async {
    await rpc.request('anvil_setBlockGasLimit', [bigIntToHex(gasLimit)]);
  }

  /// Sets the minimum gas price accepted for a transaction
  /// (`anvil_setMinGasPrice`) — only meaningful on a pre-EIP-1559 chain;
  /// throws an `RpcError` if EIP-1559 is active (anvil's default).
  Future<void> setMinGasPrice({required BigInt gasPrice}) async {
    await rpc.request('anvil_setMinGasPrice', [bigIntToHex(gasPrice)]);
  }

  /// Sets the base fee for the *next* mined block
  /// (`anvil_setNextBlockBaseFeePerGas`).
  Future<void> setNextBlockBaseFeePerGas({
    required BigInt baseFeePerGas,
  }) async {
    await rpc.request('anvil_setNextBlockBaseFeePerGas', [
      bigIntToHex(baseFeePerGas),
    ]);
  }

  /// Sets the address that receives mined blocks' fees
  /// (`anvil_setCoinbase`).
  Future<void> setCoinbase({required String address}) async {
    await rpc.request('anvil_setCoinbase', [address]);
  }

  /// Changes the upstream RPC endpoint a forked anvil instance reads
  /// unmodified state from (`anvil_setRpcUrl`).
  Future<void> setRpcUrl({required String url}) async {
    await rpc.request('anvil_setRpcUrl', [url]);
  }
}
