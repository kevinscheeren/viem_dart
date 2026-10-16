import 'dart:convert';
import 'dart:math';

/// One component of the SBOM: a pub.dev package (or a vendored copy of one)
/// in the runtime closure of the published package.
class SbomComponent {
  const SbomComponent({
    required this.name,
    required this.version,
    required this.licences,
    this.sha256,
    this.description,
    this.dependsOn = const [],
  });

  final String name;
  final String version;

  /// SPDX identifiers, one `license` entry each.
  final List<String> licences;

  /// The pub.dev archive hash, when the lockfile pins one.
  final String? sha256;

  final String? description;

  /// Names of the components this one depends on.
  final List<String> dependsOn;

  String get purl => 'pkg:pub/$name@$version';
}

/// A random RFC 4122 version-4 UUID, for the BOM's `serialNumber`.
String randomUuid([Random? random]) {
  final r = random ?? Random.secure();
  final bytes = List<int>.generate(16, (_) => r.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}

Map<String, Object> _licences(List<String> ids) => {
  'licenses': [
    for (final id in ids)
      {
        'license': {'id': id},
      },
  ],
};

/// A CycloneDX 1.6 BOM (as a plain map, ready for `jsonEncode`) for [root] and
/// its runtime closure [components].
///
/// The caller supplies [timestamp] and [serialNumber] (the only two inputs
/// that vary between runs), so tests get fully deterministic output.
Map<String, Object> buildCycloneDxBom({
  required SbomComponent root,
  required List<SbomComponent> components,
  required DateTime timestamp,
  required String serialNumber,
  required String toolVersion,
}) {
  final byName = {for (final c in components) c.name: c};
  Map<String, Object> component(SbomComponent c, {required String type}) => {
    'type': type,
    'bom-ref': c.purl,
    'name': c.name,
    'version': c.version,
    if (c.description != null) 'description': c.description!,
    ..._licences(c.licences),
    'purl': c.purl,
    if (c.sha256 != null)
      'hashes': [
        {'alg': 'SHA-256', 'content': c.sha256!},
      ],
  };
  Map<String, Object> dependency(SbomComponent c) => {
    'ref': c.purl,
    'dependsOn': [
      for (final name in c.dependsOn)
        if (byName[name] != null) byName[name]!.purl,
    ],
  };
  return {
    'bomFormat': 'CycloneDX',
    'specVersion': '1.6',
    'serialNumber': 'urn:uuid:$serialNumber',
    'version': 1,
    'metadata': {
      'timestamp': timestamp.toUtc().toIso8601String(),
      'tools': {
        'components': [
          {
            'type': 'application',
            'name': 'viem_dart_tooling sbom',
            'version': toolVersion,
          },
        ],
      },
      'component': component(root, type: 'library'),
    },
    'components': [for (final c in components) component(c, type: 'library')],
    'dependencies': [
      dependency(root),
      for (final c in components) dependency(c),
    ],
  };
}

/// [buildCycloneDxBom]'s output as pretty-printed JSON with a trailing newline.
String encodeBom(Map<String, Object> bom) =>
    '${const JsonEncoder.withIndent('  ').convert(bom)}\n';
