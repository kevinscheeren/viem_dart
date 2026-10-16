import 'dart:typed_data';

import 'abi_item.dart';
import 'abi_signature.dart';
import 'decode_parameters.dart';
import 'encode_parameters.dart';

/// Encodes [error] with [args] the same way a contract's revert data is
/// shaped: the error's 4-byte selector followed by its ABI-encoded
/// arguments.
Uint8List encodeErrorResult(AbiError error, [List<Object?> args = const []]) {
  final selector = abiSelector(error.name, error.inputs);
  final encodedArgs = encodeAbiParameters(error.inputs, args);
  return Uint8List.fromList([...selector, ...encodedArgs]);
}

/// Decodes revert [data] for [error] — unlike `decodeFunctionResult`, this
/// expects (and strips) the 4-byte error selector prefix, since revert data
/// always carries it (a contract can revert with any of several distinct
/// custom errors, so the selector is what tells you which one, and thus how
/// to decode the rest).
List<Object?> decodeErrorResult(AbiError error, Uint8List data) {
  final selector = abiSelector(error.name, error.inputs);
  if (data.length < 4 ||
      data[0] != selector[0] ||
      data[1] != selector[1] ||
      data[2] != selector[2] ||
      data[3] != selector[3]) {
    throw const FormatException(
      'Revert data does not match this error\'s selector.',
    );
  }
  return decodeAbiParameters(error.inputs, data.sublist(4));
}
