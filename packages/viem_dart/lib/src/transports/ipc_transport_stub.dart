import '../client/json_rpc.dart';
import 'transport.dart';

/// Web/wasm placeholder for `IpcTransport` — Unix domain sockets require
/// `dart:io`, which isn't available in the browser. Conditionally exported
/// in place of `ipc_transport_io.dart` by `ipc_transport.dart` so a
/// web-reachable import path never pulls in `dart:io`.
class IpcTransport extends Transport {
  /// Always throws [UnsupportedError] — IPC needs `dart:io`.
  IpcTransport(String path, {TransportConfig config = const TransportConfig()})
    : super(config) {
    throw UnsupportedError(
      'IpcTransport requires dart:io and is not available on this platform.',
    );
  }

  /// Always throws [UnsupportedError] — unreachable since the constructor
  /// always throws first.
  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) =>
      throw UnsupportedError(
        'IpcTransport requires dart:io and is not available on this platform.',
      );

  /// Present for API parity with `ipc_transport_io.dart`'s [IpcTransport];
  /// unreachable since the constructor always throws first.
  Future<void> close() async {}
}
