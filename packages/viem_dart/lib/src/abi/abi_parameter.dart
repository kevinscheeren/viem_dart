import 'package:freezed_annotation/freezed_annotation.dart';

part 'abi_parameter.freezed.dart';
part 'abi_parameter.g.dart';

/// A single ABI parameter (function input/output, event field, error
/// argument, or tuple component) — the Dart mirror of a Solidity ABI JSON
/// parameter object.
///
/// [type] is the raw Solidity type string (`"uint256"`, `"address[]"`,
/// `"tuple"`, `"tuple[3]"`, ...); for tuple types, [components] holds the
/// tuple's own field definitions. [indexed] is only meaningful for event
/// parameters.
@freezed
abstract class AbiParameter with _$AbiParameter {
  /// Creates an ABI parameter with the given [name], [type], and — for
  /// tuple types or event fields — [components]/[indexed].
  const factory AbiParameter({
    required String name,
    required String type,
    List<AbiParameter>? components,
    bool? indexed,
  }) = _AbiParameter;

  /// Parses a single ABI parameter JSON object.
  factory AbiParameter.fromJson(Map<String, dynamic> json) =>
      _$AbiParameterFromJson(json);
}
