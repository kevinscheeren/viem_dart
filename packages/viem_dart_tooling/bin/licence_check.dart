import 'dart:io';

import 'package:viem_dart_tooling/src/licence_check_command.dart';
import 'package:viem_dart_tooling/src/workspace.dart';

/// The dependency licence gate: every hosted package in the workspace's
/// `pubspec.lock` is classified from its licence file and checked against the
/// policy in `lib/src/licence_policy.dart`. Exits 1 on a denied or
/// unclassified licence. Run from anywhere inside the workspace after
/// `melos bootstrap`: `melos run check:licences`.
void main(List<String> arguments) {
  final root = findWorkspaceRoot(Directory.current);
  final runtime = runtimeClosure(
    Directory('${root.path}/packages/$publishedPackage'),
  );
  final packages = [
    for (final p in loadWorkspacePackages(root, runtimeNames: runtime))
      readPackageLicence(
        name: p.name,
        version: p.version,
        directory: p.directory,
        isRuntime: p.isRuntime,
      ),
  ];
  exit(reportLicences(packages, stdout));
}
