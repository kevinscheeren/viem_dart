import 'base_error.dart';

/// Thrown when a JSON-RPC node returns an `error` response.
///
/// [fromResponse] returns one of the specific EIP-1474 subclasses below
/// when [code] matches a standard one it recognizes, falling back to a
/// plain [RpcError] otherwise — so callers can catch, say,
/// [MethodNotFoundRpcError] specifically, or [RpcError] generally.
class RpcError extends ViemError {
  /// Creates an [RpcError] with the given [code] and [rpcMessage].
  RpcError({required this.code, required String rpcMessage, this.data})
    : super('RPC Error: $rpcMessage', metaMessages: ['Code: $code']);

  /// Builds the most specific known [RpcError] subclass for [code], or a
  /// plain [RpcError] if [code] isn't one of the standard EIP-1474/EIP-1193
  /// codes below.
  factory RpcError.fromResponse({
    required int code,
    required String rpcMessage,
    Object? data,
  }) {
    switch (code) {
      case UserRejectedRequestError.errorCode:
        return UserRejectedRequestError(data: data);
      case MethodNotFoundRpcError.errorCode:
        return MethodNotFoundRpcError(data: data);
      case InvalidParamsRpcError.errorCode:
        return InvalidParamsRpcError(data: data);
      case InternalRpcError.errorCode:
        return InternalRpcError(data: data);
      default:
        return RpcError(code: code, rpcMessage: rpcMessage, data: data);
    }
  }

  /// The JSON-RPC error code (see
  /// https://eips.ethereum.org/EIPS/eip-1474#error-codes for the standard
  /// Ethereum JSON-RPC codes).
  final int code;

  /// Additional structured data the node attached to the error, if any.
  final Object? data;
}

/// The user declined a wallet request/prompt (EIP-1193, code `4001`).
class UserRejectedRequestError extends RpcError {
  /// Creates a [UserRejectedRequestError].
  UserRejectedRequestError({super.data})
    : super(code: errorCode, rpcMessage: 'User rejected the request.');

  /// The EIP-1193 error code for a user-rejected request (`4001`).
  static const int errorCode = 4001;
}

/// The RPC method doesn't exist or isn't available on the node (code
/// `-32601`).
class MethodNotFoundRpcError extends RpcError {
  /// Creates a [MethodNotFoundRpcError].
  MethodNotFoundRpcError({super.data})
    : super(
        code: errorCode,
        rpcMessage: 'The method does not exist / is not available.',
      );

  /// The standard JSON-RPC error code for a missing method (`-32601`).
  static const int errorCode = -32601;
}

/// Parameters provided to the RPC method failed validation (code
/// `-32602`).
class InvalidParamsRpcError extends RpcError {
  /// Creates an [InvalidParamsRpcError].
  InvalidParamsRpcError({super.data})
    : super(
        code: errorCode,
        rpcMessage:
            'Invalid parameters were provided to the RPC method. '
            'Double check you have provided the correct parameters.',
      );

  /// The standard JSON-RPC error code for invalid parameters (`-32602`).
  static const int errorCode = -32602;
}

/// A generic internal, server-side error on the node (code `-32603`).
class InternalRpcError extends RpcError {
  /// Creates an [InternalRpcError].
  InternalRpcError({super.data})
    : super(code: errorCode, rpcMessage: 'An internal error was received.');

  /// The standard JSON-RPC error code for an internal server error
  /// (`-32603`).
  static const int errorCode = -32603;
}
