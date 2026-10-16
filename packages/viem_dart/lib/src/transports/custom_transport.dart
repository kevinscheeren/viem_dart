import '../client/json_rpc.dart';
import 'transport.dart';

/// A user-supplied JSON-RPC request handler, used by [CustomTransport].
typedef CustomTransportHandler =
    Future<JsonRpcResponse> Function(JsonRpcRequest request);

/// A [Transport] backed by a user-supplied [CustomTransportHandler] — an
/// escape hatch for RPC mechanisms this package doesn't provide a built-in
/// transport for (e.g. an injected wallet's provider, or a test double).
class CustomTransport extends Transport {
  /// Creates a [CustomTransport] backed by [_handler].
  CustomTransport(
    this._handler, {
    TransportConfig config = const TransportConfig(
      key: 'custom',
      name: 'Custom Transport',
    ),
  }) : super(config);

  final CustomTransportHandler _handler;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) => _handler(request);
}
