import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/licence_bundle.dart';

void main() {
  late Directory root;

  setUp(() => root = Directory.systemTemp.createTempSync('licence_bundle_'));
  tearDown(() => root.deleteSync(recursive: true));

  Directory package(String name, Map<String, String> files) {
    final dir = Directory('${root.path}/$name')..createSync();
    files.forEach((f, t) => File('${dir.path}/$f').writeAsStringSync(t));
    return dir;
  }

  test('bundlePackage reads every licence file', () {
    final p = bundlePackage(
      name: 'a',
      version: '1.0.0',
      directory: package('a', {'LICENSE': 'MIT text', 'COPYING': 'more'}),
    );
    expect(p.licenceFiles, hasLength(2));
  });

  test('bundlePackage throws when a package has no licence file', () {
    expect(
      () => bundlePackage(
        name: 'bare',
        version: '1.0.0',
        directory: package('bare', {'README.md': 'x'}),
      ),
      throwsA(
        isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('bare 1.0.0'),
        ),
      ),
    );
  });

  test(
    'the bundle holds the notices and each licence text verbatim, sorted',
    () {
      final z = bundlePackage(
        name: 'zeta',
        version: '2.0.0',
        directory: package('zeta', {'LICENSE': 'ZETA LICENCE TEXT'}),
      );
      final a = bundlePackage(
        name: 'alpha',
        version: '1.0.0',
        directory: package('alpha', {'LICENSE': 'ALPHA LICENCE TEXT'}),
      );
      final bundle = buildLicenceBundle(
        rootName: 'app',
        rootVersion: '1.0.0',
        notices: '# Notices\nviem copyright\n',
        packages: [z, a],
      );
      expect(bundle, contains('Third-party licences of app 1.0.0'));
      expect(bundle, contains('the 2 packages it depends on'));
      expect(bundle, contains('viem copyright'));
      expect(bundle, contains('ALPHA LICENCE TEXT'));
      expect(bundle, contains('ZETA LICENCE TEXT'));
      expect(
        bundle.indexOf('alpha 1.0.0'),
        lessThan(bundle.indexOf('zeta 2.0.0')),
      );
      expect(
        bundle.indexOf('viem copyright'),
        lessThan(bundle.indexOf('alpha 1.0.0')),
      );
      expect(bundle, contains('https://pub.dev/packages/alpha/versions/1.0.0'));
    },
  );
}
