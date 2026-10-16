import 'dart:typed_data';

import 'base_error.dart';

/// Thrown when a contract call ([functionName]) returns empty data
/// (`0x`) — typically meaning the function or the contract itself
/// doesn't exist at the target address.
class ContractFunctionZeroDataError extends ViemError {
  /// Creates a [ContractFunctionZeroDataError] for [functionName].
  ContractFunctionZeroDataError({required this.functionName})
    : super(
        'The contract function "$functionName" returned no data ("0x").',
        metaMessages: [
          'This could be due to any of the following:',
          '  - The contract does not have the function "$functionName",',
          '  - The parameters passed to the contract function may be invalid, or',
          '  - The address is not a contract.',
        ],
      );

  final String functionName;
}

/// Thrown when a contract call ([functionName]) reverts, with a decoded
/// [reason] (an `Error(string)` revert string, a `Panic(uint256)` code's
/// description, or a decoded custom error) when available, and the raw
/// revert [data] (selector plus arguments) so the caller can decode a
/// custom error with `decodeErrorResult`.
class ContractFunctionRevertedError extends ViemError {
  /// Creates a [ContractFunctionRevertedError] for [functionName], with
  /// an optional decoded [reason] and raw revert [data].
  ContractFunctionRevertedError({
    required this.functionName,
    this.reason,
    this.data,
  }) : super(
         reason != null
             ? 'The contract function "$functionName" reverted with the '
                   'following reason:\n$reason'
             : 'The contract function "$functionName" reverted.',
       );

  final String functionName;
  final String? reason;

  /// The raw revert data the call returned, if known (empty for a bare
  /// `revert()`).
  final Uint8List? data;
}

/// Wraps any error raised while executing/reading a contract function
/// ([functionName] on [contractAddress]), adding call context to
/// whatever lower-level error ([cause]) triggered it (e.g. an [RpcError],
/// or a [ContractFunctionRevertedError]/[ContractFunctionZeroDataError]).
class ContractFunctionExecutionError extends ViemError {
  /// Creates a [ContractFunctionExecutionError] wrapping [cause] with call
  /// context for [functionName].
  ContractFunctionExecutionError({
    required this.functionName,
    required Object cause,
    this.contractAddress,
    this.args,
  }) : super(
         cause is ViemError
             ? cause.shortMessage
             : 'An unknown error occurred while executing the contract '
                   'function "$functionName".',
         metaMessages: [
           if (cause is ViemError) ...cause.metaMessages,
           'Contract Call:',
           if (contractAddress != null) '  address:  $contractAddress',
           '  function: $functionName',
           if (args != null && args.isNotEmpty) '  args:     $args',
         ],
         cause: cause,
       );

  final String functionName;
  final String? contractAddress;
  final List<Object?>? args;
}
