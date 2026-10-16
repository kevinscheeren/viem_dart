import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../client/json_rpc.dart';
import 'transport.dart';

/// A [Transport] over a persistent WebSocket JSON-RPC connection. Built on
/// `package:web_socket_channel`, which (as of its 3.x/`package:web` adapter)
/// works identically server-side and compiled to JS/Wasm.
///
/// Correlates responses to requests by JSON-RPC `id`. Messages without a
/// matching `id` (`eth_subscribe` notifications) are ignored here — routing
/// those to subscribers is a `watch*` action concern, layered on top of
/// [notifications].
class WebSocketTransport extends Transport {
  /// Creates a [WebSocketTransport] connected to [url].
  WebSocketTransport(
    Uri url, {
    TransportConfig config = const TransportConfig(
      key: 'webSocket',
      name: 'WebSocket JSON-RPC',
    ),
  }) : this._(WebSocketChannel.connect(url), config);

  WebSocketTransport._(this._channel, super.config) {
    _subscription = _channel.stream.listen(
      _handleMessage,
      onError: _handleError,
    );
  }

  final WebSocketChannel _channel;
  late final StreamSubscription<Object?> _subscription;
  final Map<int, Completer<JsonRpcResponse>> _pending = {};
  final StreamController<Map<String, dynamic>> _notifications =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Raw `eth_subscribe`-style messages (no matching request `id`) — decoded
  /// JSON objects, e.g. `{"method":"eth_subscription","params":{...}}`.
  Stream<Map<String, dynamic>> get notifications => _notifications.stream;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) {
    final completer = Completer<JsonRpcResponse>();
    _pending[request.id] = completer;
    _channel.sink.add(jsonEncode(request.toJson()));
    return completer.future.timeout(
      config.timeout,
      onTimeout: () {
        _pending.remove(request.id);
        throw TimeoutException('WebSocket request timed out', config.timeout);
      },
    );
  }

  void _handleMessage(Object? message) {
    final json = jsonDecode(message as String) as Map<String, dynamic>;
    final id = json['id'] as int?;
    if (id == null) {
      _notifications.add(json);
      return;
    }
    _pending.remove(id)?.complete(JsonRpcResponse.fromJson(json));
  }

  void _handleError(Object error) {
    for (final completer in _pending.values) {
      if (!completer.isCompleted) completer.completeError(error);
    }
    _pending.clear();
  }

  /// Closes the underlying WebSocket connection.
  Future<void> close() async {
    await _subscription.cancel();
    await _notifications.close();
    await _channel.sink.close();
  }
}
