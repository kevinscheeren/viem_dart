/// Marks a `part` directive for `viem_dart_builders`-generated typed
/// contract bindings — an ABI-known-ahead-of-time counterpart to the
/// runtime `Contract`/`WalletContract` handles in `package:viem_dart`'s own
/// `getContract()`.
///
/// Usage (mirrors `freezed`/`json_serializable`'s own annotation + `part`
/// shape; see `examples/cli_example/lib/weth.dart` for a real, working
/// one):
///
/// ```dart
/// import 'package:viem_dart/abi.dart';    // AbiFunction/AbiParameter/AbiEvent
/// import 'package:viem_dart/codegen.dart'; // GenerateAbi itself
/// import 'package:viem_dart/viem_dart.dart'; // PublicClient/WalletClient
///
/// @GenerateAbi('lib/abi/erc20.json')
/// part 'erc20.g.dart';
/// ```
///
/// **Import these three yourself, even though nothing in *this* file
/// seems to use them.** The generated `part` file has no imports of its
/// own — it shares whatever the `part of` library (this one) already
/// imports — and the generated code references `PublicClient`/
/// `WalletClient` (`viem_dart.dart`) and `AbiFunction`/`AbiParameter`/
/// `AbiEvent` (`abi.dart`) unconditionally. A `bytes`/`bytesN` field
/// anywhere in the ABI additionally needs `import 'dart:typed_data';`
/// here too (for `Uint8List`). Omitting any of these produces real
/// compile errors in the generated `.g.dart`, not a silent gap.
///
/// Generates a `<Name>Contract` class (typed read methods — see
/// `viem_dart_builders`' read-methods generator) and, if the ABI has any
/// non-`view`/`pure` functions, a `<Name>WalletContract` extending it
/// (typed write methods). `<Name>` is [className] if given, otherwise the
/// PascalCase of [abiPath]'s filename without extension
/// (`lib/abi/erc20.json` -> `Erc20`).
class GenerateAbi {
  /// Creates a `@GenerateAbi` annotation for the ABI JSON file at [abiPath].
  const GenerateAbi(this.abiPath, {this.className});

  /// Path to the ABI JSON file (a JSON array of ABI item objects, the same
  /// shape `AbiItem.fromJson` already parses elsewhere in this package),
  /// resolved package-relative via `AssetId(package, abiPath)` — e.g.
  /// `'lib/abi/erc20.json'` for `<package_root>/lib/abi/erc20.json`.
  ///
  /// **Keep it under `lib/`.** `build_runner` only tracks `lib/**` (plus a
  /// few other top-level dirs — `bin/`, `web/`, `test/`) as buildable
  /// sources by default; a path outside `lib/` (e.g. a package-root `abi/`
  /// folder) is invisible to `BuildStep.readAsString` unless the consuming
  /// package adds its own `build.yaml` `targets: $default: sources:` entry
  /// for it — extra required setup with no ergonomic upside over just
  /// putting the ABI JSON under `lib/` in the first place.
  final String abiPath;

  /// Overrides the generated class name's base (`<className>Contract` /
  /// `<className>WalletContract`). Defaults to the PascalCase of
  /// [abiPath]'s filename without extension.
  final String? className;
}
