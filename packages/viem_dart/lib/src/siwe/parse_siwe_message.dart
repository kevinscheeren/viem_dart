import 'types.dart';

// https://regexr.com/80gdj (viem's own reference)
//
// Note: the `scheme`/`domain` groups' `[a-zA-Z0-9+-.]` character class has
// an un-escaped `-` between `+` and `.`, which regex engines (JS and Dart
// alike) parse as the range `+`-`.` (i.e. also matching `,`) rather than a
// literal hyphen — reproduced verbatim from viem's own source for parity
// rather than "fixed", since it has zero practical effect (real
// schemes/domains never contain `,`) but a `parseSiweMessage` port should
// match what it's actually parsing against.
final RegExp _prefixRegExp = RegExp(
  r'^(?:(?<scheme>[a-zA-Z][a-zA-Z0-9+-.]*):\/\/)?'
  r'(?<domain>[a-zA-Z0-9+-.]*(?::[0-9]{1,5})?) '
  r'(?:wants you to sign in with your Ethereum account:\n)'
  r'(?<address>0x[a-fA-F0-9]{40})\n\n'
  r'(?:(?<statement>.*)\n\n)?',
);

// https://regexr.com/80gf9 (viem's own reference)
final RegExp _suffixRegExp = RegExp(
  r'(?:URI: (?<uri>.+))\n'
  r'(?:Version: (?<version>.+))\n'
  r'(?:Chain ID: (?<chainId>\d+))\n'
  r'(?:Nonce: (?<nonce>[a-zA-Z0-9]+))\n'
  r'(?:Issued At: (?<issuedAt>.+))'
  r'(?:\nExpiration Time: (?<expirationTime>.+))?'
  r'(?:\nNot Before: (?<notBefore>.+))?'
  r'(?:\nRequest ID: (?<requestId>.+))?',
);

/// Parses an EIP-4361 formatted message into its component fields —
/// lenient by design (unlike [createSiweMessage]): extracts whatever it
/// can via regex, leaving anything it can't find as `null` on the
/// returned [SiweMessage] rather than throwing.
///
/// See https://eips.ethereum.org/EIPS/eip-4361
SiweMessage parseSiweMessage(String message) {
  final prefixMatch = _prefixRegExp.firstMatch(message);
  final suffixMatch = _suffixRegExp.firstMatch(message);

  final chainIdText = suffixMatch?.namedGroup('chainId');
  final issuedAtText = suffixMatch?.namedGroup('issuedAt');
  final expirationTimeText = suffixMatch?.namedGroup('expirationTime');
  final notBeforeText = suffixMatch?.namedGroup('notBefore');

  List<String>? resources;
  final resourcesParts = message.split('Resources:');
  if (resourcesParts.length > 1) {
    final lines = resourcesParts[1].split('\n- ');
    resources = lines.length > 1 ? lines.sublist(1) : const <String>[];
  }

  return SiweMessage(
    address: prefixMatch?.namedGroup('address'),
    domain: prefixMatch?.namedGroup('domain'),
    scheme: prefixMatch?.namedGroup('scheme'),
    statement: prefixMatch?.namedGroup('statement'),
    uri: suffixMatch?.namedGroup('uri'),
    version: suffixMatch?.namedGroup('version'),
    chainId: chainIdText == null ? null : int.parse(chainIdText),
    nonce: suffixMatch?.namedGroup('nonce'),
    issuedAt: issuedAtText == null ? null : DateTime.tryParse(issuedAtText),
    expirationTime: expirationTimeText == null
        ? null
        : DateTime.tryParse(expirationTimeText),
    notBefore: notBeforeText == null ? null : DateTime.tryParse(notBeforeText),
    requestId: suffixMatch?.namedGroup('requestId'),
    resources: resources,
  );
}
