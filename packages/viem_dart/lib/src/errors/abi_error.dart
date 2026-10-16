import '../abi/abi_parameter.dart';
import 'base_error.dart';

/// Thrown decoding ABI-encoded return data that's empty (`0x`) — see
/// [AbiDecodingDataSizeTooSmallError] for data that's merely too short.
class AbiDecodingZeroDataError extends ViemError {
  /// Creates an [AbiDecodingZeroDataError].
  const AbiDecodingZeroDataError()
    : super('Cannot decode zero data ("0x") with ABI parameters.');
}

/// Thrown when decoded hex data is shorter than [params] require.
class AbiDecodingDataSizeTooSmallError extends ViemError {
  /// Creates an [AbiDecodingDataSizeTooSmallError] for [data] of [size]
  /// bytes, too small for [params].
  AbiDecodingDataSizeTooSmallError({
    required this.size,
    required this.params,
    required this.data,
  }) : super(
         'Data size of $size bytes is too small for given parameters.',
         metaMessages: [
           'Params: (${params.map((p) => '${p.type} ${p.name}').join(', ')})',
           'Data:   $data ($size bytes)',
         ],
       );

  final int size;
  final List<AbiParameter> params;
  final String data;
}

/// Thrown when the number of ABI parameters doesn't match the number of
/// values being encoded against them.
class AbiEncodingLengthMismatchError extends ViemError {
  /// Creates an [AbiEncodingLengthMismatchError] reporting [expectedLength]
  /// vs. [givenLength].
  AbiEncodingLengthMismatchError({
    required this.expectedLength,
    required this.givenLength,
  }) : super(
         'ABI encoding params/values length mismatch.',
         metaMessages: [
           'Expected length (params): $expectedLength',
           'Given length (values): $givenLength',
         ],
       );

  final int expectedLength;
  final int givenLength;
}

/// Thrown looking up a function by [functionName] on an ABI that doesn't
/// declare it.
class AbiFunctionNotFoundError extends ViemError {
  /// Creates an [AbiFunctionNotFoundError] for [functionName], or a
  /// generic message if it isn't known.
  AbiFunctionNotFoundError({this.functionName})
    : super(
        functionName != null
            ? 'Function "$functionName" not found on ABI.'
            : 'Function not found on ABI.',
        metaMessages: [
          'Make sure you are using the correct ABI and that the function exists on it.',
        ],
      );

  final String? functionName;
}

/// Thrown when an encoded 4-byte function [signature] matches no function
/// declared on the ABI.
class AbiFunctionSignatureNotFoundError extends ViemError {
  /// Creates an [AbiFunctionSignatureNotFoundError] for the encoded
  /// [signature].
  AbiFunctionSignatureNotFoundError({required this.signature})
    : super(
        'Encoded function signature "$signature" not found on ABI.',
        metaMessages: [
          'Make sure you are using the correct ABI and that the function exists on it.',
          'You can look up the signature here: https://4byte.sourcify.dev/?q=$signature.',
        ],
      );

  final String signature;
}
