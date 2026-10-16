import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart_tooling/src/licence_check_command.dart';
import 'package:viem_dart_tooling/src/licence_policy.dart';
import 'package:viem_dart_tooling/src/workspace.dart';

const _mit =
    'Permission is hereby granted, free of charge, to any person obtaining a '
    'copy of this software. The above copyright notice and this permission '
    'notice shall be included in all copies.';
const _gpl = 'GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007';

void main() {
  late Directory root;

  setUp(() => root = Directory.systemTemp.createTempSync('licence_check_'));
  tearDown(() => root.deleteSync(recursive: true));

  Directory package(String name, {Map<String, String> files = const {}}) {
    final dir = Directory('${root.path}/cache/$name')
      ..createSync(recursive: true);
    files.forEach(
      (file, text) => File('${dir.path}/$file').writeAsStringSync(text),
    );
    return dir;
  }

  PackageLicence read(Directory dir) => readPackageLicence(
    name: 'pkg',
    version: '1.0.0',
    directory: dir,
    isRuntime: true,
  );

  group('readPackageLicence', () {
    test('allows a package with a permissive LICENSE', () {
      final p = read(package('ok', files: {'LICENSE': _mit}));
      expect(p.verdict, LicenceVerdict.allowed);
      expect(p.found, {'MIT'});
    });

    test('reads LICENSE.md, COPYING and UNLICENSE spellings', () {
      for (final name in ['LICENSE.md', 'COPYING', 'license', 'UNLICENSE']) {
        final dir = package('n_$name', files: {name: _mit});
        expect(read(dir).verdict, LicenceVerdict.allowed, reason: name);
      }
    });

    test('denies a GPL package (the deliberate probe)', () {
      final p = read(package('gpl', files: {'LICENSE': _gpl}));
      expect(p.verdict, LicenceVerdict.denied);
    });

    test('is not fooled by a permissive file next to a GPL one', () {
      final p = read(
        package('both', files: {'LICENSE': _mit, 'COPYING': _gpl}),
      );
      expect(p.verdict, LicenceVerdict.denied);
    });

    test('leaves a package without a licence file unclassified', () {
      final p = read(package('bare', files: {'README.md': _mit}));
      expect(p.verdict, LicenceVerdict.unclassified);
      expect(p.licenceFile, isNull);
    });

    test('leaves a missing directory unclassified instead of throwing', () {
      final p = read(Directory('${root.path}/nope'));
      expect(p.verdict, LicenceVerdict.unclassified);
    });
  });

  group('reportLicences', () {
    PackageLicence of(String name, LicenceVerdict v) => PackageLicence(
      name: name,
      version: '1.0.0',
      found: {if (v == LicenceVerdict.allowed) 'MIT'},
      verdict: v,
      isRuntime: true,
    );

    test('exits 0 and lists every package when all are allowed', () {
      final out = StringBuffer();
      final code = reportLicences([of('a', LicenceVerdict.allowed)], out);
      expect(code, 0);
      expect(out.toString(), contains('a 1.0.0 [runtime] MIT'));
      expect(out.toString(), contains('1 packages, all allowed'));
    });

    test('exits 1 on a denied package and names it', () {
      final out = StringBuffer();
      final code = reportLicences([
        of('a', LicenceVerdict.allowed),
        of('bad', LicenceVerdict.denied),
      ], out);
      expect(code, 1);
      expect(out.toString(), contains('DENIED bad'));
    });

    test('exits 1 on an unclassified package', () {
      final out = StringBuffer();
      expect(reportLicences([of('x', LicenceVerdict.unclassified)], out), 1);
      expect(out.toString(), contains('UNKNOWN x'));
    });
  });

  group('the gate over a workspace', () {
    // A fake workspace: lockfile + package_config pointing at fake cache dirs.
    void writeWorkspace(Map<String, String> licenceByPackage) {
      final lock = StringBuffer('packages:\n');
      final config = StringBuffer('{"configVersion":2,"packages":[');
      var first = true;
      licenceByPackage.forEach((name, text) {
        final dir = package('$name-1.0.0', files: {'LICENSE': text});
        lock.write(
          '  $name:\n    dependency: transitive\n    description:\n'
          '      name: $name\n      sha256: "${'a' * 64}"\n'
          '      url: "https://pub.dev"\n    source: hosted\n'
          '    version: "1.0.0"\n',
        );
        if (!first) config.write(',');
        first = false;
        config.write(
          '{"name":"$name","rootUri":"${dir.uri}","packageUri":"lib/"}',
        );
      });
      config.write(']}');
      File('${root.path}/pubspec.lock').writeAsStringSync(lock.toString());
      Directory('${root.path}/.dart_tool').createSync();
      File(
        '${root.path}/.dart_tool/package_config.json',
      ).writeAsStringSync(config.toString());
    }

    int gate() {
      final packages = [
        for (final p in loadWorkspacePackages(root, runtimeNames: {'good'}))
          readPackageLicence(
            name: p.name,
            version: p.version,
            directory: p.directory,
            isRuntime: p.isRuntime,
          ),
      ];
      return reportLicences(packages, StringBuffer());
    }

    test('passes a clean workspace', () {
      writeWorkspace({'good': _mit, 'fine': _mit});
      expect(gate(), 0);
    });

    test('fails when a GPL probe package joins the lockfile', () {
      writeWorkspace({'good': _mit, 'gpl_probe': _gpl});
      expect(gate(), 1);
    });

    test('asks for a bootstrap when the lockfile is missing', () {
      expect(
        () => loadWorkspacePackages(root, runtimeNames: {}),
        throwsA(isA<StateError>()),
      );
    });
  });
}
