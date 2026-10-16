import '../client/json_rpc.dart';
import 'transport.dart';

/// A [Transport] that tries each of [transports] in order, falling through
/// to the next on failure. Useful for combining multiple RPC providers.
class FallbackTransport extends Transport {
  /// Creates a [FallbackTransport] trying each of [transports] in order.
  FallbackTransport(
    this.transports, {
    TransportConfig config = const TransportConfig(
      key: 'fallback',
      name: 'Fallback Transport',
    ),
  }) : assert(
         transports.isNotEmpty,
         'FallbackTransport requires at least one transport',
       ),
       super(config);

  final List<Transport> transports;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    Object? lastError;
    for (final transport in transports) {
      try {
        return await transport.request(request);
      } catch (error) {
        lastError = error;
      }
    }
    throw StateError(
      'All transports failed for method `${request.method}`. Last error: $lastError',
    );
  }
}
