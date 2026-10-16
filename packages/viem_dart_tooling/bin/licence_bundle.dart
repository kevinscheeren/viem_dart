import 'dart:io';

import 'package:viem_dart_tooling/src/release_artifacts.dart';
import 'package:viem_dart_tooling/src/workspace.dart';

/// Writes the third-party licence bundle: the repository's notices plus the
/// licence text of every runtime dependency. Usage:
/// `melos run licence-bundle [-- --out <file>]`, default
/// `build/release/THIRD_PARTY_LICENSES` under the workspace root (git-ignored).
void main(List<String> arguments) {
  final root = findWorkspaceRoot(Directory.current);
  final i = arguments.indexOf('--out');
  final out = i >= 0 && i + 1 < arguments.length
      ? arguments[i + 1]
      : '${root.path}/build/release/THIRD_PARTY_LICENSES';
  final bundle = buildBundle(
    readReleaseInputs(root),
    notices: File('${root.path}/THIRD_PARTY_NOTICES.md').readAsStringSync(),
  );
  File(out)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync('$bundle\n');
  stdout.writeln('licence-bundle: wrote $out');
}
