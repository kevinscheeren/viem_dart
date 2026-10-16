import 'dart:convert';
import 'dart:io';

/// One hosted (pub.dev) package the workspace resolved: where its source is
/// on disk, the archive hash the lockfile pins, and whether it is part of the
/// runtime closure of a published package or only of the dev tooling.
class LockedPackage {
  const LockedPackage({
    required this.name,
    required this.version,
    required this.directory,
    required this.sha256,
    required this.isRuntime,
  });

  final String name;
  final String version;

  /// The unpacked package in the pub cache.
  final Directory directory;

  /// The archive SHA-256 from `pubspec.lock`.
  final String sha256;

  /// True when a published package reaches it without dev dependencies.
  final bool isRuntime;

  /// Package URL (`pkg:pub/<name>@<version>`), the SBOM's component id.
  String get purl => 'pkg:pub/$name@$version';
}

/// The hosted packages in [lockfileText] (a `pubspec.lock`), by name:
/// `name -> (version, sha256)`. Path, git and SDK packages are skipped: only
/// hosted packages are third-party licences to check.
Map<String, ({String version, String sha256})> parseHostedLockEntries(
  String lockfileText,
) {
  final result = <String, ({String version, String sha256})>{};
  // One entry per two-space-indented key under `packages:`.
  final entries = RegExp(
    r'^  ([A-Za-z0-9_]+):\n((?:    .*\n|\n)*)',
    multiLine: true,
  );
  for (final match in entries.allMatches('$lockfileText\n')) {
    final body = match.group(2)!;
    if (!RegExp(r'^    source: hosted$', multiLine: true).hasMatch(body)) {
      continue;
    }
    final version = RegExp(
      r'^    version: "?([^"\n]+)"?$',
      multiLine: true,
    ).firstMatch(body)?.group(1);
    final hash = RegExp(
      r'^      sha256: "?([0-9a-f]{64})"?$',
      multiLine: true,
    ).firstMatch(body)?.group(1);
    if (version == null || hash == null) continue;
    result[match.group(1)!] = (version: version, sha256: hash);
  }
  return result;
}

/// Package name -> source directory, from a `package_config.json`.
Map<String, Directory> parsePackageConfigDirectories(
  String configText,
  Uri configUri,
) {
  final config = jsonDecode(configText) as Map<String, Object?>;
  return {
    for (final entry in config['packages']! as List<Object?>)
      (entry! as Map<String, Object?>)['name']! as String: Directory.fromUri(
        configUri.resolve(
          (entry as Map<String, Object?>)['rootUri']! as String,
        ),
      ),
  };
}

/// The package names listed under `dependencies:` (not `dev_dependencies:`)
/// in [pubspecText].
Set<String> directDependencies(String pubspecText) {
  final block = RegExp(
    r'^dependencies:\n((?:[ \t]+.*\n|\n)*)',
    multiLine: true,
  ).firstMatch('$pubspecText\n')?.group(1);
  if (block == null) return {};
  return {
    for (final m in RegExp(
      r'^  ([A-Za-z0-9_]+):',
      multiLine: true,
    ).allMatches(block))
      m.group(1)!,
  };
}

/// The runtime closure: [direct] (the published package's `dependencies:`)
/// plus everything they reach in the `dart pub deps --json` document
/// [depsJson]. The root's own edges are not followed, because they include
/// its dev dependencies.
Set<String> runtimeClosureFrom(String depsJson, Set<String> direct) {
  final doc = jsonDecode(depsJson) as Map<String, Object?>;
  final byName = {
    for (final p in doc['packages']! as List<Object?>)
      (p! as Map<String, Object?>)['name']! as String:
          (p as Map<String, Object?>),
  };
  final seen = <String>{};
  final queue = [...direct];
  while (queue.isNotEmpty) {
    final name = queue.removeLast();
    if (!seen.add(name)) continue;
    final deps = byName[name]?['dependencies'] as List<Object?>? ?? const [];
    queue.addAll(deps.cast<String>());
  }
  return seen;
}

/// Package name -> the names it depends on, from a `dart pub deps --json`
/// document. Dev dependencies of the root are included in the root's own edge
/// list, so callers start from [directDependencies], not from the root.
Map<String, List<String>> dependencyEdges(String depsJson) {
  final doc = jsonDecode(depsJson) as Map<String, Object?>;
  return {
    for (final p in doc['packages']! as List<Object?>)
      (p! as Map<String, Object?>)['name']! as String: [
        ...((p as Map<String, Object?>)['dependencies'] as List<Object?>? ??
                const [])
            .cast<String>(),
      ],
  };
}
