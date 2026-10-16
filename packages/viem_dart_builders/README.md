# viem_dart_builders

A `build_runner` code generator for [`viem_dart`](../viem_dart): turns a
`@GenerateAbi`-annotated `part` directive plus an ABI JSON file into
compile-time-typed `<Name>Contract`/`<Name>WalletContract` classes — typed
read/write methods, typed events, and `freezed`-equivalent data classes for
Solidity tuples/structs — instead of the runtime, string-keyed
`Contract`/`getContract()` API `viem_dart` itself also provides for ABIs
only known at runtime (e.g. fetched from a block explorer).

See `examples/cli_example/lib/weth.dart`/`weth.g.dart` for a real, working,
committed example (calls a generated `WethContract` live against Ethereum
mainnet from `bin/cli_example.dart`).

## Install

Codegen tooling only runs at dev time, so this is a `dev_dependency`, same
as `build_runner` itself:

```sh
dart pub add --dev viem_dart_builders build_runner
```

## Usage

Annotate a `part` directive with `@GenerateAbi`, pointing at an ABI JSON
file (a plain JSON array of ABI item objects — the same shape a block
explorer's "Contract ABI" export already is):

```dart
// lib/erc20.dart
import 'package:viem_dart/abi.dart';       // AbiFunction/AbiParameter/AbiEvent
import 'package:viem_dart/codegen.dart';   // GenerateAbi itself
import 'package:viem_dart/viem_dart.dart'; // PublicClient/WalletClient

@GenerateAbi('lib/abi/erc20.json')
part 'erc20.g.dart';
```

**Import all three shown above, even though nothing in this file directly
uses them.** The generated `part` file has no imports of its own — Dart
parts share whatever their `part of` library already imports — and the
generated code references `PublicClient`/`WalletClient` and
`AbiFunction`/`AbiParameter`/`AbiEvent` unconditionally. If any field in
the ABI is `bytes`/`bytesN`, also add `import 'dart:typed_data';` for
`Uint8List`. Getting an import wrong produces real compile errors in the
generated `.g.dart` — not a silent gap — so it's easy to notice and fix.

**Keep the ABI JSON path under `lib/`.** `build_runner` only tracks
`lib/**` (plus `bin/`/`web/`/`test/`) as buildable sources by default; a
package-root `abi/` folder is invisible to the builder unless you add your
own `build.yaml` `sources:` entry for it. `lib/abi/erc20.json` just works.

Then run codegen the same way as any other `build_runner`-based generator
(`freezed`, `json_serializable`, ...):

```sh
dart run build_runner build --delete-conflicting-outputs
```

(In a melos monorepo like this one: `melos run build_runner`.)

## What gets generated

- **`<Name>Contract`** — `{required PublicClient client, required String
  address}`, plus one typed method per `view`/`pure` ABI function. A
  single-output function returns that output's mapped Dart type directly;
  a multi-output function returns a named-field Dart record
  (`Future<({BigInt reserve0, BigInt reserve1})>`) — no generated class
  needed for a shape that's only ever used by that one function.
- **`<Name>WalletContract extends <Name>Contract`** — `{required
  WalletClient client, required String address}`, plus one typed method
  per `payable`/`nonpayable` function, returning `Future<String>` (the
  submitted transaction's hash). Only generated if the ABI actually has
  any state-changing functions — an ABI with none has no use for a
  wallet-typed class. Mirrors `viem_dart`'s own runtime
  `Contract`/`WalletContract` split (`getContract()`/`getWalletContract()`)
  so generated bindings stay consistent with the library's nominal client
  typing: a class holding only a `PublicClient` never exposes write
  methods.
- **`get<Event>Events`/`watch<Event>Event`** (on `<Name>Contract`, one
  pair per ABI event) — past-log fetch and live-log subscription,
  returning/emitting a typed `<Event>Event` data class instead of
  `getContractEvents`'/`watchContractEvent`'s untyped `Map<String,
  Object?>`. Filter parameters only exist for a log's own *indexed*
  fields — only those become topics `eth_getLogs`/`eth_newFilter` can
  filter on. An indexed field whose Solidity type is dynamic
  (`string`/`bytes`/any array/tuple) is typed `String` on the returned
  event class, not its "real" mapped type: `viem_dart`'s own log decoder
  can only recover that field's `keccak256` topic hash from a log, never
  the original value — a fundamental EVM limitation, not something this
  generator can work around.
- **Tuple/struct data classes** — every unique `tuple` shape in the ABI
  (deduped structurally, so two fields with the same shape share one
  class) gets its own generated immutable data class: `const` constructor,
  `copyWith`, value `==`/`hashCode`, `toString` — the same public surface
  `freezed` would give it, hand-rolled directly rather than through a
  second `@freezed`-annotated `build_runner` pass (which would mean this
  builder generating input for *another* builder, the exact thing
  `SharedPartBuilder`/`combining_builder` exist to let generators avoid).

## Tests

`test/integration/generated_contract_anvil_test.dart` (`melos run
test:integration`, needs Foundry's `anvil`) runs the real generator on the
ABI of the `Probe` contract (`test/integration/fixtures/probe_artifact.json`,
regenerated by `fixtures/build_probe_artifact.sh` from
`packages/viem_dart/test/integration/fixtures/CapabilityProbes.sol`) and runs
the generated typed read, write, event getter and revert against anvil, so a
generator that emits a wrong selector or type fails a test.

## Naming

Overloaded Solidity function/event names, unnamed parameters, and unnamed
multi-value outputs are all disambiguated into unique, valid camelCase Dart
identifiers automatically (`foo`, `foo2`, `foo3`, ... for a name collision;
`arg0`/`output0` for a missing ABI name). The generated class's own base
name is `GenerateAbi.className` if given, otherwise the PascalCase of the
ABI JSON file's name (`lib/abi/erc20.json` -> `Erc20`).
