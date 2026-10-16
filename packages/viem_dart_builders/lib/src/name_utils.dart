import 'package:path/path.dart' as p;

/// Converts [input] (`snake_case`, `kebab-case`, `camelCase`, or a mix) to
/// `PascalCase`, suitable for a generated class/type name.
String pascalCase(String input) {
  final words = input
      .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
      .split(RegExp(r'[_\-\s]+'))
      .where((w) => w.isNotEmpty);
  return words
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join();
}

/// Converts [input] to `camelCase`, suitable for a generated method/field
/// name (e.g. an ABI parameter's own `name`).
String camelCase(String input) {
  final pascal = pascalCase(input);
  if (pascal.isEmpty) return pascal;
  return pascal[0].toLowerCase() + pascal.substring(1);
}

/// The PascalCase base class name for an ABI JSON file at [abiPath] — its
/// filename without extension, PascalCased (`abi/erc20.json` -> `Erc20`).
String classNameFromAbiPath(String abiPath) =>
    pascalCase(p.basenameWithoutExtension(abiPath));

/// Converts [rawNames] (ABI item/parameter names, often empty — Solidity
/// doesn't require naming every parameter) to unique camelCase Dart
/// identifiers, in order: an empty name becomes `<fallbackPrefix><index>`,
/// and any resulting collision (two ABI names that camelCase to the same
/// identifier, or two synthesized fallbacks) is disambiguated with a
/// numeric suffix (`foo`, `foo2`, `foo3`, ...). Used for method names
/// (overloaded Solidity functions), parameter names, and record field
/// names (unnamed multi-value returns) alike.
List<String> uniqueNames(
  List<String> rawNames, {
  String fallbackPrefix = 'value',
}) {
  final result = <String>[];
  final seenCounts = <String, int>{};
  for (var i = 0; i < rawNames.length; i++) {
    final base = camelCase(
      rawNames[i].isEmpty ? '$fallbackPrefix$i' : rawNames[i],
    );
    final count = seenCounts.update(base, (c) => c + 1, ifAbsent: () => 1);
    result.add(count == 1 ? base : '$base$count');
  }
  return result;
}
