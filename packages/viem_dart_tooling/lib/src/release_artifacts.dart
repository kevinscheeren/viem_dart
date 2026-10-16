import 'dart:io';

import 'cyclonedx.dart';
import 'licence_bundle.dart';
import 'licence_check_command.dart';
import 'licence_policy.dart';
import 'locked_package.dart';
import 'workspace.dart';

/// Code that ships inside `viem_dart` but is not a pub dependency: copied in
/// tree, so the SBOM lists it as a component of its own.
const List<({String name, String version, String licence, String description})>
vendoredComponents = [
  (
    name: 'ens_normalize',
    version: '1.0.4',
    licence: 'BSD-3-Clause',
    description:
        'ENSIP-15 name normalisation, vendored into '
        'packages/viem_dart/lib/src/ens/vendor/ens_normalize with the dart:io '
        'path removed (see its ATTRIBUTION.md).',
  ),
];

/// Everything the SBOM and the licence bundle describe: the published package
/// and the runtime closure it resolves to.
class ReleaseInputs {
  const ReleaseInputs({
    required this.rootName,
    required this.rootVersion,
    required this.packages,
    required this.edges,
    required this.directDependencies,
  });

  final String rootName;
  final String rootVersion;

  /// The runtime closure, hosted packages only, sorted by name.
  final List<LockedPackage> packages;

  /// Package name -> names it depends on, for the whole resolution.
  final Map<String, List<String>> edges;

  /// The published package's own `dependencies:`.
  final Set<String> directDependencies;
}

/// The version in a `pubspec.yaml`.
String pubspecVersion(String pubspecText) {
  final match = RegExp(
    r'^version:\s*(\S+)\s*$',
    multiLine: true,
  ).firstMatch(pubspecText);
  if (match == null) throw StateError('pubspec.yaml has no version.');
  return match.group(1)!;
}

/// Reads the workspace at [root] (after `melos bootstrap`) into
/// [ReleaseInputs] for the published package.
ReleaseInputs readReleaseInputs(Directory root) {
  final packageDir = Directory('${root.path}/packages/$publishedPackage');
  final pubspec = File('${packageDir.path}/pubspec.yaml').readAsStringSync();
  final deps = Process.runSync('dart', [
    'pub',
    'deps',
    '--json',
  ], workingDirectory: packageDir.path);
  if (deps.exitCode != 0) {
    throw StateError('`dart pub deps --json` failed: ${deps.stderr}');
  }
  final direct = directDependencies(pubspec);
  final closure = runtimeClosureFrom(deps.stdout as String, direct);
  return ReleaseInputs(
    rootName: publishedPackage,
    rootVersion: pubspecVersion(pubspec),
    packages: [
      for (final p in loadWorkspacePackages(root, runtimeNames: closure))
        if (p.isRuntime) p,
    ],
    edges: dependencyEdges(deps.stdout as String),
    directDependencies: direct,
  );
}

/// The CycloneDX BOM for [inputs]. Throws if a runtime package's licence is
/// not allowed by the policy: an SBOM never papers over a licence problem.
Map<String, Object> buildSbom(
  ReleaseInputs inputs, {
  required DateTime timestamp,
  required String serialNumber,
  required String toolVersion,
}) {
  final components = <SbomComponent>[];
  for (final p in inputs.packages) {
    final licence = readPackageLicence(
      name: p.name,
      version: p.version,
      directory: p.directory,
      isRuntime: true,
    );
    if (licence.verdict != LicenceVerdict.allowed) {
      throw StateError(
        '${p.name} ${p.version} is not allowed by the licence policy '
        '(${licence.found.isEmpty ? 'no licence found' : licence.found.join(', ')}).',
      );
    }
    components.add(
      SbomComponent(
        name: p.name,
        version: p.version,
        licences: (licence.found.toList()..sort()),
        sha256: p.sha256,
        dependsOn: inputs.edges[p.name] ?? const [],
      ),
    );
  }
  for (final v in vendoredComponents) {
    components.add(
      SbomComponent(
        name: v.name,
        version: v.version,
        licences: [v.licence],
        description: v.description,
      ),
    );
  }
  components.sort((a, b) => a.name.compareTo(b.name));
  return buildCycloneDxBom(
    root: SbomComponent(
      name: inputs.rootName,
      version: inputs.rootVersion,
      licences: const ['MIT'],
      dependsOn: [
        ...inputs.directDependencies,
        for (final v in vendoredComponents) v.name,
      ],
    ),
    components: components,
    timestamp: timestamp,
    serialNumber: serialNumber,
    toolVersion: toolVersion,
  );
}

/// The licence bundle for [inputs], with the repository's [notices].
/// Throws if any runtime package has no licence file.
String buildBundle(ReleaseInputs inputs, {required String notices}) =>
    buildLicenceBundle(
      rootName: inputs.rootName,
      rootVersion: inputs.rootVersion,
      notices: notices,
      packages: [
        for (final p in inputs.packages)
          bundlePackage(
            name: p.name,
            version: p.version,
            directory: p.directory,
          ),
      ],
    );
