import 'dart:convert';
import 'dart:math';

import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/cyclonedx.dart';

void main() {
  const root = SbomComponent(
    name: 'app',
    version: '1.0.0',
    licences: ['MIT'],
    dependsOn: ['http', 'ens'],
  );
  const http = SbomComponent(
    name: 'http',
    version: '1.6.0',
    licences: ['BSD-3-Clause'],
    sha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    dependsOn: ['meta', 'not_a_component'],
  );
  const meta = SbomComponent(
    name: 'meta',
    version: '1.19.0',
    licences: ['BSD-3-Clause'],
  );
  const ens = SbomComponent(
    name: 'ens',
    version: '1.0.4',
    licences: ['BSD-3-Clause'],
    description: 'vendored',
  );

  Map<String, Object> build() => buildCycloneDxBom(
    root: root,
    components: [ens, http, meta],
    timestamp: DateTime.utc(2026, 10, 5, 12),
    serialNumber: '3e671687-395b-41f5-a30f-a58921a69b79',
    toolVersion: '0.0.1',
  );

  test('declares CycloneDX 1.6 with the caller-supplied serial and time', () {
    final bom = build();
    expect(bom['bomFormat'], 'CycloneDX');
    expect(bom['specVersion'], '1.6');
    expect(
      bom['serialNumber'],
      'urn:uuid:3e671687-395b-41f5-a30f-a58921a69b79',
    );
    expect(bom['version'], 1);
    expect(
      (bom['metadata']! as Map<String, Object?>)['timestamp'],
      '2026-10-05T12:00:00.000Z',
    );
  });

  test('describes the root as the metadata component', () {
    final component =
        (build()['metadata']! as Map<String, Object?>)['component']!
            as Map<String, Object?>;
    expect(component['purl'], 'pkg:pub/app@1.0.0');
    expect(component['bom-ref'], 'pkg:pub/app@1.0.0');
    expect(component['licenses'], [
      {
        'license': {'id': 'MIT'},
      },
    ]);
  });

  test('gives every component a unique bom-ref, a purl and a licence id', () {
    final components = build()['components']! as List;
    final refs = [
      for (final c in components) (c as Map<String, Object?>)['bom-ref'],
    ];
    expect(refs.toSet(), hasLength(refs.length));
    for (final c in components.cast<Map<String, Object?>>()) {
      expect(c['type'], 'library');
      expect(c['purl'], startsWith('pkg:pub/'));
      expect(c['licenses'], isNotEmpty);
    }
  });

  test('records the archive hash only where the lockfile pins one', () {
    final byName = {
      for (final c
          in (build()['components']! as List).cast<Map<String, Object?>>())
        c['name']: c,
    };
    expect(byName['http']!['hashes'], [
      {'alg': 'SHA-256', 'content': 'a' * 64},
    ]);
    expect(byName['meta']!.containsKey('hashes'), isFalse);
    expect(byName['ens']!['description'], 'vendored');
  });

  test(
    'writes a licence entry per identifier of a multi-licence component',
    () {
      const dual = SbomComponent(
        name: 'dual',
        version: '1.0.0',
        licences: ['Apache-2.0', 'MIT'],
      );
      final bom = buildCycloneDxBom(
        root: root,
        components: [dual],
        timestamp: DateTime.utc(2026),
        serialNumber: 'x',
        toolVersion: '0',
      );
      final c = (bom['components']! as List).single as Map<String, Object?>;
      expect(c['licenses'], hasLength(2));
    },
  );

  test('links dependencies by ref and drops edges to unknown packages', () {
    final deps = {
      for (final d
          in (build()['dependencies']! as List).cast<Map<String, Object?>>())
        d['ref']: d['dependsOn'],
    };
    expect(deps['pkg:pub/app@1.0.0'], [
      'pkg:pub/http@1.6.0',
      'pkg:pub/ens@1.0.4',
    ]);
    expect(deps['pkg:pub/http@1.6.0'], ['pkg:pub/meta@1.19.0']);
    expect(deps['pkg:pub/meta@1.19.0'], isEmpty);
    // Every ref a dependency names is a component or the root.
    final known = {
      'pkg:pub/app@1.0.0',
      for (final c
          in (build()['components']! as List).cast<Map<String, Object?>>())
        c['bom-ref'],
    };
    for (final list in deps.values) {
      expect(known, containsAll((list! as List).cast<Object>()));
    }
  });

  test('encodeBom is JSON that round-trips, ending in a newline', () {
    final text = encodeBom(build());
    expect(text, endsWith('}\n'));
    expect(jsonDecode(text), build());
  });

  test('randomUuid is a version-4 UUID and varies', () {
    final a = randomUuid(Random(1));
    expect(
      a,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
    expect(randomUuid(Random(1)), a);
    expect(randomUuid(Random(2)), isNot(a));
  });
}
