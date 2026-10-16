import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_rpc.freezed.dart';
part 'json_rpc.g.dart';

/// A JSON-RPC 2.0 request.
@freezed
abstract class JsonRpcRequest with _$JsonRpcRequest {
  /// Creates a [JsonRpcRequest] for [method] with [params].
  const factory JsonRpcRequest({
    @Default('2.0') String jsonrpc,
    required int id,
    required String method,
    @Default([]) List<Object?> params,
  }) = _JsonRpcRequest;

  /// Parses a JSON-RPC request object.
  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);
}

/// The `error` payload of a JSON-RPC 2.0 response.
@freezed
abstract class JsonRpcErrorPayload with _$JsonRpcErrorPayload {
  /// Creates a [JsonRpcErrorPayload] with the given [code] and [message].
  const factory JsonRpcErrorPayload({
    required int code,
    required String message,
    Object? data,
  }) = _JsonRpcErrorPayload;

  /// Parses a JSON-RPC error payload.
  factory JsonRpcErrorPayload.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorPayloadFromJson(json);
}

/// A JSON-RPC 2.0 response: either [result] or [error] is set, never both.
@freezed
abstract class JsonRpcResponse with _$JsonRpcResponse {
  /// Creates a [JsonRpcResponse] with either [result] or [error] set.
  const factory JsonRpcResponse({
    @Default('2.0') String jsonrpc,
    required int? id,
    Object? result,
    JsonRpcErrorPayload? error,
  }) = _JsonRpcResponse;

  /// Parses a JSON-RPC response object.
  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json);
}
