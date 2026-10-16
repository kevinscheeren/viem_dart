// Ported from viem's `isUri` (based on https://github.com/ogt/valid-url),
// itself an RFC 3986 conformance check — kept as close to viem's actual
// regexes as possible (including the `(:?...)` group in the second percent-
// escape check below, which reads like a typo for `(?:...)` in the
// upstream source but is reproduced verbatim for behavioral parity).

final RegExp _illegalCharsRegExp = RegExp(
  r"[^a-z0-9:/?#\[\]@!$&'()*+,;=.\-_~%]",
  caseSensitive: false,
);
final RegExp _incompleteHexEscapeRegExp = RegExp(
  r'%[^0-9a-f]',
  caseSensitive: false,
);
final RegExp _incompleteHexEscapeRegExp2 = RegExp(
  r'%[0-9a-f](:?[^0-9a-f]|$)',
  caseSensitive: false,
);
final RegExp _splitUriRegExp = RegExp(
  r'(?:([^:/?#]+):)?(?:\/\/([^/?#]*))?([^?#]*)(?:\?([^#]*))?(?:#(.*))?',
);
final RegExp _schemeRegExp = RegExp(r'^[a-z][a-z0-9+\-.]*$');

/// Checks whether [value] is a valid RFC 3986 URI — used to validate
/// [createSiweMessage]'s `uri`/`resources` fields per EIP-4361.
bool isUri(String value) {
  if (_illegalCharsRegExp.hasMatch(value)) return false;
  if (_incompleteHexEscapeRegExp.hasMatch(value)) return false;
  if (_incompleteHexEscapeRegExp2.hasMatch(value)) return false;

  final match = _splitUriRegExp.firstMatch(value);
  if (match == null) return false;
  final scheme = match.group(1);
  final authority = match.group(2);
  final path = match.group(3) ?? '';

  // Scheme and path are required, though the path can be empty.
  if (scheme == null || scheme.isEmpty) return false;

  // If authority is present, the path must be empty or begin with a `/`.
  // If authority is absent, the path must not start with `//`.
  if (authority != null && authority.isNotEmpty) {
    if (path.isNotEmpty && !path.startsWith('/')) return false;
  } else {
    if (path.startsWith('//')) return false;
  }

  // Scheme must begin with a letter, then consist of letters, digits, +,
  // ., or -.
  if (!_schemeRegExp.hasMatch(scheme.toLowerCase())) return false;

  return true;
}
