import 'dart:io';

import 'package:viem_dart_tooling/src/cyclonedx.dart';
import 'package:viem_dart_tooling/src/release_artifacts.dart';
import 'package:viem_dart_tooling/src/workspace.dart';

/// Writes the CycloneDX SBOM of the published package's runtime closure.
/// Usage: `melos run sbom [-- --out <file>]`, default
/// `build/release/sbom.cdx.json` under the workspace root (git-ignored).
void main(List<String> arguments) {
  final root = findWorkspaceRoot(Directory.current);
  final out = _outPath(arguments, '${root.path}/build/release/sbom.cdx.json');
  final bom = buildSbom(
    readReleaseInputs(root),
    timestamp: DateTime.now(),
    serialNumber: randomUuid(),
    toolVersion: '0.0.1',
  );
  File(out)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(encodeBom(bom));
  stdout.writeln('sbom: wrote $out');
}

String _outPath(List<String> arguments, String fallback) {
  final i = arguments.indexOf('--out');
  return i >= 0 && i + 1 < arguments.length ? arguments[i + 1] : fallback;
}
