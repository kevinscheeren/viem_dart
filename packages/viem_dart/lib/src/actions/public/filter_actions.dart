import '../../client/client.dart';
import '../../client/log.dart';
import '../block_param.dart';

/// Event/block/pending-transaction filter actions available on every
/// [PublicClient]. Filters are node-side state identified by a filter id
/// (`eth_newFilter`/`eth_newBlockFilter`/`eth_newPendingTransactionFilter`);
/// poll them with [getFilterChanges] and clean up with [uninstallFilter]
/// once done.
extension FilterActions on PublicClient {
  /// Creates a log filter (`eth_newFilter`), returning its filter id.
  Future<String> createEventFilter({
    String? address,
    List<Object?>? topics,
    BigInt? fromBlockNumber,
    String fromBlockTag = 'earliest',
    BigInt? toBlockNumber,
    String toBlockTag = 'latest',
  }) async {
    final filter = <String, Object?>{
      'address': ?address,
      'topics': ?topics,
      'fromBlock': resolveBlockParam(
        blockNumber: fromBlockNumber,
        blockTag: fromBlockTag,
      ),
      'toBlock': resolveBlockParam(
        blockNumber: toBlockNumber,
        blockTag: toBlockTag,
      ),
    };
    final result = await rpc.request('eth_newFilter', [filter]);
    return result as String;
  }

  /// Creates a filter that reports new block hashes (`eth_newBlockFilter`),
  /// returning its filter id.
  Future<String> createBlockFilter() async {
    final result = await rpc.request('eth_newBlockFilter');
    return result as String;
  }

  /// Creates a filter that reports new pending transaction hashes
  /// (`eth_newPendingTransactionFilter`), returning its filter id.
  Future<String> createPendingTransactionFilter() async {
    final result = await rpc.request('eth_newPendingTransactionFilter');
    return result as String;
  }

  /// Changes since the last poll of [filterId] (`eth_getFilterChanges`):
  /// raw log objects for an event filter, or raw block/transaction hashes
  /// for a block/pending-transaction filter.
  Future<List<Object?>> getFilterChanges(String filterId) async {
    final result = await rpc.request('eth_getFilterChanges', [filterId]);
    return result as List<Object?>;
  }

  /// All logs matching an event filter's criteria since its creation
  /// (`eth_getFilterLogs`).
  Future<List<Log>> getFilterLogs(String filterId) async {
    final result = await rpc.request('eth_getFilterLogs', [filterId]);
    return (result as List<dynamic>)
        .map((e) => Log.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Removes filter [filterId] node-side (`eth_uninstallFilter`), returning
  /// whether it existed.
  Future<bool> uninstallFilter(String filterId) async {
    final result = await rpc.request('eth_uninstallFilter', [filterId]);
    return result as bool;
  }
}
