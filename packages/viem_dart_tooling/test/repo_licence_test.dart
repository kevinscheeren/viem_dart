import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/licence_policy.dart';
import 'package:viem_dart_tooling/src/workspace.dart';

/// The repository's own licence files: viem_dart is MIT, held by its author,
/// and every directory that carries third-party material says so in
/// `THIRD_PARTY_NOTICES.md` with the upstream licence text.
void main() {
  final root = findWorkspaceRoot(Directory.current);
  String read(String path) => File('${root.path}/$path').readAsStringSync();

  test('LICENSE is the MIT licence, held by the author', () {
    final licence = read('LICENSE');
    expect(classifyLicenceText(licence), {'MIT'});
    expect(licence, contains('Copyright (c) 2026 The viem_dart authors'));
  });

  test(
    'the published package ships the same LICENSE and notices as the root',
    () {
      expect(read('packages/viem_dart/LICENSE'), read('LICENSE'));
      expect(
        read('packages/viem_dart/THIRD_PARTY_NOTICES.md'),
        read('THIRD_PARTY_NOTICES.md'),
      );
    },
  );

  test(
    'every ATTRIBUTION.md directory is listed in THIRD_PARTY_NOTICES.md',
    () {
      final notices = read('THIRD_PARTY_NOTICES.md');
      final attributions = [
        for (final entity in Directory(
          '${root.path}/packages',
        ).listSync(recursive: true))
          if (entity is File &&
              entity.uri.pathSegments.last == 'ATTRIBUTION.md' &&
              !entity.path.contains('/.dart_tool/'))
            entity.parent.path.substring(root.path.length + 1),
      ];
      expect(attributions, isNotEmpty);
      for (final directory in attributions) {
        expect(notices, contains('`$directory/`'), reason: directory);
      }
    },
  );

  test(
    'THIRD_PARTY_NOTICES.md reproduces the vendored licence text verbatim',
    () {
      final vendored = read(
        'packages/viem_dart/lib/src/ens/vendor/ens_normalize/LICENSE',
      );
      final notices = read('THIRD_PARTY_NOTICES.md');
      for (final line
          in vendored.split('\n').where((l) => l.trim().isNotEmpty)) {
        expect(notices, contains(line), reason: line);
      }
    },
  );

  test('THIRD_PARTY_NOTICES.md carries the viem copyright line', () {
    expect(
      read('THIRD_PARTY_NOTICES.md'),
      contains('Copyright (c) 2023-present weth, LLC'),
    );
  });

  test('no Safe or CoW bytecode is kept in the repository', () {
    // The Safe tests fork Base and use the real deployments instead.
    final fixtures = Directory(
      '${root.path}/packages/viem_dart/test/integration/fixtures/safe',
    );
    expect(fixtures.existsSync(), isTrue);
    expect([
      for (final f in fixtures.listSync()) f.uri.pathSegments.last,
    ], unorderedEquals(['README.md', 'base_fork.dart']));
  });

  test('the pub archive leaves out the anvil-backed integration tests', () {
    final ignored = read('packages/viem_dart/.pubignore').split('\n');
    expect(ignored, contains('test/integration/'));
  });
}
