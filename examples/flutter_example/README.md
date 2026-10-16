# flutter_example

A plain Flutter (Material) app demoing
[`viem_dart`](../../packages/viem_dart) (a `path:` dependency) across mobile,
desktop, and web+wasm.

- `lib/balance_screen.dart` reads a live ETH balance with viem_dart's
  `PublicClient.getBalance` over a plain HTTP transport, with loading, success
  and error states. The screen takes an optional `PublicClient`, which the
  tests use to run it against a fake transport.
- `lib/main.dart` is a Material app with two tabs (a welcome page and the
  balance lookup).
- No state-management, routing or DI packages: just `setState`.

Not a melos workspace member (unlike `examples/cli_example`): the Flutter
SDK's pinned `test_api` version conflicts with `viem_dart`'s own `test`
dev-dependency under a single pub workspace resolution, so this app resolves
independently via a `path:` dependency instead.

## Run

```sh
flutter pub get
flutter run                  # or: flutter run -d chrome / macos / ...
```

## Test

```sh
flutter analyze
flutter test
```

## Build

```sh
flutter build web --wasm
flutter build macos   # or apk / ios / linux / windows
```
