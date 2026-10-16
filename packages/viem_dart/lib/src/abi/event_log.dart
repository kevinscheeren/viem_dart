import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';
import '../utils/hex.dart';
import 'abi_item.dart';
import 'abi_parameter.dart';
import 'abi_signature.dart';
import 'abi_type.dart';
import 'decode_parameters.dart';
import 'encode_parameters.dart';

/// Whether [param] is a Solidity "value type" for event-topic encoding
/// purposes (fits directly in a 32-byte topic): `uintN`/`intN`/`address`/
/// `bool`/`bytesN`. Everything else — `string`, `bytes`, any array, and
/// tuples — is stored as `keccak256` of its encoding instead, per
/// Solidity's event-topic rules (a different split than
/// [isDynamicAbiType]'s ABI head/tail classification: a `uint256[3]` is
/// ABI-static but still gets hashed as a topic, since it isn't a scalar).
bool isEventTopicValueType(AbiParameter param) {
  final type = param.type;
  if (type == 'string' || type == 'bytes' || type == 'tuple') return false;
  if (parseArrayType(type) != null) return false;
  return true;
}

/// Encodes [event]'s topics array for [args] (keyed by parameter name;
/// omitted indexed parameters become `null`, meaning "match any value" —
/// the standard `eth_getLogs`/`eth_newFilter` topic-filter convention).
///
/// `topics[0]` is the event's signature hash (unless [AbiEvent.anonymous]),
/// followed by one topic per indexed parameter in declaration order. Value
/// types encode directly; everything else (dynamic types, arrays, tuples)
/// encodes as `keccak256` of its standard ABI encoding.
List<String?> encodeEventTopics(
  AbiEvent event, [
  Map<String, Object?> args = const {},
]) {
  final topics = <String?>[];
  if (!event.anonymous) {
    topics.add(_eventSignatureHash(event));
  }
  for (final param in event.inputs.where((p) => p.indexed == true)) {
    if (!args.containsKey(param.name)) {
      topics.add(null);
      continue;
    }
    topics.add(_encodeTopicValue(param, args[param.name]));
  }
  return topics;
}

/// Decodes a log's [topics] and [data] against [event] into a name-keyed
/// map of argument values.
///
/// Indexed value-type parameters decode directly from their topic;
/// indexed dynamic-type parameters (`string`/`bytes`/arrays/tuples) can
/// only recover the `keccak256` hash stored in their topic — the original
/// value isn't retrievable from the log alone — so their entry is that
/// hash as a hex string, not the original value. Non-indexed parameters
/// decode from [data] the same way `decodeAbiParameters` decodes any
/// parameter list.
Map<String, Object?> decodeEventLog(
  AbiEvent event, {
  required List<String> topics,
  required Uint8List data,
}) {
  final topicOffset = event.anonymous ? 0 : 1;
  if (!event.anonymous &&
      topics.isNotEmpty &&
      topics[0] != _eventSignatureHash(event)) {
    throw const FormatException(
      "topics[0] doesn't match this event's signature hash.",
    );
  }

  final result = <String, Object?>{};
  var indexedSeen = 0;
  for (final param in event.inputs) {
    if (param.indexed == true) {
      final topicIndex = topicOffset + indexedSeen;
      indexedSeen++;
      if (topicIndex >= topics.length) continue;
      final topicHex = topics[topicIndex];
      result[param.name] = isEventTopicValueType(param)
          ? decodeAbiParameters([param], hexToBytes(topicHex)).single
          : topicHex;
    }
  }

  final nonIndexedParams = event.inputs
      .where((p) => p.indexed != true)
      .toList();
  if (nonIndexedParams.isNotEmpty) {
    final decoded = decodeAbiParameters(nonIndexedParams, data);
    for (var i = 0; i < nonIndexedParams.length; i++) {
      result[nonIndexedParams[i].name] = decoded[i];
    }
  }

  return result;
}

String _eventSignatureHash(AbiEvent event) => bytesToHex(
  keccak256(
    Uint8List.fromList(utf8.encode(abiSignature(event.name, event.inputs))),
  ),
);

String _encodeTopicValue(AbiParameter param, Object? value) {
  if (isEventTopicValueType(param)) {
    return bytesToHex(encodeAbiParameters([param], [value]));
  }
  if (param.type == 'string') {
    return bytesToHex(
      keccak256(Uint8List.fromList(utf8.encode(value as String))),
    );
  }
  if (param.type == 'bytes') {
    return bytesToHex(keccak256(value as Uint8List));
  }
  return bytesToHex(keccak256(encodeAbiParameters([param], [value])));
}
