# jaspr_example

A [Jaspr](https://jaspr.site) client app demoing
[`viem_dart`](../../packages/viem_dart) (a `path:` dependency): a
`BalanceLookup` component (`lib/components/balance_lookup.dart`) that reads a
live ETH balance via `Client.getBalance` over a plain `HttpTransport` —
proving viem_dart runs correctly once compiled to JS/Wasm and executed in
the browser, with zero reachable `dart:io`.

Not a melos workspace member (like `examples/flutter_example`):
`jaspr_builder`'s pinned `analyzer` version conflicts with `viem_dart`'s own
`build_runner` dev-dependency under a single pub workspace resolution, so
this app resolves independently.

## Run

```sh
dart pub get
jaspr serve   # http://localhost:8080
```

## Build

```sh
jaspr build                    # JS
jaspr build --experimental-wasm   # Wasm
```

`jaspr build`/`jaspr serve` need a real (non-Flutter-bundled) Dart SDK on
`PATH` to find their build daemon — if `which dart` resolves into a Flutter
installation, `jaspr_cli` may fail SDK verification. To directly verify the
compile-proof this example exists for (no `jaspr_cli` needed):

```sh
dart compile js lib/main.client.dart -o build/main.js
dart compile wasm lib/main.client.dart -o build/main.wasm
```
