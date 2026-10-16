import '../../client/block.dart';
import '../../client/client.dart';
import '../../client/transaction.dart';
import '../../client/transaction_receipt.dart';
import '../../utils/hex.dart';
import '../block_param.dart';

/// Read-only chain-state actions available on every [PublicClient].
extension PublicActions on PublicClient {
  /// The number of the most recent block (`eth_blockNumber`).
  Future<BigInt> getBlockNumber() async {
    final result = await rpc.request('eth_blockNumber');
    return hexToBigInt(result as String);
  }

  /// The chain id the node is connected to (`eth_chainId`).
  Future<BigInt> getChainId() async {
    final result = await rpc.request('eth_chainId');
    return hexToBigInt(result as String);
  }

  /// The balance (in wei) of [address] at [blockNumber]/[blockTag]
  /// (`eth_getBalance`).
  Future<BigInt> getBalance(
    String address, {
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final result = await rpc.request('eth_getBalance', [
      address,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
    ]);
    return hexToBigInt(result as String);
  }

  /// The block identified by [blockHash], or by [blockNumber]/[blockTag]
  /// when [blockHash] isn't given (`eth_getBlockByHash`/
  /// `eth_getBlockByNumber`). Returns `null` if no such block exists yet
  /// (e.g. a not-yet-mined [blockNumber]).
  Future<Block?> getBlock({
    String? blockHash,
    BigInt? blockNumber,
    String blockTag = 'latest',
    bool includeTransactions = false,
  }) async {
    final result = blockHash != null
        ? await rpc.request('eth_getBlockByHash', [
            blockHash,
            includeTransactions,
          ])
        : await rpc.request('eth_getBlockByNumber', [
            resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
            includeTransactions,
          ]);
    if (result == null) return null;
    return Block.fromJson(result as Map<String, dynamic>);
  }

  /// The transaction identified by [hash] (`eth_getTransactionByHash`).
  /// Returns `null` if not found (e.g. still pending on some nodes, or
  /// unknown).
  Future<Transaction?> getTransaction(String hash) async {
    final result = await rpc.request('eth_getTransactionByHash', [hash]);
    if (result == null) return null;
    return Transaction.fromJson(result as Map<String, dynamic>);
  }

  /// The receipt for the transaction identified by [hash]
  /// (`eth_getTransactionReceipt`). Returns `null` if the transaction
  /// hasn't been mined yet.
  Future<TransactionReceipt?> getTransactionReceipt(String hash) async {
    final result = await rpc.request('eth_getTransactionReceipt', [hash]);
    if (result == null) return null;
    return TransactionReceipt.fromJson(result as Map<String, dynamic>);
  }

  /// The number of transactions [address] has sent as of
  /// [blockNumber]/[blockTag] — i.e. its next nonce
  /// (`eth_getTransactionCount`).
  Future<int> getTransactionCount(
    String address, {
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final result = await rpc.request('eth_getTransactionCount', [
      address,
      resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
    ]);
    return hexToInt(result as String);
  }
}
