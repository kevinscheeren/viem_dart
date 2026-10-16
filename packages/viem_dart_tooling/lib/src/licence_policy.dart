/// The dependency licence policy for this Dart workspace: which SPDX
/// identifiers may be depended on, which never may, and how a licence file's
/// text is mapped to identifiers.
///
/// The text is classified from the licence file itself, never from a
/// registry's metadata field: declared metadata can diverge from the actual
/// licence text. A text that matches no known signature is **unclassified**
/// and fails the gate, so a new or unusual licence is a conscious decision
/// rather than a silent pass.
library;

/// Licences a dependency may carry.
const Set<String> allowedLicences = {
  'MIT',
  'Apache-2.0',
  'BSD-2-Clause',
  'BSD-3-Clause',
  'Unicode-3.0',
  'Unlicense',
  'CC0-1.0',
  'Zlib',
  'ISC',
  'PSF-2.0',
  'BlueOak-1.0.0',
  'MIT-0',
  '0BSD',
};

/// Licences that are refused outright. MPL-2.0 is denied by default: its
/// file-level share-alike obligation must be a conscious per-dependency
/// decision, not a default pass.
const Set<String> deniedLicences = {
  'GPL',
  'LGPL',
  'AGPL',
  'SSPL',
  'BUSL',
  'MPL-2.0',
};

/// How one package fared against the policy.
enum LicenceVerdict {
  /// Every licence found is on the allow list.
  allowed,

  /// A denied licence is present.
  denied,

  /// No licence file, or a text that matches no known signature.
  unclassified,
}

/// A licence signature: [id] applies when every [all] fragment appears in the
/// (whitespace-collapsed, lower-cased) text and no [none] fragment does.
class _Signature {
  const _Signature(this.id, this.all, [this.none = const []]);

  final String id;
  final List<String> all;
  final List<String> none;

  bool matches(String text) =>
      all.every(text.contains) && !none.any(text.contains);
}

const List<_Signature> _signatures = [
  // Denied: checked by name so a dual or bundled text is never read as clean.
  _Signature('AGPL', ['gnu affero general public license']),
  _Signature('LGPL', ['gnu lesser general public license']),
  _Signature('LGPL', ['gnu library general public license']),
  _Signature('GPL', ['gnu general public license']),
  _Signature('SSPL', ['server side public license']),
  _Signature('BUSL', ['business source license']),
  _Signature('MPL-2.0', ['mozilla public license']),
  // Allowed.
  _Signature('MIT', [
    'permission is hereby granted, free of charge, to any person obtaining a copy',
    'the above copyright notice and this permission notice shall be included',
  ]),
  _Signature(
    'MIT-0',
    [
      'permission is hereby granted, free of charge, to any person obtaining a copy',
    ],
    ['the above copyright notice and this permission notice shall be included'],
  ),
  _Signature('Apache-2.0', ['apache license', 'version 2.0, january 2004']),
  _Signature('BSD-3-Clause', [
    'redistributions of source code must retain',
    'redistributions in binary form must reproduce',
    'neither the name',
  ]),
  _Signature(
    'BSD-2-Clause',
    [
      'redistributions of source code must retain',
      'redistributions in binary form must reproduce',
    ],
    ['neither the name', 'endorse or promote'],
  ),
  _Signature('ISC', [
    'permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies',
  ]),
  _Signature(
    '0BSD',
    [
      'permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.',
    ],
    ['provided that the above copyright notice'],
  ),
  _Signature('Unlicense', [
    'this is free and unencumbered software released into the public domain',
  ]),
  _Signature('CC0-1.0', ['cc0 1.0 universal']),
  _Signature('Zlib', [
    'altered source versions must be plainly marked as such',
  ]),
  _Signature('BlueOak-1.0.0', ['blue oak model license']),
  _Signature('Unicode-3.0', ['unicode license v3']),
  _Signature('PSF-2.0', ['python software foundation license version 2']),
];

/// The SPDX identifiers (or deny-list families such as `GPL`) found in a
/// licence file's [text]; empty when nothing is recognised.
Set<String> classifyLicenceText(String text) {
  final normalised = text.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  return {
    for (final signature in _signatures)
      if (signature.matches(normalised)) signature.id,
  };
}

/// The verdict for a package whose licence file(s) yielded [found].
LicenceVerdict verdictFor(Set<String> found) {
  if (found.isEmpty) return LicenceVerdict.unclassified;
  if (found.any(deniedLicences.contains)) return LicenceVerdict.denied;
  if (found.every(allowedLicences.contains)) return LicenceVerdict.allowed;
  return LicenceVerdict.unclassified;
}
