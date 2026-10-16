import 'dart:io';

import 'locked_package.dart';

/// The package whose runtime closure the release artifacts describe: the only
/// published package of the workspace.
const String publishedPackage = 'viem_dart';

/// The package names the runtime closure of [packageDirectory] reaches: its
/// `dependencies:` and everything they pull in, without dev dependencies.
/// Runs `dart pub deps --json`; throws if `dart` fails.
Set<String> runtimeClosure(Directory packageDirectory) {
  final result = Process.runSync('dart', [
    'pub',
    'deps',
    '--json',
  ], workingDirectory: packageDirectory.path);
  if (result.exitCode != 0) {
    throw StateError(
      '`dart pub deps --json` failed in ${packageDirectory.path}: '
      '${result.stderr}',
    );
  }
  final pubspec = File('${packageDirectory.path}/pubspec.yaml');
  return runtimeClosureFrom(
    result.stdout as String,
    directDependencies(pubspec.readAsStringSync()),
  );
}

/// Every hosted package the workspace at [root] resolved, sorted by name.
///
/// [runtimeNames] marks the runtime closure; the rest is dev tooling. Needs
/// `melos bootstrap` (or `dart pub get`) to have run, so the lockfile and
/// `.dart_tool/package_config.json` exist.
List<LockedPackage> loadWorkspacePackages(
  Directory root, {
  required Set<String> runtimeNames,
}) {
  final lockFile = File('${root.path}/pubspec.lock');
  final configFile = File('${root.path}/.dart_tool/package_config.json');
  for (final file in [lockFile, configFile]) {
    if (!file.existsSync()) {
      throw StateError('${file.path} is missing: run `melos bootstrap` first.');
    }
  }
  final locked = parseHostedLockEntries(lockFile.readAsStringSync());
  final directories = parsePackageConfigDirectories(
    configFile.readAsStringSync(),
    configFile.absolute.uri,
  );
  return [
    for (final entry in locked.entries)
      LockedPackage(
        name: entry.key,
        version: entry.value.version,
        sha256: entry.value.sha256,
        directory:
            directories[entry.key] ??
            (throw StateError(
              '${entry.key} is locked but not in package_config.json.',
            )),
        isRuntime: runtimeNames.contains(entry.key),
      ),
  ]..sort((a, b) => a.name.compareTo(b.name));
}

/// The workspace root: the nearest parent of [from] whose `pubspec.yaml`
/// declares a `workspace:`.
Directory findWorkspaceRoot(Directory from) {
  var dir = from.absolute;
  while (true) {
    final pubspec = File('${dir.path}/pubspec.yaml');
    if (pubspec.existsSync() &&
        RegExp(
          r'^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return dir;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('No workspace root found above ${from.path}.');
    }
    dir = parent;
  }
}
