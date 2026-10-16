import '../abi_item.dart';
import '../abi_parameter.dart';

const Set<String> _stateMutabilityWords = {
  'pure',
  'view',
  'payable',
  'nonpayable',
};
const Set<String> _storageLocationWords = {'calldata', 'memory', 'storage'};

/// Parses a list of Solidity-like human-readable signatures (viem's
/// `parseAbi` equivalent) into [AbiItem]s — the ergonomic alternative to
/// writing out full ABI JSON by hand:
///
/// ```dart
/// final abi = parseAbi([
///   'function transfer(address to, uint256 amount) returns (bool)',
///   'event Transfer(address indexed from, address indexed to, uint256 value)',
/// ]);
/// ```
///
/// Supports inline tuple types (`"(uint256 a, bool b)"`, including nested
/// and array-of-tuple forms) for struct-shaped parameters. Does **not**
/// support named `struct Foo { ... }` declarations referenced by name
/// across multiple signature strings — use inline tuple syntax instead;
/// [parseAbiItem] throws a clear error if it encounters a `struct` line
/// rather than silently mishandling it.
List<AbiItem> parseAbi(List<String> signatures) => signatures
    .map((s) => s.trim())
    .where((s) => s.isNotEmpty)
    .map(parseAbiItem)
    .toList();

/// Parses a single human-readable ABI signature into an [AbiItem]. See
/// [parseAbi] for the supported grammar and its known limitation (no named
/// struct resolution).
AbiItem parseAbiItem(String signature) {
  final trimmed = signature.trim().replaceAll(RegExp(r'\s+'), ' ');

  if (trimmed.startsWith('function ')) {
    return _parseFunction(trimmed.substring('function '.length));
  }
  if (trimmed.startsWith('event ')) {
    return _parseEvent(trimmed.substring('event '.length));
  }
  if (trimmed.startsWith('error ')) {
    return _parseError(trimmed.substring('error '.length));
  }
  if (trimmed.startsWith('constructor')) {
    return _parseConstructor(trimmed.substring('constructor'.length));
  }
  if (trimmed.startsWith('fallback')) {
    return _parseFallback(trimmed.substring('fallback'.length));
  }
  if (trimmed.startsWith('receive')) {
    return const AbiItem.receive();
  }
  if (trimmed.startsWith('struct ')) {
    throw FormatException(
      'Named struct declarations (`$trimmed`) are not supported by parseAbi — '
      'use inline tuple syntax instead, e.g. "(uint256 a, bool b)".',
    );
  }
  throw FormatException('Unrecognized ABI signature: `$signature`.');
}

/// Parses a single parameter declaration (as it would appear inside a
/// signature's parens) into an [AbiParameter] — e.g.
/// `"address indexed from"` or `"(uint256 a, bool b)[] items"`.
AbiParameter parseAbiParameter(String input) => _parseParameter(input);

AbiItem _parseFunction(String s) {
  final parsed = _parseNameAndParams(s);
  final inputs = _parseParamList(parsed.paramsRaw);

  final returnsIndex = parsed.afterParams.indexOf('returns');
  final modifiersPart = returnsIndex == -1
      ? parsed.afterParams
      : parsed.afterParams.substring(0, returnsIndex);
  final stateMutability = _extractStateMutability(modifiersPart);

  var outputs = const <AbiParameter>[];
  if (returnsIndex != -1) {
    final afterReturns = parsed.afterParams
        .substring(returnsIndex + 'returns'.length)
        .trim();
    outputs = _parseParamList(_extractParenContent(afterReturns));
  }

  return AbiItem.function(
    name: parsed.name,
    inputs: inputs,
    outputs: outputs,
    stateMutability: stateMutability,
  );
}

AbiItem _parseEvent(String s) {
  final parsed = _parseNameAndParams(s);
  final anonymous = parsed.afterParams.split(' ').contains('anonymous');
  return AbiItem.event(
    name: parsed.name,
    inputs: _parseParamList(parsed.paramsRaw),
    anonymous: anonymous,
  );
}

AbiItem _parseError(String s) {
  final parsed = _parseNameAndParams(s);
  return AbiItem.error(
    name: parsed.name,
    inputs: _parseParamList(parsed.paramsRaw),
  );
}

AbiItem _parseConstructor(String rest) {
  final trimmed = rest.trim();
  final paramsRaw = _extractParenContent(trimmed);
  final afterParams = trimmed
      .substring(_matchingParen(trimmed, trimmed.indexOf('(')) + 1)
      .trim();
  return AbiItem.constructor(
    inputs: _parseParamList(paramsRaw),
    stateMutability: _extractStateMutability(
      afterParams,
      defaultValue: 'nonpayable',
    ),
  );
}

AbiItem _parseFallback(String rest) {
  final stateMutability = rest.split(' ').contains('payable')
      ? 'payable'
      : 'nonpayable';
  return AbiItem.fallback(stateMutability: stateMutability);
}

String _extractStateMutability(
  String words, {
  String defaultValue = 'nonpayable',
}) {
  for (final word in words.split(' ')) {
    if (_stateMutabilityWords.contains(word)) return word;
  }
  return defaultValue;
}

class _NameAndParams {
  const _NameAndParams(this.name, this.paramsRaw, this.afterParams);
  final String name;
  final String paramsRaw;
  final String afterParams;
}

_NameAndParams _parseNameAndParams(String s) {
  final openIndex = s.indexOf('(');
  if (openIndex == -1) {
    throw FormatException('Expected `(` in `$s`.');
  }
  final name = s.substring(0, openIndex).trim();
  final closeIndex = _matchingParen(s, openIndex);
  return _NameAndParams(
    name,
    s.substring(openIndex + 1, closeIndex),
    s.substring(closeIndex + 1).trim(),
  );
}

String _extractParenContent(String s) {
  final trimmed = s.trim();
  if (!trimmed.startsWith('(')) {
    throw FormatException('Expected `(` in `$s`.');
  }
  return trimmed.substring(1, _matchingParen(trimmed, 0));
}

int _matchingParen(String s, int openIndex) {
  var depth = 0;
  for (var i = openIndex; i < s.length; i++) {
    if (s[i] == '(') depth++;
    if (s[i] == ')') {
      depth--;
      if (depth == 0) return i;
    }
  }
  throw FormatException('Unmatched `(` in `$s`.');
}

/// Splits [s] on top-level occurrences of [delimiter] — occurrences inside
/// `()`/`[]` nesting don't count, so a tuple type's internal commas don't
/// split its own enclosing parameter list.
List<String> _splitTopLevel(String s, String delimiter) {
  final parts = <String>[];
  var depth = 0;
  var start = 0;
  for (var i = 0; i < s.length; i++) {
    final char = s[i];
    if (char == '(' || char == '[') depth++;
    if (char == ')' || char == ']') depth--;
    if (char == delimiter && depth == 0) {
      parts.add(s.substring(start, i));
      start = i + 1;
    }
  }
  parts.add(s.substring(start));
  return parts;
}

List<AbiParameter> _parseParamList(String raw) => _splitTopLevel(
  raw,
  ',',
).map((s) => s.trim()).where((s) => s.isNotEmpty).map(_parseParameter).toList();

AbiParameter _parseParameter(String raw) {
  final input = raw.trim();
  if (input.isEmpty) {
    throw const FormatException('Empty parameter in ABI signature.');
  }

  final List<AbiParameter>? components;
  final String typeBase;
  final String rest;

  if (input.startsWith('(')) {
    final closeIndex = _matchingParen(input, 0);
    components = _parseParamList(input.substring(1, closeIndex));
    final afterParen = input.substring(closeIndex + 1);
    final arrayMatch = RegExp(r'^(\[\d*\])*').firstMatch(afterParen)!;
    typeBase = 'tuple${arrayMatch.group(0)}';
    rest = afterParen.substring(arrayMatch.end).trim();
  } else {
    components = null;
    final firstSpace = input.indexOf(RegExp(r'\s'));
    if (firstSpace == -1) {
      typeBase = _normalizeBaseType(input);
      rest = '';
    } else {
      typeBase = _normalizeBaseType(input.substring(0, firstSpace));
      rest = input.substring(firstSpace).trim();
    }
  }

  bool? indexed;
  String name = '';
  for (final word in rest.split(RegExp(r'\s+')).where((w) => w.isNotEmpty)) {
    if (word == 'indexed') {
      indexed = true;
    } else if (_storageLocationWords.contains(word)) {
      // Storage location doesn't affect the ABI shape — discard.
    } else {
      name = word;
    }
  }

  return AbiParameter(
    name: name,
    type: typeBase,
    components: components,
    indexed: indexed,
  );
}

String _normalizeBaseType(String type) {
  final bracketIndex = type.indexOf('[');
  final base = bracketIndex == -1 ? type : type.substring(0, bracketIndex);
  final suffix = bracketIndex == -1 ? '' : type.substring(bracketIndex);
  final normalizedBase = switch (base) {
    'uint' => 'uint256',
    'int' => 'int256',
    _ => base,
  };
  return '$normalizedBase$suffix';
}
