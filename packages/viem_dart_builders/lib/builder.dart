/// The `build.yaml`-referenced builder factory entrypoint for
/// `viem_dart_builders`. Not meant to be imported directly by consumers —
/// only referenced by `build.yaml`'s `import:`/`builder_factories:`.
///
/// See this package's own README for usage (the `@GenerateAbi` annotation
/// itself lives in `package:viem_dart/codegen.dart`, not here) and what
/// gets generated.
library;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generate_abi_generator.dart';

/// Builder factory referenced by `build.yaml`. Wraps [GenerateAbiGenerator]
/// in a [SharedPartBuilder] targeting the shared `.g.dart` combining output
/// (see `build.yaml`'s doc comment for why `SharedPartBuilder` rather than
/// a plain [PartBuilder]).
Builder generateAbiBuilder(BuilderOptions options) =>
    SharedPartBuilder([GenerateAbiGenerator()], 'viem_dart_builders');
