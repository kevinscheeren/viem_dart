# viem_dart

A from-scratch, pure-Dart port of [viem](https://viem.sh) — a composable
transport/chain/account/client model for interacting with EVM chains. Usable
identically from a Dart server/CLI, Flutter (mobile/desktop/web), and
[Jaspr](https://docs.jaspr.site) (web/wasm), with zero reachable `dart:io` on
web paths.

## Install

```sh
dart pub add viem_dart
```

## Quick start

Read a balance with a public client:

```dart
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/viem_dart.dart';

final client = createPublicClient(
  transport: HttpTransport(Uri.parse('https://ethereum-rpc.publicnode.com')),
  chain: mainnet,
);

final balance = await client.getBalance('0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045');
print(balance); // wei, as a BigInt
```

Sign and send a transaction with a wallet client:

```dart
import 'dart:typed_data';

import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/viem_dart.dart';

final account = privateKeyToAccount(Uint8List.fromList([/* ... */]));
final client = createWalletClient(
  transport: HttpTransport(Uri.parse('https://ethereum-rpc.publicnode.com')),
  chain: mainnet,
  account: account,
);

final hash = await client.sendTransaction(
  to: '0x...',
  value: parseEther('0.01'),
);
```

`createPublicClient`/`createWalletClient`/`createTestClient` all return a
plain `Client` — which actions are available depends on which subpath you
import (see below), the same role viem's runtime `.extend()` plays, done
here as Dart extension methods resolved statically at compile time.

## Package layout

Multiple `lib/` entrypoints on a single pub package, mirroring viem's own
npm subpath-export model:

| Dart import | viem equivalent | Covers |
|---|---|---|
| `package:viem_dart/viem_dart.dart` | `viem` | Transport, Chain, Client, `createPublicClient`/`createWalletClient`, public/wallet actions, transactions, errors |
| `package:viem_dart/accounts.dart` | `viem/accounts` | `privateKeyToAccount`, `mnemonicToAccount`, `hdKeyToAccount`, EIP-191/EIP-712 signing |
| `package:viem_dart/chains.dart` | `viem/chains` | Built-in chain definitions (mainnet, sepolia, base, arbitrum, optimism, polygon, bsc, avalanche, anvil) |
| `package:viem_dart/abi.dart` | (viem's ABI/`abitype` surface) | ABI encode/decode, `parseAbi`, function/event codecs, ABI-domain errors |
| `package:viem_dart/utils.dart` | `viem/utils` | hex/bytes, keccak256, RLP, unit conversion (`parseEther`/`formatUnits`), address checksums, secp256k1 |
| `package:viem_dart/actions.dart` | `viem/actions` | Public read actions (balance, block, gas, logs, multicall, `waitForTransactionReceipt`, `watch*` streams) |
| `package:viem_dart/ens.dart` | (viem's ENS actions) | `namehash`, `normalize`, Universal Resolver actions (`getEnsAddress`/`getEnsName`/`getEnsAvatar`/`getEnsText`) |
| `package:viem_dart/siwe.dart` | `viem/siwe` | `createSiweMessage`, `parseSiweMessage`, `validateSiweMessage`, `generateSiweNonce`, `verifySiweMessage` (EOA signatures, no node), `PublicClient.verifySiweMessage` (also contract accounts: ERC-1271, ERC-6492) |
| `package:viem_dart/test_actions.dart` | (viem's test actions) | `createTestClient` + anvil-only actions (`mine`, `setBalance`, `impersonateAccount`, snapshots, ...) |

## Examples

- [`examples/cli_example`](https://github.com/kevinscheeren/viem_dart/tree/production/examples/cli_example) — a pure-Dart CLI over HTTP (balance, `call`, `multicall`, `watchBlocks`)
- [`examples/flutter_example`](https://github.com/kevinscheeren/viem_dart/tree/production/examples/flutter_example) — a plain Flutter app (mobile/desktop/web+wasm)
- [`examples/jaspr_example`](https://github.com/kevinscheeren/viem_dart/tree/production/examples/jaspr_example) — a Jaspr client app proving JS/Wasm compile with zero reachable `dart:io`

## Design notes

- **Codegen-first**: data models (`Chain`, `Block`, `Transaction`, `AbiItem`,
  ...) are `freezed` classes; JSON-RPC (de)serialization uses
  `json_serializable` with custom converters for hex-encoded quantities.
- **Cross-platform**: transports use `package:http` and
  `package:web_socket_channel` (not `dart:io` directly) so the same code runs
  server-side, in Flutter, and compiled to JS/Wasm in Jaspr.
- **Typed errors**: domain-specific `ViemError` subclasses (ABI, RPC,
  transaction, account, ENS, contract-call) mirror viem's own error class
  names/messages, so callers can catch a specific failure mode.

See the full source and issue tracker at
[github.com/kevinscheeren/viem_dart](https://github.com/kevinscheeren/viem_dart).
