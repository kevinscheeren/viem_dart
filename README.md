# viem_dart

A from-scratch, pure-Dart port of [viem](https://viem.sh) — a composable
transport/chain/account/client model for interacting with EVM chains.
Usable identically from a Dart server/CLI, Flutter (mobile/desktop/web), and
[Jaspr](https://docs.jaspr.site) (web/wasm).

This repository belongs to the developer organisation wearenotabank. It is not a bank: nothing here takes deposits, grants credit or holds anyone else's funds.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for the branching and commit workflow.

## Status

Pre-1.0 and under active development: the current version is `0.1.0`, and
`viem_dart` is not yet published to pub.dev. Expect API changes before `1.0.0`. The public surface follows viem's, so
[viem's documentation](https://viem.sh) is the best reference for how an
action or utility is meant to behave.

## Source of truth

**This GitHub repository is the source of truth** for the code, issues and
releases. Report bugs and request features in the
[issue tracker](https://github.com/wearenotabank/viem_dart/issues); see
[CONTRIBUTING.md](./CONTRIBUTING.md) for how branches and pull requests work.

## Security

Report a suspected vulnerability privately, never in a public issue: see
[SECURITY.md](./SECURITY.md) for the reporting route (GitHub private vulnerability
reporting), the supported versions and the good-faith testing terms, and the [vulnerability policy](./docs/vulnerability-policy.md)
for what happens next.

## Examples

The in-repo [examples](./examples) (a pure-Dart CLI, a Flutter app and a
Jaspr web app) exercise the library on every platform it targets.

## Package layout

A single pub package (`packages/viem_dart`) with multiple `lib/` entrypoints,
mirroring viem's own npm subpath-export model rather than splitting into many
pub packages:

| Dart import | viem equivalent | Covers |
|---|---|---|
| `package:viem_dart/viem_dart.dart` | `viem` | Transport, Chain, Client, `createPublicClient`/`createWalletClient` |
| `package:viem_dart/accounts.dart` | `viem/accounts` | `privateKeyToAccount`, `mnemonicToAccount`, `hdKeyToAccount` |
| `package:viem_dart/chains.dart` | `viem/chains` | Built-in chain definitions |
| `package:viem_dart/abi.dart` | (viem's ABI/`abitype` surface) | ABI encode/decode, `parseAbi`, function/event codecs |
| `package:viem_dart/utils.dart` | `viem/utils` | hex/bytes, keccak256, RLP, unit conversion, address checksums |
| `package:viem_dart/actions.dart` | `viem/actions` | Bare action functions (client + args) |
| `package:viem_dart/ens.dart` | (viem's ENS actions) | `namehash`, `normalize`, ENS resolution |
| `package:viem_dart/test_actions.dart` | (viem's test actions) | Anvil test-client actions |

`packages/viem_dart_test_harness` is an internal, unpublished package that
spawns/manages a local `anvil` process for integration tests.

## Development

```sh
dart pub global activate melos
melos bootstrap
melos run check       # format:check + analyze + test:dart — the CI gate
melos run build_runner  # regenerate freezed/json_serializable codegen
```

Enable git hooks once per clone: `git config core.hooksPath .githooks`.

## Design notes

- **Codegen-first**: data models (`Chain`, `Block`, `Transaction`, `AbiItem`,
  ...) are `freezed` classes; JSON-RPC (de)serialization uses
  `json_serializable` with custom converters for hex-encoded quantities.
- **Cross-platform**: transports use `package:http` and
  `package:web_socket_channel` (not `dart:io` directly) so the same code runs
  server-side, in Flutter, and compiled to JS/Wasm in Jaspr.
