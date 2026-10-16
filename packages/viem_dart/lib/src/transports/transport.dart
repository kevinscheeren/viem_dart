import '../client/json_rpc.dart';

/// Metadata describing a [Transport] (used for logging/debugging and to
/// tune retry/timeout behavior).
class TransportConfig {
  /// Creates a [TransportConfig].
  const TransportConfig({
    this.key = 'custom',
    this.name = 'Custom Transport',
    this.retryCount = 3,
    this.retryDelay = const Duration(milliseconds: 150),
    this.timeout = const Duration(seconds: 10),
  });

  final String key;
  final String name;
  final int retryCount;
  final Duration retryDelay;
  final Duration timeout;
}

/// A JSON-RPC transport: something that can send a [JsonRpcRequest] to a
/// node and return its [JsonRpcResponse]. Implementations: `HttpTransport`,
/// `WebSocketTransport`, `FallbackTransport`, `CustomTransport`,
/// `IpcTransport`.
abstract class Transport {
  /// Creates a [Transport] with the given [config].
  const Transport(this.config);

  final TransportConfig config;

  /// Sends [request] and returns its response.
  Future<JsonRpcResponse> request(JsonRpcRequest request);
}
