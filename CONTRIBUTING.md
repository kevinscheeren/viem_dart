# Contributing

Thank you for helping with `viem_dart`. This page is the short version of how changes get in.

## Before you start

- Open an issue first for anything beyond a small fix, so the approach can be agreed before you
  write code.
- Report a suspected vulnerability privately, never in an issue: see [SECURITY.md](SECURITY.md).

## Setup

```sh
dart pub global activate melos
melos bootstrap
git config core.hooksPath .githooks   # once per clone
melos run check                       # the gate CI runs: docs guard, licences, format, analyze, unit tests
```

The anvil-backed integration tests (`melos run test:integration`) need
[Foundry](https://book.getfoundry.sh/) on `PATH`; the Safe tests also need `BASE_FORK_URL` to point at
a keyless Base endpoint (see `packages/viem_dart/test/integration/fixtures/safe/README.md`).

## Branches

Two long-lived branches, both merge-only (nothing is pushed to them directly):

- **`production`**: always releasable. Only a release or a hotfix merges here, by pull request. A
  release is tagged on it (`<package>-v<x.y.z>`), never anywhere else.
- **`development`**: the integration branch for the next release, and the repository's default
  branch. Working branches merge here first.

| Branch | Off | Merges into | For |
|---|---|---|---|
| `feature/<N>-<slug>` | `development` | `development` | New functionality, tests |
| `bugfix/<N>-<slug>` | `development` | `development` | Non-urgent fix |
| `chore/<N>-<slug>` | `development` | `development` | Maintenance, build, tooling, CI |
| `documentation/<N>-<slug>` | `development` | `development` | Documentation only |
| `release/<pkg>-vX.Y.Z` | `development` | `production`, then back into `development` | Version, changelog, security gate |
| `hotfix/<N>-<slug>` | `production` | `production` **and** `development` | Urgent fix of a released version |

`<N>` is the issue number. Keep one pull request to one issue, and reference the issue in the
description. Merge with a merge commit.

## Commits

**Conventional Commits** are enforced by `.githooks/commit-msg` and drive semver and changelogs via
`melos version`:

```
<type>[optional (scope)][!]: <description>
# types: feat fix docs style refactor perf test build ci chore revert security
# e.g.   feat(abi): add human-readable ABI parser
```

The `pre-commit` hook runs `melos run format:check` and `melos run analyze`; the full
`melos run check` runs in CI.

## Code and tests

- Follow the existing style; `dart format` and `dart analyze --fatal-infos` must be clean.
- A change in behaviour comes with a test that fails without it.
- Keep generated files (`*.g.dart`, `*.freezed.dart`) committed and regenerate them with
  `melos run build_runner`.
- No Safe, Zodiac, ComposableCoW or Aave source (LGPL, GPL or BUSL) is vendored: call deployed
  contracts through their addresses and the repository's own helper contracts.
- New dependencies must pass `melos run check:licences`.

## Releases

See [docs/release.md](docs/release.md).
