import 'dart:typed_data';

import 'abi_item.dart';
import 'abi_signature.dart';
import 'decode_parameters.dart';
import 'encode_parameters.dart';

/// Encodes a call to [function] with [args]: the 4-byte function selector
/// followed by the ABI-encoded arguments — ready to send as a
/// transaction's/`eth_call`'s `data`.
Uint8List encodeFunctionData(
  AbiFunction function, [
  List<Object?> args = const [],
]) {
  final selector = abiSelector(function.name, function.inputs);
  final encodedArgs = encodeAbiParameters(function.inputs, args);
  return Uint8List.fromList([...selector, ...encodedArgs]);
}

/// Decodes [data] — the raw return data of a successful call to [function]
/// (no selector prefix; `eth_call` doesn't include one) — into one Dart
/// value per output parameter.
List<Object?> decodeFunctionResult(AbiFunction function, Uint8List data) =>
    decodeAbiParameters(function.outputs, data);
