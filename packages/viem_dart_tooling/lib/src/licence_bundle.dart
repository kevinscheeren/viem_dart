import 'dart:io';

import 'licence_check_command.dart';

/// One package's entry in the bundle.
class BundledPackage {
  const BundledPackage({
    required this.name,
    required this.version,
    required this.licenceFiles,
  });

  final String name;
  final String version;

  /// The package's licence files, read verbatim.
  final List<File> licenceFiles;
}

/// The licence files of [directory] as a [BundledPackage], or throws a
/// [StateError] when it has none: a release must never ship a bundle with a
/// dependency's licence text missing.
BundledPackage bundlePackage({
  required String name,
  required String version,
  required Directory directory,
}) {
  final files = licenceFilesIn(directory);
  if (files.isEmpty) {
    throw StateError('$name $version has no licence file in ${directory.path}');
  }
  return BundledPackage(name: name, version: version, licenceFiles: files);
}

const String _rule =
    '================================================================================';

/// The text of the third-party licence bundle: [notices] (the repository's own
/// `THIRD_PARTY_NOTICES.md`, covering what is vendored or ported in tree)
/// followed by every runtime dependency's licence text, verbatim, sorted by
/// name. Reproduced in each redistributed copy, as MIT, BSD and Apache require.
String buildLicenceBundle({
  required String rootName,
  required String rootVersion,
  required String notices,
  required List<BundledPackage> packages,
}) {
  final sorted = [...packages]..sort((a, b) => a.name.compareTo(b.name));
  final out = StringBuffer()
    ..writeln('Third-party licences of $rootName $rootVersion')
    ..writeln()
    ..writeln(
      '$rootName is licensed under the MIT License (see LICENSE). This file '
      'reproduces the licence text of the material it contains and of the '
      '${sorted.length} packages it depends on at run time.',
    )
    ..writeln()
    ..writeln(_rule)
    ..writeln('Material in this repository (THIRD_PARTY_NOTICES.md)')
    ..writeln(_rule)
    ..writeln()
    ..writeln(notices.trimRight());
  for (final p in sorted) {
    for (final file in p.licenceFiles) {
      out
        ..writeln()
        ..writeln(_rule)
        ..writeln('${p.name} ${p.version} (${file.uri.pathSegments.last})')
        ..writeln('https://pub.dev/packages/${p.name}/versions/${p.version}')
        ..writeln(_rule)
        ..writeln()
        ..writeln(file.readAsStringSync().trimRight());
    }
  }
  return out.toString();
}
