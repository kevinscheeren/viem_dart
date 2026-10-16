import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart_builders/src/generate_abi_generator.dart';

const _erc20AbiJson = '''
[
  {
    "type": "function",
    "name": "balanceOf",
    "stateMutability": "view",
    "inputs": [{"name": "owner", "type": "address"}],
    "outputs": [{"name": "", "type": "uint256"}]
  },
  {
    "type": "function",
    "name": "transfer",
    "stateMutability": "nonpayable",
    "inputs": [
      {"name": "to", "type": "address"},
      {"name": "amount", "type": "uint256"}
    ],
    "outputs": [{"name": "", "type": "bool"}]
  },
  {
    "type": "event",
    "name": "Transfer",
    "inputs": [
      {"name": "from", "type": "address", "indexed": true},
      {"name": "to", "type": "address", "indexed": true},
      {"name": "value", "type": "uint256", "indexed": false}
    ]
  }
]
''';

/// Exercises [loadAbiItems] directly through a real [BuildStep] (via a
/// throwaway [Generator], not [GenerateAbiGenerator] itself) rather than
/// through the full `@GenerateAbi`-directive-resolution path.
///
/// This is deliberate, not a scope cut: `build_test`'s `testBuilder(s)`
/// mock resolver hits a real Stack Overflow (confirmed via an isolated
/// minimal repro outside this package — a `GeneratorForAnnotation<T>`
/// resolving a directive/element annotated with a type from a REAL,
/// already-`pub get`-resolved cross-package dependency, as `GenerateAbi`
/// from `package:viem_dart` is here) in this analyzer/source_gen/build_test
/// version combination. The *real* `build_runner` pipeline has no such
/// issue — manually verified end-to-end against a real temp package
/// (`dart pub get` + `dart run build_runner build` produced the correct
/// `erc20.g.dart`). The full annotation-driven pipeline
/// (`GenerateAbiGenerator` itself) gets its automated proof in the
/// golden-file harness (`generate_abi_generator_golden_test.dart`) and in
/// `examples/cli_example`, which run the real codegen path for the same
/// reason.
class _LoadAbiItemsProbeGenerator extends Generator {
  _LoadAbiItemsProbeGenerator(this.abiPath);
  final String abiPath;

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final items = await loadAbiItems(buildStep, abiPath);
    final functionCount = items.whereType<AbiFunction>().length;
    final eventCount = items.whereType<AbiEvent>().length;
    return '// loaded ${items.length} ABI item(s) '
        '($functionCount function(s), $eventCount event(s)).';
  }
}

void main() {
  test(
    'loadAbiItems resolves the abiPath asset and parses it with AbiItem.fromJson',
    () async {
      await testBuilder(
        LibraryBuilder(_LoadAbiItemsProbeGenerator('lib/abi/erc20.json')),
        {
          'a|lib/erc20.dart': 'part "erc20.g.dart";',
          'a|lib/abi/erc20.json': _erc20AbiJson,
        },
        outputs: {
          'a|lib/erc20.g.dart': decodedMatches(
            allOf(contains('2 function(s)'), contains('1 event(s)')),
          ),
        },
      );
    },
  );

  test(
    'loadAbiItems rejects a non-array ABI JSON asset with a clear error',
    () async {
      final severeLogs = <String>[];
      await testBuilder(
        LibraryBuilder(_LoadAbiItemsProbeGenerator('lib/abi/bad.json')),
        {
          'a|lib/bad.dart': 'part "bad.g.dart";',
          'a|lib/abi/bad.json': '{"not": "an array"}',
        },
        outputs: {},
        onLog: (log) {
          if (log.level == Level.SEVERE) severeLogs.add(log.message);
        },
      );
      expect(
        severeLogs,
        contains(
          contains('ABI JSON at `lib/abi/bad.json` must be a JSON array'),
        ),
      );
    },
  );
}
