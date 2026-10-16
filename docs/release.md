# Releasing

What a `viem_dart` release needs besides the code, how each part is produced and checked, and the steps to cut one.

## Release artifacts

Two files per release, generated from the resolved runtime closure of `packages/viem_dart` (its `dependencies:` and what they pull in; dev tooling is not in them):

```sh
melos bootstrap
melos run release:artifacts   # sbom + licence-bundle + schema validation
melos run sbom                # build/release/sbom.cdx.json
melos run licence-bundle      # build/release/THIRD_PARTY_LICENSES
```

- **`sbom.cdx.json`**: a CycloneDX 1.6 SBOM. The root is `viem_dart`; every runtime package is a component with its `pkg:pub` purl, its SPDX licence id (classified from the licence text, the same classifier as the licence gate), its pub.dev archive SHA-256 from `pubspec.lock`, and its dependency edges. The vendored `ens_normalize` is a component of its own. The generator refuses a package whose licence is denied or unrecognised.
- **`THIRD_PARTY_LICENSES`**: `THIRD_PARTY_NOTICES.md` (viem, the vendored `ens_normalize`, the ENSIP-15 suite) followed by each runtime package's licence text, verbatim. It fails if any package has no licence file.
- `tool/validate_sbom.sh` validates the SBOM against CycloneDX's official 1.6 JSON Schema (pinned commit, sha256-verified, pinned `jsonschema` in a throwaway venv; needs python3 and network).

CI (`release-artifacts` job) generates and validates both on every PR. `build/release/` is git-ignored: the files are attached to a release, never committed.

## pub.dev checks

```sh
cd packages/viem_dart
dart pub publish --dry-run   # must report 0 warnings
dart pub global activate pana
pana .                       # all points
```

CI (`pub-score` job) runs the dry run and `pana --exit-code-threshold 0`, so it fails the moment any point is lost. Nothing in CI publishes. For `0.1.0` the dry run had no warnings and `pana` scored 160 / 160 (conventions, documentation, platform, static analysis and dependencies); the archive leaves out `test/integration/` (the anvil-backed tests need Foundry and a Base fork) and the vendored ENSIP-15 suite, see `packages/viem_dart/.pubignore`.

`packages/viem_dart_builders` is `publish_to: none`: it is the `build_runner` generator behind `@GenerateAbi`. A project that wants it as a hosted dev dependency needs it published too, or commits the generated code as `examples/cli_example` does.

## Versioning

The package is pre-1.0: a minor version may break the API (`0.2.0` after `0.1.0`), a patch version does not. `1.0.0` is a promise of semver stability for every public symbol (about 700 chain definitions, the full transaction matrix, ENS, test actions), so it waits until the surface listed in `docs/viem-mapping.md` has been used by downstream projects on a `0.1.x` release without needing a breaking change.

## Cutting a release

Nothing versions or tags on a push. The steps, in order:

1. **Cut the branch** from `development`: `release/viem_dart-vX.Y.Z`.
2. **Version it there**, by hand, without tagging or committing:

   ```sh
   melos version viem_dart X.Y.Z --no-git-tag-version --no-git-commit-version --yes
   ```

   This bumps `pubspec.yaml` (and the workspace packages that depend on it), and writes a generated section into both `CHANGELOG.md` files from the commit subjects. Then, by hand:
   - Reconcile the generated `## X.Y.Z` section with the hand-written "Unreleased" notes, so entries are not doubled, and leave an empty "Unreleased" above it.
   - Set `viemDartVersion` in `packages/viem_dart/lib/viem_dart.dart` to the same version (`melos version` does not touch it; `test/viem_dart_test.dart` fails if the two differ).
   - Commit (`chore(release): ...`) and run `melos run check`.
3. **Open the release pull request** into `production`. Its body records the security pass (dependency audit, new `unsafe`/foreign-function surface, secrets scan, supply-chain diff since the last release) and a verdict; the maintainer approves it before the merge. Merge with a merge commit.
4. **Tag on `production`**: run the `Release` workflow (Actions, "Run workflow", branch `production`) with the package and `X.Y.Z`. It checks that `production` carries that version and changelog entry, then creates the tag `viem_dart-vX.Y.Z`. Only this workflow creates tags.
5. **Back-merge** `production` into `development` (a pull request).

A bug found while gating is fixed on the release branch if small; if it is structural, delete the release branch, fix on `development` and re-cut. A `hotfix/*` branch (from `production`, with a patch bump) merges into `production` and `development` and is tagged the same way. Publishing to pub.dev is a separate, manual step that is not part of this flow.
