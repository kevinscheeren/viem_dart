import 'dart:io';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

void main() {
  test('package exposes a version constant', () {
    expect(viemDartVersion, isNotEmpty);
  });

  test('viemDartVersion equals the version in pubspec.yaml', () {
    // `dart test` runs from the package root. `melos version` bumps the
    // pubspec but not the constant, so a release that forgets it fails here.
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final match = RegExp(
      r'^version:\s*(\S+)\s*$',
      multiLine: true,
    ).firstMatch(pubspec);
    expect(match, isNotNull, reason: 'no top-level version: in pubspec.yaml');
    expect(
      viemDartVersion,
      match!.group(1),
      reason:
          'set viemDartVersion in lib/viem_dart.dart to the pubspec version',
    );
  });
}
