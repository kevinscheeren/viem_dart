import '../../client/client.dart';
import '../../client/fee_history.dart';
import '../../utils/hex.dart';
import '../block_param.dart';
import 'public_actions.dart'; // for PublicClient.getBlock(), used by estimateFeesPerGas

/// A fallback priority fee used by [GasActions.estimateFeesPerGas] when the
/// node doesn't support `eth_maxPriorityFeePerGas` (1.5 gwei, matching
/// viem's own default).
final BigInt _fallbackMaxPriorityFeePerGas = BigInt.from(1500000000);

/// Gas-price and fee-estimation actions available on every [PublicClient].
extension GasActions on PublicClient {
  /// The node's current gas price (`eth_gasPrice`) — the legacy,
  /// pre-EIP-1559 fee model.
  Future<BigInt> getGasPrice() async {
    final result = await rpc.request('eth_gasPrice');
    return hexToBigInt(result as String);
  }

  /// Estimates the gas a transaction would use (`eth_estimateGas`), without
  /// submitting it.
  Future<BigInt> estimateGas({
    String? from,
    String? to,
    String? data,
    BigInt? value,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final txObject = <String, Object?>{
      'from': ?from,
      'to': ?to,
      'data': ?data,
      if (value != null) 'value': bigIntToHex(value),
    };
    final result = await rpc.request('eth_estimateGas', [
      txObject,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
    ]);
    return hexToBigInt(result as String);
  }

  /// Estimates EIP-1559 `maxFeePerGas`/`maxPriorityFeePerGas` for a
  /// transaction likely to be included soon: `maxPriorityFeePerGas` comes
  /// from `eth_maxPriorityFeePerGas` (falling back to 1.5 gwei if the node
  /// doesn't support it), and `maxFeePerGas` is `2 * baseFeePerGas +
  /// maxPriorityFeePerGas` — the same heuristic viem's default estimator
  /// uses.
  Future<({BigInt maxFeePerGas, BigInt maxPriorityFeePerGas})>
  estimateFeesPerGas() async {
    final block = await getBlock();
    final baseFeePerGas = block?.baseFeePerGas;
    if (baseFeePerGas == null) {
      throw StateError(
        'estimateFeesPerGas requires an EIP-1559 chain (the latest block has no baseFeePerGas).',
      );
    }

    BigInt maxPriorityFeePerGas;
    try {
      final result = await rpc.request('eth_maxPriorityFeePerGas');
      maxPriorityFeePerGas = hexToBigInt(result as String);
    } catch (_) {
      maxPriorityFeePerGas = _fallbackMaxPriorityFeePerGas;
    }

    final maxFeePerGas = baseFeePerGas * BigInt.two + maxPriorityFeePerGas;
    return (
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
    );
  }

  /// Historical base fees, gas-used ratios, and (if [rewardPercentiles] is
  /// given) priority-fee percentiles for the [blockCount] blocks ending at
  /// [newestBlockNumber]/[newestBlockTag] (`eth_feeHistory`).
  Future<FeeHistory> getFeeHistory({
    required int blockCount,
    BigInt? newestBlockNumber,
    String newestBlockTag = 'latest',
    List<double>? rewardPercentiles,
  }) async {
    final result = await rpc.request('eth_feeHistory', [
      intToHex(blockCount),
      resolveBlockParam(
        blockNumber: newestBlockNumber,
        blockTag: newestBlockTag,
      ),
      rewardPercentiles ?? const <double>[],
    ]);
    return FeeHistory.fromJson(result as Map<String, dynamic>);
  }
}
