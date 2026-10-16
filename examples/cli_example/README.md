# cli_example

A pure-Dart CLI demoing [`viem_dart`](../../packages/viem_dart) over a plain HTTP
transport: reading a balance (`getBalance`), a raw contract read (`call`), a
batched read via Multicall3 (`multicall`), a
[`viem_dart_builders`](../../packages/viem_dart_builders)-generated typed
contract (`lib/weth.dart`/`lib/weth.g.dart` — read methods + typed
`Transfer` events), and polling for new blocks (`watchBlocks`).

## Run

```sh
dart run bin/cli_example.dart
```

Defaults to `mainnet.rpcUrls.first` (a public Cloudflare endpoint, which can be
rate-limited or intermittently unavailable). Pass your own RPC URL as the
first argument to use a different one:

```sh
dart run bin/cli_example.dart https://ethereum-rpc.publicnode.com
```
