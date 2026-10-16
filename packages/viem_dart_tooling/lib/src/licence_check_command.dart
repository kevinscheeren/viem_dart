import 'dart:io';

import 'licence_policy.dart';

/// One package's licence findings.
class PackageLicence {
  const PackageLicence({
    required this.name,
    required this.version,
    required this.found,
    required this.verdict,
    required this.isRuntime,
    this.licenceFile,
  });

  final String name;
  final String version;
  final Set<String> found;
  final LicenceVerdict verdict;
  final bool isRuntime;

  /// The licence file read, null when the package has none.
  final File? licenceFile;
}

final RegExp _licenceFileName = RegExp(
  r'^(licen[sc]e|copying|unlicen[sc]e)(\.[A-Za-z]+)?$',
  caseSensitive: false,
);

/// The licence files in the top level of [directory] (`LICENSE`,
/// `LICENSE.md`, `COPYING`, `UNLICENSE`...), sorted by name.
List<File> licenceFilesIn(Directory directory) {
  if (!directory.existsSync()) return const [];
  final files = [
    for (final entity in directory.listSync(followLinks: false))
      if (entity is File &&
          _licenceFileName.hasMatch(entity.uri.pathSegments.last))
        entity,
  ]..sort((a, b) => a.path.compareTo(b.path));
  return files;
}

/// Reads and classifies the licence of one package at [directory]. All
/// licence files are read; the identifiers found are pooled, so a second file
/// that carries a denied licence is never hidden by a permissive first one.
PackageLicence readPackageLicence({
  required String name,
  required String version,
  required Directory directory,
  required bool isRuntime,
}) {
  final files = licenceFilesIn(directory);
  final found = <String>{
    for (final file in files) ...classifyLicenceText(file.readAsStringSync()),
  };
  return PackageLicence(
    name: name,
    version: version,
    found: found,
    verdict: verdictFor(found),
    isRuntime: isRuntime,
    licenceFile: files.isEmpty ? null : files.first,
  );
}

/// Renders the gate's report and returns its exit code: 0 when every package
/// is allowed, 1 otherwise. Prints every package, so a green run shows what
/// was actually checked.
int reportLicences(List<PackageLicence> packages, StringSink out) {
  var failures = 0;
  for (final p in packages) {
    final scope = p.isRuntime ? 'runtime' : 'dev';
    final licence = p.found.isEmpty
        ? 'none found'
        : (p.found.toList()..sort()).join(' + ');
    final mark = switch (p.verdict) {
      LicenceVerdict.allowed => 'ok    ',
      LicenceVerdict.denied => 'DENIED',
      LicenceVerdict.unclassified => 'UNKNOWN',
    };
    if (p.verdict != LicenceVerdict.allowed) failures++;
    out.writeln('$mark ${p.name} ${p.version} [$scope] $licence');
  }
  if (failures == 0) {
    out.writeln('licence gate: ${packages.length} packages, all allowed.');
    return 0;
  }
  out.writeln(
    'licence gate: $failures of ${packages.length} packages failed the '
    'policy (denied or unclassified). A denied licence is never accepted '
    'silently; an unclassified one needs its licence file read and a ruling.',
  );
  return 1;
}
