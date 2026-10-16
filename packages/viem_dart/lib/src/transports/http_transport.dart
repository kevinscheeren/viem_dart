import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../client/json_rpc.dart';
import 'transport.dart';

/// Configures [HttpTransport] request batching: concurrent calls to
/// [HttpTransport.request] arriving within [wait] of each other (or once
/// [batchSize] accumulates, whichever comes first) are combined into a
/// single JSON-RPC batch — one HTTP POST carrying a JSON array of requests,
/// answered with a JSON array of responses — instead of one POST per call.
/// Matches viem's `http({ batch: { batchSize, wait } })` transport option.
class HttpBatchConfig {
  /// Creates an [HttpBatchConfig]. [wait] defaults to zero, which still
  /// batches every call made synchronously within the same event-loop turn
  /// (e.g. everything inside one `Future.wait([...])`) without adding any
  /// deliberate delay beyond that.
  const HttpBatchConfig({this.batchSize = 1000, this.wait = Duration.zero});

  /// The most requests to combine into a single batch.
  final int batchSize;

  /// How long to wait for more requests to join a batch before sending it.
  final Duration wait;
}

/// A [Transport] over a plain HTTP JSON-RPC endpoint. Uses `package:http`,
/// which already abstracts `dart:io` vs. web/wasm — this is what makes
/// viem_dart's transport layer work identically server-side, in Flutter,
/// and in Jaspr.
class HttpTransport extends Transport {
  /// Creates an [HttpTransport] posting JSON-RPC requests to [url].
  /// Requests are sent individually unless [batch] is given, in which case
  /// they're combined per [HttpBatchConfig].
  HttpTransport(
    this.url, {
    http.Client? client,
    this.batch,
    TransportConfig config = const TransportConfig(
      key: 'http',
      name: 'HTTP JSON-RPC',
    ),
  }) : _client = client ?? http.Client(),
       super(config);

  final Uri url;
  final http.Client _client;

  /// Batching configuration — `null` (the default) sends every request as
  /// its own HTTP POST.
  final HttpBatchConfig? batch;

  final List<_PendingRequest> _pendingBatch = [];
  Timer? _batchTimer;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) {
    final batchConfig = batch;
    return batchConfig == null
        ? _sendSingle(request)
        : _enqueue(request, batchConfig);
  }

  Future<JsonRpcResponse> _sendSingle(JsonRpcRequest request) async {
    final response = await _client
        .post(
          url,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode(request.toJson()),
        )
        .timeout(config.timeout);

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return JsonRpcResponse.fromJson(body);
  }

  Future<JsonRpcResponse> _enqueue(
    JsonRpcRequest request,
    HttpBatchConfig batchConfig,
  ) {
    final completer = Completer<JsonRpcResponse>();
    _pendingBatch.add(_PendingRequest(request, completer));
    if (_pendingBatch.length >= batchConfig.batchSize) {
      _flushBatch();
    } else {
      _batchTimer ??= Timer(batchConfig.wait, _flushBatch);
    }
    return completer.future;
  }

  void _flushBatch() {
    _batchTimer?.cancel();
    _batchTimer = null;
    if (_pendingBatch.isEmpty) return;
    final batch = List<_PendingRequest>.of(_pendingBatch);
    _pendingBatch.clear();
    unawaited(_sendBatch(batch));
  }

  Future<void> _sendBatch(List<_PendingRequest> pending) async {
    try {
      final response = await _client
          .post(
            url,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(pending.map((p) => p.request.toJson()).toList()),
          )
          .timeout(config.timeout);

      final decoded = jsonDecode(response.body) as List<dynamic>;
      final byId = {
        for (final item in decoded)
          (item as Map<String, dynamic>)['id'] as int?: item,
      };
      for (final p in pending) {
        final item = byId[p.request.id];
        if (item == null) {
          p.completer.completeError(
            StateError('No response for request id ${p.request.id} in batch.'),
          );
        } else {
          p.completer.complete(JsonRpcResponse.fromJson(item));
        }
      }
    } catch (error, stackTrace) {
      for (final p in pending) {
        p.completer.completeError(error, stackTrace);
      }
    }
  }
}

class _PendingRequest {
  _PendingRequest(this.request, this.completer);
  final JsonRpcRequest request;
  final Completer<JsonRpcResponse> completer;
}
