import 'package:freezed_annotation/freezed_annotation.dart';

import 'abi_parameter.dart';

part 'abi_item.freezed.dart';

/// A single entry of a contract's ABI — the Dart mirror of a Solidity ABI
/// JSON item (`{"type": "function", ...}`, `{"type": "event", ...}`, ...).
///
/// `fromJson`/`toJson` are hand-written (not `json_serializable`-generated)
/// since they dispatch on the JSON's own `"type"` discriminator, which
/// already matches real-world ABI JSON shape directly — simpler and more
/// robust than fitting freezed's generic union-JSON machinery to a schema
/// this package doesn't control.
@freezed
sealed class AbiItem with _$AbiItem {
  /// A callable contract function.
  const factory AbiItem.function({
    required String name,
    required List<AbiParameter> inputs,
    required List<AbiParameter> outputs,
    @Default('nonpayable') String stateMutability,
  }) = AbiFunction;

  /// An event the contract may emit.
  const factory AbiItem.event({
    required String name,
    required List<AbiParameter> inputs,
    @Default(false) bool anonymous,
  }) = AbiEvent;

  /// A custom Solidity error (`error Foo(...)`), used to decode revert data.
  const factory AbiItem.error({
    required String name,
    required List<AbiParameter> inputs,
  }) = AbiError;

  /// The contract's constructor.
  const factory AbiItem.constructor({
    required List<AbiParameter> inputs,
    @Default('nonpayable') String stateMutability,
  }) = AbiConstructor;

  /// The contract's fallback function.
  const factory AbiItem.fallback({
    @Default('nonpayable') String stateMutability,
  }) = AbiFallback;

  /// The contract's `receive` function (plain-Ether-transfer handler).
  const factory AbiItem.receive() = AbiReceive;

  /// Parses a single ABI JSON item, dispatching on its `"type"` field.
  factory AbiItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final inputs = _parameters(json['inputs']);
    return switch (type) {
      'function' => AbiItem.function(
        name: json['name'] as String,
        inputs: inputs,
        outputs: _parameters(json['outputs']),
        stateMutability: json['stateMutability'] as String? ?? 'nonpayable',
      ),
      'event' => AbiItem.event(
        name: json['name'] as String,
        inputs: inputs,
        anonymous: json['anonymous'] as bool? ?? false,
      ),
      'error' => AbiItem.error(name: json['name'] as String, inputs: inputs),
      'constructor' => AbiItem.constructor(
        inputs: inputs,
        stateMutability: json['stateMutability'] as String? ?? 'nonpayable',
      ),
      'fallback' => AbiItem.fallback(
        stateMutability: json['stateMutability'] as String? ?? 'nonpayable',
      ),
      'receive' => const AbiItem.receive(),
      _ => throw FormatException('Unknown ABI item type `$type`.'),
    };
  }
}

List<AbiParameter> _parameters(Object? json) =>
    (json as List<dynamic>? ?? const [])
        .map((e) => AbiParameter.fromJson(e as Map<String, dynamic>))
        .toList();

/// Renders [item] back to Solidity ABI JSON shape.
Map<String, dynamic> abiItemToJson(AbiItem item) => switch (item) {
  AbiFunction(
    :final name,
    :final inputs,
    :final outputs,
    :final stateMutability,
  ) =>
    {
      'type': 'function',
      'name': name,
      'inputs': inputs.map((p) => p.toJson()).toList(),
      'outputs': outputs.map((p) => p.toJson()).toList(),
      'stateMutability': stateMutability,
    },
  AbiEvent(:final name, :final inputs, :final anonymous) => {
    'type': 'event',
    'name': name,
    'inputs': inputs.map((p) => p.toJson()).toList(),
    'anonymous': anonymous,
  },
  AbiError(:final name, :final inputs) => {
    'type': 'error',
    'name': name,
    'inputs': inputs.map((p) => p.toJson()).toList(),
  },
  AbiConstructor(:final inputs, :final stateMutability) => {
    'type': 'constructor',
    'inputs': inputs.map((p) => p.toJson()).toList(),
    'stateMutability': stateMutability,
  },
  AbiFallback(:final stateMutability) => {
    'type': 'fallback',
    'stateMutability': stateMutability,
  },
  AbiReceive() => {'type': 'receive'},
};
