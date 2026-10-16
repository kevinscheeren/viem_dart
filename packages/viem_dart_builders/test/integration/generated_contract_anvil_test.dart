// Runs the typed contracts `viem_dart_builders` generates against a real
// anvil: the generator is golden-tested, but a stale-but-compiling
// generator (a wrong selector, a wrong Dart type) would still pass that.
//
// The generator's own entry point, `generateContractSource`, is run on the
// ABI of the `Probe` contract (probe_artifact.json, compiled from
// packages/viem_dart/test/integration/fixtures/CapabilityProbes.sol), the
// result is materialized next to fixtures/probe_driver.dart.tmpl in a
// package-local scratch directory (so `package:viem_dart/...` imports
// resolve), and that driver, a plain `package:test` test that calls the
// generated read, write and event methods, is run with `dart test` against
// the anvil this test starts. Nothing generated is committed, so nothing
// can go stale.
@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/generate_abi_generator.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

void main() {
  late AnvilHarness harness;

  setUpAll(() async {
    harness = await AnvilHarness.start(port: 8557);
  });

  tearDownAll(() => harness.stop());

  test(
    'the generated Probe bindings read, write and decode events on anvil',
    () async {
      final artifact =
          jsonDecode(
                File(
                  'test/integration/fixtures/probe_artifact.json',
                ).readAsStringSync(),
              )
              as Map<String, dynamic>;
      final abiItems = (artifact['abi'] as List)
          .map((e) => AbiItem.fromJson(e as Map<String, dynamic>))
          .toList();

      // What a real consuming library must import for the generated code to
      // compile (see `GenerateAbi`'s doc comment).
      final source =
          DartFormatter(
            languageVersion: DartFormatter.latestLanguageVersion,
          ).format('''
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/viem_dart.dart';

${generateContractSource('Probe', abiItems)}
''');

      // Ignored by git; see /.gitignore.
      final dir = Directory('test/.generated_probe/anvil');
      await dir.create(recursive: true);
      addTearDown(() => dir.delete(recursive: true));
      File(
        '${dir.path}/generated_probe_contract.dart',
      ).writeAsStringSync(source);
      final driver = File('${dir.path}/probe_driver.dart')
        ..writeAsStringSync(
          File(
            'test/integration/fixtures/probe_driver.dart.tmpl',
          ).readAsStringSync(),
        );

      final result = await Process.run(
        'dart',
        ['test', driver.path, '--reporter=expanded'],
        environment: {
          'PROBE_RPC_URL': harness.rpcUrl,
          'PROBE_BYTECODE': artifact['bytecode'] as String,
        },
      );
      expect(
        result.exitCode,
        0,
        reason:
            'The generated Probe bindings failed against anvil:\n'
            '${result.stdout}\n${result.stderr}\n\n'
            'Generated source:\n$source',
      );
      // `dart test` of a file with no tests also exits 0 only with a warning.
      expect(result.stdout, contains('All tests passed'));
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
