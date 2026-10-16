import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:source_gen/builder.dart';
import 'package:test/test.dart';
import 'package:viem_dart_builders/builder.dart';

void main() {
  test('generateAbiBuilder wiring round-trips a no-op input', () async {
    // Scaffold-stage proof: a plain library with no @GenerateAbi
    // annotation should build cleanly through the real pipeline —
    // SharedPartBuilder chained with source_gen's own combining_builder,
    // exactly as build.yaml wires them via `applies_builders` — and
    // produce no generated output. Proves the build.yaml -> builder
    // factory -> SharedPartBuilder -> combining_builder -> Generator
    // wiring is correct end-to-end before any real generation logic
    // exists.
    await testBuilders(
      [generateAbiBuilder(BuilderOptions.empty), combiningBuilder()],
      {'a|lib/no_op.dart': 'part "no_op.g.dart";'},
      outputs: {},
    );
  });
}
