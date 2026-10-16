import '../../client/client.dart';
import '../../client/log.dart';
import '../../utils/hex.dart';
import '../block_param.dart';
import '../state_override.dart';

/// Low-level state-reading actions available on every [PublicClient].
extension StateActions on PublicClient {
  /// Executes a read-only call against contract [to] without submitting a
  /// transaction (`eth_call`), returning the raw hex return data.
  ///
  /// [stateOverride] runs the call against temporarily modified account
  /// state (balances, code, storage) without touching the chain — viem's
  /// `stateOverride`. The node must support the third `eth_call` parameter
  /// (geth, anvil, reth and most hosted nodes do).
  Future<String> call({
    String? from,
    required String to,
    String? data,
    BigInt? value,
    BigInt? gas,
    BigInt? blockNumber,
    String blockTag = 'latest',
    List<AccountStateOverride>? stateOverride,
  }) async {
    final txObject = <String, Object?>{
      'from': ?from,
      'to': to,
      'data': ?data,
      if (value != null) 'value': bigIntToHex(value),
      if (gas != null) 'gas': bigIntToHex(gas),
    };
    final result = await rpc.request('eth_call', [
      txObject,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
      if (stateOverride != null) serializeStateOverride(stateOverride),
    ]);
    return result as String;
  }

  /// The bytecode deployed at [address] (`eth_getCode`), or `null` if
  /// [address] has no code (an EOA, or nothing deployed there yet).
  Future<String?> getCode(
    String address, {
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final result = await rpc.request('eth_getCode', [
      address,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
    ]);
    final code = result as String?;
    if (code == null || code == '0x') return null;
    return code;
  }

  /// The raw 32-byte storage value at [slot] for [address] (`eth_getStorageAt`).
  Future<String> getStorageAt(
    String address,
    String slot, {
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final result = await rpc.request('eth_getStorageAt', [
      address,
      slot,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
    ]);
    return result as String;
  }

  /// Event logs matching the given filter (`eth_getLogs`). Filter by a
  /// specific [blockHash], or by a [fromBlockNumber]/[fromBlockTag] to
  /// [toBlockNumber]/[toBlockTag] range (the default: all blocks).
  Future<List<Log>> getLogs({
    String? address,
    List<Object?>? topics,
    String? blockHash,
    BigInt? fromBlockNumber,
    String fromBlockTag = 'earliest',
    BigInt? toBlockNumber,
    String toBlockTag = 'latest',
  }) async {
    final filter = <String, Object?>{'address': ?address, 'topics': ?topics};
    if (blockHash != null) {
      filter['blockHash'] = blockHash;
    } else {
      filter['fromBlock'] = resolveBlockParam(
        blockNumber: fromBlockNumber,
        blockTag: fromBlockTag,
      );
      filter['toBlock'] = resolveBlockParam(
        blockNumber: toBlockNumber,
        blockTag: toBlockTag,
      );
    }

    final result = await rpc.request('eth_getLogs', [filter]);
    return (result as List<dynamic>)
        .map((e) => Log.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
