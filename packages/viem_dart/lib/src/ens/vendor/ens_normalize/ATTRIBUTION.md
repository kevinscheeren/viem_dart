# Vendored: ens_normalize

**Source:** https://github.com/vaariance/ens-dart (package `ens_normalize`,
pub.dev version 1.0.4, itself credited there to
[namehash/ens-normalize-python](https://github.com/namehash/ens-normalize-python)
and [adraffy/ens-normalize.js](https://github.com/adraffy/ens-normalize.js)).

**License:** BSD-3-Clause — see `LICENSE` in this directory (copied
verbatim from the upstream package).

## Why vendored instead of a normal dependency

`ens_normalize`'s core library (`ens_normalize_base.dart`) has an
unconditional `import 'dart:io'` (and `dart:isolate`), used by an
alternate, unused code path that reads a `spec.json.gz` file from
`Directory.current.path`. An unconditional `dart:io` import anywhere in a
library's dependency graph is a **hard compile failure** for web/wasm
targets (Flutter web, Jaspr) — not a runtime issue — which breaks
viem_dart's core cross-platform requirement.

The actual normalization logic viem_dart uses is pure Dart: the
synchronous `ENSNormalize()` factory parses normalization data from a
~10MB base64-encoded constant embedded directly in `spec.dart` (no file
I/O at all). Only the dead alternate path touched `dart:io`.

## What was changed

- `ens_normalize_base.dart`: removed the `dart:io`/`dart:isolate`
  imports, `specJsonZippedPath`, `_isolateEntry`,
  `_loadNormalizationDataJson`, and `ENSNormalize`'s async
  `getInstance()`/`_initialize()` methods. Updated stale doc-comment
  examples that referenced the removed `getInstance()` to use the
  synchronous `ENSNormalize()` constructor instead.
- `ens_normalize_base.dart` (lint only): wrapped `List<Token>` in
  backticks in one doc comment and typed the two `dynamic` helper
  parameters (`_tryIntToStr`, `_tryStrToInt`), so pana's static analysis
  (`lints/core`) reports nothing on the package. No behaviour change.
- `normalization.dart`: removed the `NORMALIZATION.fromSpecJsonPath`
  factory (the only consumer of `dart:io`'s `File`) and its import.
  Also changed `class NORMALIZATION with _$NORMALIZATION` to `abstract
  class NORMALIZATION with _$NORMALIZATION` — upstream targeted
  freezed 2.x's concrete-mixin codegen shape; freezed 3.0+ (viem_dart's
  pinned version) generates an interface mixin instead, which requires
  the annotated class itself to be abstract.
- `spec.dart`: copied verbatim, unchanged.
- `normalization.freezed.dart`, `normalization.g.dart`: **not** vendored
  from upstream — generated fresh by viem_dart's own `build_runner`
  (`melos run build_runner`) from the vendored `normalization.dart`,
  guaranteeing they match viem_dart's pinned freezed/json_serializable
  versions exactly. Regenerate them the same way after any future change
  to `normalization.dart`.

## Bugs found and fixed

Verifying against the official ENSIP-15 conformance suite (37,484 cases,
see `test/fixtures/ensip15/`) surfaced three pre-existing correctness
bugs in the upstream package's `ENSNormalize()` → `.normalize()` path —
none introduced by the strip above. Each has a comment at its fix site
in `ens_normalize_base.dart`:

1. **`_postCheckWhole`**: `set_.toList()` on a `dynamic`-sourced value
   reified as `List<dynamic>` at runtime, failing the implicit downcast
   to `List<int>?` — throwing on whole-script-confusable checks for
   most non-Latin scripts. Fixed with an explicit `List<int>.from`.
2. **`tokens2str`**: defaulted to `""` instead of the emoji's own
   codepoints when no `emojiFn` was given — silently dropping every
   emoji from `normalize()`'s output. The reference Python port's
   default is `cps2str(tok.cps)`, never empty.
3. **Main tokenizer loop**: read one UTF-16 code unit and advanced by 1,
   a direct (but semantically wrong) transliteration of the Python
   reference's `input[input_cur]` — correct in Python (`str` is
   codepoint-indexed) but not in Dart (`String` is UTF-16-code-unit
   indexed), silently splitting every supplementary-plane character
   (math alphanumerics, Egyptian hieroglyphs, Cuneiform, some emoji)
   into two lone, invalid surrogate "codepoints." Fixed by decoding the
   full codepoint, consuming a trailing low surrogate when present.

Net effect: 22,977/37,484 (61.3%) → 37,483/37,484 (99.997%) conformance.
The one remaining gap is tracked in
`test/fixtures/ensip15/ATTRIBUTION.md`.

## Maintenance

This is a point-in-time snapshot (pub.dev `ens_normalize` 1.0.4). ENS
normalization rules (ENSIP-15) change infrequently, but if upstream
publishes a spec update, re-vendor by re-running the same strip
described above against the new source — or revisit whether a
cross-platform-safe upstream dependency has since become available.
