import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/locked_package.dart';
import 'package:viem_dart_tooling/src/release_artifacts.dart';

const _mit =
    'Permission is hereby granted, free of charge, to any person obtaining a '
    'copy of this software. The above copyright notice and this permission '
    'notice shall be included in all copies.';
const _gpl = 'GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007';

void main() {
  late Directory root;

  setUp(() => root = Directory.systemTemp.createTempSync('release_inputs_'));
  tearDown(() => root.deleteSync(recursive: true));

  LockedPackage locked(String name, String licenceText) {
    final dir = Directory('${root.path}/$name')..createSync();
    File('${dir.path}/LICENSE').writeAsStringSync(licenceText);
    return LockedPackage(
      name: name,
      version: '1.0.0',
      directory: dir,
      sha256: 'b' * 64,
      isRuntime: true,
    );
  }

  ReleaseInputs inputs(List<LockedPackage> packages) => ReleaseInputs(
    rootName: 'viem_dart',
    rootVersion: '0.1.0',
    packages: packages,
    edges: {for (final p in packages) p.name: <String>[]},
    directDependencies: {for (final p in packages) p.name},
  );

  Map<String, Object> sbom(ReleaseInputs i) => buildSbom(
    i,
    timestamp: DateTime.utc(2026),
    serialNumber: 'x',
    toolVersion: '0',
  );

  test('pubspecVersion reads the version line', () {
    expect(pubspecVersion('name: x\nversion: 1.2.3-dev.1\n'), '1.2.3-dev.1');
    expect(() => pubspecVersion('name: x\n'), throwsStateError);
  });

  test(
    'buildSbom classifies each package and adds the vendored components',
    () {
      final bom = sbom(inputs([locked('http', _mit)]));
      final names = [
        for (final c
            in (bom['components']! as List).cast<Map<String, Object?>>())
          c['name'],
      ];
      expect(names, ['ens_normalize', 'http']);
      final http = (bom['components']! as List)
          .cast<Map<String, Object?>>()
          .last;
      expect(http['licenses'], [
        {
          'license': {'id': 'MIT'},
        },
      ]);
      // The root depends on its direct dependencies and on the vendored copy.
      final rootDeps = (bom['dependencies']! as List)
          .cast<Map<String, Object?>>()
          .first;
      expect(rootDeps['dependsOn'], contains('pkg:pub/ens_normalize@1.0.4'));
    },
  );

  test('buildSbom refuses a package whose licence is denied (GPL probe)', () {
    expect(
      () => sbom(inputs([locked('http', _mit), locked('copyleft', _gpl)])),
      throwsA(
        isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('copyleft'),
        ),
      ),
    );
  });

  test('buildSbom refuses a package with no recognisable licence', () {
    expect(
      () => sbom(inputs([locked('odd', 'all rights reserved')])),
      throwsStateError,
    );
  });

  test('buildBundle fails when a runtime package has no licence file', () {
    final dir = Directory('${root.path}/bare')..createSync();
    final p = LockedPackage(
      name: 'bare',
      version: '1.0.0',
      directory: dir,
      sha256: 'c' * 64,
      isRuntime: true,
    );
    expect(() => buildBundle(inputs([p]), notices: 'n'), throwsStateError);
  });

  test('buildBundle includes the notices and each package licence', () {
    final text = buildBundle(
      inputs([locked('http', _mit)]),
      notices: 'NOTICES HERE',
    );
    expect(text, contains('NOTICES HERE'));
    expect(text, contains(_mit));
  });
}
