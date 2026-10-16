import 'dart:convert';
import 'dart:typed_data';

import '../crypto/keccak.dart';
import 'abi_parameter.dart';

/// The canonical Solidity type string for [param] — identical to
/// `param.type` except for tuples, which expand to their component types
/// in parens (e.g. `tuple` with `(address,uint256)` components becomes
/// `"(address,uint256)"`, `tuple[]` becomes `"(address,uint256)[]"`),
/// recursively for nested tuples. This is what function/error/event
/// selectors are actually keccak-hashed over — never the literal word
/// `"tuple"`.
String abiCanonicalType(AbiParameter param) {
  if (param.type == 'tuple' || param.type.startsWith('tuple[')) {
    final components = param.components ?? const <AbiParameter>[];
    final inner = components.map(abiCanonicalType).join(',');
    final arraySuffix = param.type.substring('tuple'.length);
    return '($inner)$arraySuffix';
  }
  return param.type;
}

/// The canonical signature `name(type1,type2,...)` for a function, error,
/// or event named [name] with [inputs] — the string selectors are hashed
/// over.
String abiSignature(String name, List<AbiParameter> inputs) =>
    '$name(${inputs.map(abiCanonicalType).join(',')})';

/// The 4-byte selector for a function/error named [name] with [inputs]:
/// the first 4 bytes of `keccak256(abiSignature(name, inputs))`.
Uint8List abiSelector(String name, List<AbiParameter> inputs) => keccak256(
  Uint8List.fromList(utf8.encode(abiSignature(name, inputs))),
).sublist(0, 4);
