import 'vendor/ens_normalize/ens_normalize_base.dart';

/// The [ENSNormalize] instance backing [normalize], created once and
/// reused — its constructor decodes/parses a ~10MB embedded spec table,
/// far too expensive to redo on every call.
final ENSNormalize _ensNormalize = ENSNormalize();

/// Normalizes [name] per ENSIP-15, via a vendored, `dart:io`-free port of
/// the `ens_normalize` package (see
/// `src/ens/vendor/ens_normalize/ATTRIBUTION.md`, which also documents
/// three correctness bugs found and fixed there) — safe to call from
/// server-side Dart, Flutter, and web/Jaspr alike. Verified against the
/// official ENSIP-15 conformance suite: 37,483/37,484 cases pass (see
/// `test/fixtures/ensip15/ATTRIBUTION.md` for the one known gap).
///
/// Throws [DisallowedSequence] if [name] contains a sequence ENS
/// normalization disallows outright (mixed scripts, invalid characters,
/// etc.) with no valid interpretation. Always normalize a name before
/// passing it to [namehash] or a resolver lookup — an unnormalized name
/// silently resolves to the wrong node.
String normalize(String name) => _ensNormalize.normalize(name);
