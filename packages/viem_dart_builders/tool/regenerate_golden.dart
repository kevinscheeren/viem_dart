// Regenerates test/golden/erc20.g.dart.golden from
// test/golden/erc20_fragment.json via the real generateContractSource()
// codegen path — the same function generate_abi_generator_golden_test.dart
// itself calls and diffs against this file.
//
// Only run this deliberately, when a generator change intentionally alters
// the output shape (verify the new output is *correct*, don't just
// rubber-stamp a diff) — not as a way to make a failing golden test pass
// without understanding why it changed.
//
// Usage (from packages/viem_dart_builders/):
//   dart run tool/regenerate_golden.dart > test/golden/erc20.g.dart.golden
import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/generate_abi_generator.dart';

void main() {
  final json =
      jsonDecode(File('test/golden/erc20_fragment.json').readAsStringSync())
          as List;
  final abiItems = json
      .map((e) => AbiItem.fromJson(e as Map<String, dynamic>))
      .toList();
  final source = generateContractSource('Erc20', abiItems);
  final formatted = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format(source);
  stdout.write(formatted);
}
