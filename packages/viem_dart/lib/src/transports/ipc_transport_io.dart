import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../client/json_rpc.dart';
import 'ipc_message_framer.dart';
import 'transport.dart';

/// A [Transport] over a Unix domain socket IPC endpoint (e.g. geth/anvil's
/// `--ipcpath`). `dart:io`-only — see `ipc_transport_stub.dart` for the
/// web/wasm placeholder this file is conditionally exported in place of.
class IpcTransport extends Transport {
  /// Creates an [IpcTransport] connecting to the Unix domain socket at
  /// [path].
  IpcTransport(
    this.path, {
    TransportConfig config = const TransportConfig(
      key: 'ipc',
      name: 'IPC JSON-RPC',
    ),
  }) : super(config);

  final String path;

  Socket? _socket;
  StreamSubscription<List<int>>? _subscription;
  final IpcMessageFramer _framer = IpcMessageFramer();
  final Map<int, Completer<JsonRpcResponse>> _pending = {};

  Future<Socket> _ensureConnected() async {
    final existing = _socket;
    if (existing != null) return existing;
    final socket = await Socket.connect(
      InternetAddress(path, type: InternetAddressType.unix),
      0,
    );
    _subscription = socket.listen(_handleData, onError: _handleError);
    return _socket = socket;
  }

  /// Sends [request] over the IPC socket, connecting first if needed.
  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    final socket = await _ensureConnected();
    final completer = Completer<JsonRpcResponse>();
    _pending[request.id] = completer;
    socket.write(jsonEncode(request.toJson()));
    return completer.future.timeout(
      config.timeout,
      onTimeout: () {
        _pending.remove(request.id);
        throw TimeoutException('IPC request timed out', config.timeout);
      },
    );
  }

  void _handleData(List<int> data) {
    for (final message in _framer.feed(utf8.decode(data))) {
      final json = jsonDecode(message) as Map<String, dynamic>;
      final id = json['id'] as int?;
      if (id == null) continue;
      _pending.remove(id)?.complete(JsonRpcResponse.fromJson(json));
    }
  }

  void _handleError(Object error) {
    for (final completer in _pending.values) {
      if (!completer.isCompleted) completer.completeError(error);
    }
    _pending.clear();
  }

  /// Closes the underlying socket connection, if one was opened.
  Future<void> close() async {
    await _subscription?.cancel();
    await _socket?.close();
  }
}
