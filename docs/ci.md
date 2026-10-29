# CI/CD

## Workflows

GitHub Actions, in `.github/workflows/`, on GitHub-hosted `ubuntu-latest` runners. No workflow uses a secret. Every workflow has top-level `permissions: contents: read`, and every action is pinned by commit SHA (with the release tag in a trailing comment); `dependabot.yml` keeps them current.

- **`ci.yml`** — runs on every PR and on push to `development` and `production`:
  - `check` — `melos bootstrap && melos run check` (docs guard, dependency licence gate, format, analyze, unit tests). The docs guard (`tool/check_security_docs.sh`) fails if `SECURITY.md` or `docs/vulnerability-policy.md` drop the reporting terms (72-hour acknowledgement, consent-based credit, no bounty), name an e-mail address, or stop naming GitHub private vulnerability reporting.
  - `secrets-scan` — `tool/secrets_scan.sh`: gitleaks (pinned v8.30.1, sha256-verified by `tool/install_gitleaks.sh`) with `.gitleaks.toml` over the history reachable from HEAD (merge commits included) and the committed tree, then `tool/secrets_scan_probe.sh`, which proves the scan fails a planted 64-hex key, a key deleted from the tree but still in history, a BIP-39 mnemonic and an RPC URL with a key in it, and that a key on a side branch outside HEAD's ancestry passes. Checks out with `fetch-depth: 0`; a shallow clone is refused.
  - `release-artifacts` — `melos run release:artifacts`: the CycloneDX SBOM and the third-party licence bundle of `packages/viem_dart`'s runtime closure, with the SBOM validated against the CycloneDX 1.6 schema (`tool/validate_sbom.sh`). See `docs/release.md`.
  - `pub-score` — runs `dart pub publish --dry-run` and `pana --exit-code-threshold 0` on `packages/viem_dart`, so it fails if any pana point is lost. Nothing publishes.
  - `flutter-build-proof` — two guards against `dart:io` (or other web-incompatible code) leaking into a web-reachable path: an always-on `dart compile js`/`dart compile wasm` smoke check against `packages/viem_dart`'s own public API surface (`tool/web_compile_probe.dart`), plus `flutter analyze`/`flutter test`/`flutter build web --wasm` for `examples/flutter_example` (a standalone Flutter app, path-dependent on `viem_dart` — not a melos workspace member, since its Flutter-SDK-pinned `test_api` version conflicts with `viem_dart`'s own `test` dev-dependency under a single workspace resolution).
  - `jaspr-build-proof` — `dart analyze` plus `dart compile js`/`dart compile wasm` directly against `examples/jaspr_example`'s client entrypoint (`lib/main.client.dart`), the same style of direct compile-proof as `flutter-build-proof`'s viem_dart smoke check. Also a standalone app (path dep, not a workspace member) — `jaspr_builder`'s pinned `analyzer` version conflicts with `viem_dart`'s `build_runner` dev-dependency under a single workspace resolution. Doesn't use `jaspr build`/`jaspr_cli` itself, which needs a real (non-Flutter-bundled) Dart SDK on `PATH` to find its build daemon.
  - `anvil-integration` — installs Foundry (`foundry-rs/foundry-toolchain`, Foundry `v1.8.4`), runs `melos run test:integration` (real anvil-backed integration tests) with `BASE_FORK_URL=https://mainnet.base.org`: the Safe tests fork Base at one pinned block (`packages/viem_dart/test/integration/fixtures/safe/base_fork.dart`) against a keyless public endpoint, so no LGPL Safe/CoW code is kept in the repository.
- **`release.yml`** — manual (`workflow_dispatch`, run on `production`): creates the tag `<package>-v<X.Y.Z>` on the merged release commit, after checking that the package's `pubspec.yaml` and `CHANGELOG.md` on `production` carry that version and that the tag does not exist yet. It never versions, never runs on a push and publishes nothing to pub.dev. It is the only workflow that writes: its `tag` job asks for `contents: write` for itself, the one place a tag is made. Guarded to `wearenotabank/viem_dart`. See `docs/release.md`, "Cutting a release".
- **`dependabot.yml`** — weekly grouped updates for the `pub` and `github-actions` ecosystems.

## Branch protection (manual, not file-configurable)

Set in the repository's Settings → Branches, for both `production` and `development`:

- Require a pull request before merging.
- Require the `Unit tests, lint, format` (job `check`) and `Anvil integration tests` (job `anvil-integration`) status checks from `ci.yml` to pass before merging.
- Require branches to be up to date before merging.

This isn't automatable via a committed file — apply it once per repo in the UI.

## Dependency licence gate

`melos run check:licences` (part of `melos run check`) runs `packages/viem_dart_tooling/bin/licence_check.dart`. It reads the licence file of every hosted package in the workspace's `pubspec.lock` from the pub cache, classifies the text against the allow/deny policy (`lib/src/licence_policy.dart`), and fails on a denied licence (GPL, LGPL, AGPL, SSPL, BUSL, MPL-2.0) or on a text it cannot classify. It reads the licence text itself rather than a registry's metadata field, which can diverge from the text. The unit tests plant a GPL probe package and assert the gate fails (the deliberate break).

It covers the packages of the one workspace resolution. `examples/flutter_example` and `examples/jaspr_example` resolve on their own, are never published, and are not covered.

## Secrets scan

`.gitleaks.toml` keeps gitleaks' default rules and adds the Ethereum-specific shapes they do not know: a 64-hex-character string (the shape of a private key), a BIP-39 mnemonic and an RPC URL with the key inside it. Every file that legitimately holds a 64-hex value (a hash, a typehash, a test vector) is an allowlist entry with its reason. An entry names exact files or one exact public value, never a directory or a glob, so a private-key-shaped string anywhere else still fails. To allow a new public value, add an entry with its reason and have it reviewed; do not widen an existing one. `gitleaks:allow` comments are ignored on purpose.

Run it locally with `melos run secrets:scan` (and `melos run secrets:probe` for the deliberate break).
