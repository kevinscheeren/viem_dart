import 'dart:async';

import '../../client/block.dart';
import '../../client/client.dart';
import '../../client/log.dart';
import '../../transports/websocket_transport.dart';
import '../../utils/hex.dart';
import 'filter_actions.dart'; // for PublicClient filter actions
import 'public_actions.dart'; // for PublicClient.getBlockNumber()/getBlock()

/// The default polling interval for `watch*` actions, matching viem's
/// default.
const Duration _defaultPollingInterval = Duration(seconds: 4);

/// "Watch" actions available on every [PublicClient]. Each returns a
/// [Stream] — cancel it (`subscription.cancel()`) to stop watching and
/// clean up any underlying filter/subscription, the same role viem's
/// returned `unwatch` function plays.
///
/// When [PublicClient.transport] is a [WebSocketTransport], these use real
/// `eth_subscribe`/`eth_unsubscribe` push notifications instead of polling
/// — no wasted round-trips, and updates arrive as soon as the node emits
/// them. Any other transport (including a [FallbackTransport] that happens
/// to wrap a `WebSocketTransport` — subscriptions need one stable
/// connection, which per-request fallback can't provide) falls back to the
/// original polling implementation.
extension WatchActions on PublicClient {
  /// Emits each new block number as it's produced.
  Stream<BigInt> watchBlockNumber({
    Duration pollingInterval = _defaultPollingInterval,
  }) {
    final ws = transport;
    return ws is WebSocketTransport
        ? _watchBlockNumberViaSubscription(ws)
        : _watchBlockNumberViaPolling(pollingInterval: pollingInterval);
  }

  Stream<BigInt> _watchBlockNumberViaPolling({
    required Duration pollingInterval,
  }) async* {
    BigInt? last;
    while (true) {
      final current = await getBlockNumber();
      if (last == null || current > last) {
        last = current;
        yield current;
      }
      await Future<void>.delayed(pollingInterval);
    }
  }

  Stream<BigInt> _watchBlockNumberViaSubscription(WebSocketTransport ws) =>
      _subscribe(ws, 'newHeads', const []).map(
        (result) =>
            hexToBigInt((result as Map<String, dynamic>)['number'] as String),
      );

  /// Emits each new block as it's produced, from [watchBlockNumber] (so it
  /// inherits the push-vs-poll behavior above) followed by a [getBlock]
  /// fetch for the full, normalized block data.
  Stream<Block> watchBlocks({
    Duration pollingInterval = _defaultPollingInterval,
    bool includeTransactions = false,
  }) async* {
    await for (final blockNumber in watchBlockNumber(
      pollingInterval: pollingInterval,
    )) {
      final block = await getBlock(
        blockNumber: blockNumber,
        includeTransactions: includeTransactions,
      );
      if (block != null) yield block;
    }
  }

  /// Emits each new pending transaction hash.
  Stream<String> watchPendingTransactions({
    Duration pollingInterval = _defaultPollingInterval,
  }) {
    final ws = transport;
    return ws is WebSocketTransport
        ? _subscribe(
            ws,
            'newPendingTransactions',
            const [],
          ).map((result) => result as String)
        : _watchPendingTransactionsViaPolling(pollingInterval: pollingInterval);
  }

  Stream<String> _watchPendingTransactionsViaPolling({
    required Duration pollingInterval,
  }) async* {
    final filterId = await createPendingTransactionFilter();
    try {
      while (true) {
        await Future<void>.delayed(pollingInterval);
        for (final hash in await getFilterChanges(filterId)) {
          yield hash as String;
        }
      }
    } finally {
      await uninstallFilter(filterId);
    }
  }

  /// Emits each new log matching the given filter criteria.
  Stream<Log> watchEvent({
    String? address,
    List<Object?>? topics,
    Duration pollingInterval = _defaultPollingInterval,
  }) {
    final ws = transport;
    return ws is WebSocketTransport
        ? _subscribe(ws, 'logs', [
            <String, Object?>{'address': ?address, 'topics': ?topics},
          ]).map((result) => Log.fromJson(result as Map<String, dynamic>))
        : _watchEventViaPolling(
            address: address,
            topics: topics,
            pollingInterval: pollingInterval,
          );
  }

  Stream<Log> _watchEventViaPolling({
    required String? address,
    required List<Object?>? topics,
    required Duration pollingInterval,
  }) async* {
    final filterId = await createEventFilter(address: address, topics: topics);
    try {
      while (true) {
        await Future<void>.delayed(pollingInterval);
        for (final item in await getFilterChanges(filterId)) {
          yield Log.fromJson(item as Map<String, dynamic>);
        }
      }
    } finally {
      await uninstallFilter(filterId);
    }
  }

  /// Subscribes via `eth_subscribe(subscriptionType, ...subscribeArgs)` on
  /// [ws], yielding each push notification's raw `result` payload, and
  /// unsubscribing (`eth_unsubscribe`) when the stream is cancelled.
  ///
  /// [ws.notifications] is a broadcast stream, which drops events when
  /// there's no active listener — so a notification for our subscription
  /// could in principle arrive and be lost between `eth_subscribe`'s
  /// response and this generator resuming to listen for it. To rule that
  /// out regardless of the transport's internal event-dispatch timing, a
  /// private single-subscription buffer attaches to [ws.notifications]
  /// *before* sending `eth_subscribe` at all — single-subscription
  /// `StreamController`s queue events added before anything's listening,
  /// so nothing pushed after that attach point can be missed.
  Stream<Object?> _subscribe(
    WebSocketTransport ws,
    String subscriptionType,
    List<Object?> subscribeArgs,
  ) async* {
    final buffered = StreamController<Map<String, dynamic>>();
    final rawSubscription = ws.notifications.listen(buffered.add);
    try {
      final subscriptionId =
          await rpc.request('eth_subscribe', [
                subscriptionType,
                ...subscribeArgs,
              ])
              as String;
      try {
        await for (final notification in buffered.stream) {
          if (notification['method'] != 'eth_subscription') continue;
          final params = notification['params'] as Map<String, dynamic>;
          if (params['subscription'] != subscriptionId) continue;
          yield params['result'];
        }
      } finally {
        await rpc.request('eth_unsubscribe', [subscriptionId]);
      }
    } finally {
      await rawSubscription.cancel();
      await buffered.close();
    }
  }
}
