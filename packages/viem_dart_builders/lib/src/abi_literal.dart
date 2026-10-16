import 'package:code_builder/code_builder.dart';
import 'package:viem_dart/abi.dart';

/// Embeds [param] as a `const AbiParameter(...)` [Expression], recursively
/// (tuple `components` embed as a `const` list of the same). Used by the
/// read/write/event method generators to give each generated method a
/// ready-to-use [AbiFunction]/[AbiEvent] literal to pass straight into
/// `readContract`/`writeContract`/`getContractEvents`/`watchContractEvent`
/// — the exact same objects `AbiItem.fromJson` would produce from the
/// source ABI JSON, just embedded directly as Dart source instead of
/// re-parsed from JSON at runtime.
Expression abiParameterLiteral(AbiParameter param) =>
    refer('AbiParameter').constInstance([], {
      'name': literalString(param.name),
      'type': literalString(param.type),
      if (param.components != null)
        'components': literalConstList(
          param.components!.map(abiParameterLiteral).toList(),
        ),
      if (param.indexed != null) 'indexed': literalBool(param.indexed!),
    });

/// Embeds [fn] as a `const AbiFunction(...)` [Expression] — see
/// [abiParameterLiteral].
Expression abiFunctionLiteral(AbiFunction fn) =>
    refer('AbiFunction').constInstance([], {
      'name': literalString(fn.name),
      'inputs': literalConstList(fn.inputs.map(abiParameterLiteral).toList()),
      'outputs': literalConstList(fn.outputs.map(abiParameterLiteral).toList()),
      'stateMutability': literalString(fn.stateMutability),
    });

/// Embeds [event] as a `const AbiEvent(...)` [Expression] — see
/// [abiParameterLiteral].
Expression abiEventLiteral(AbiEvent event) =>
    refer('AbiEvent').constInstance([], {
      'name': literalString(event.name),
      'inputs': literalConstList(
        event.inputs.map(abiParameterLiteral).toList(),
      ),
      'anonymous': literalBool(event.anonymous),
    });
