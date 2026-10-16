import 'dart:convert';

import '../errors/rpc_error.dart';
import '../transports/transport.dart';
import 'json_rpc.dart';

/// Sends JSON-RPC requests over a [Transport], assigning a fresh request id
/// to each call and unwrapping the response into its `result` (or throwing
/// [RpcError] for an `error` response).
///
/// Identical concurrent calls — same [request] `method`/`params`, still in
/// flight at the same time — share one underlying call: the second (and
/// any further) caller gets the same `Future` as the first, instead of
/// firing its own redundant request. Once a call completes (success or
/// error), the next call with the same `method`/`params` starts a fresh
/// one — this only collapses genuine overlap, not repeated polling.
class RpcClient {
  /// Creates an [RpcClient] over [transport].
  RpcClient(this.transport);

  final Transport transport;

  int _nextId = 1;
  final Map<String, Future<Object?>> _inFlight = {};

  /// Sends `{method, params}` and returns the raw `result` value.
  Future<Object?> request(String method, [List<Object?> params = const []]) {
    final key = '$method:${jsonEncode(params)}';
    final existing = _inFlight[key];
    if (existing != null) return existing;

    final future = _send(method, params).whenComplete(() {
      _inFlight.remove(key);
    });
    _inFlight[key] = future;
    return future;
  }

  Future<Object?> _send(String method, List<Object?> params) async {
    final id = _nextId++;
    final response = await transport.request(
      JsonRpcRequest(id: id, method: method, params: params),
    );

    final error = response.error;
    if (error != null) {
      throw RpcError.fromResponse(
        code: error.code,
        rpcMessage: error.message,
        data: error.data,
      );
    }
    return response.result;
  }
}
