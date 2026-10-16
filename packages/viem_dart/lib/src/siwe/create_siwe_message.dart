import '../errors/siwe_error.dart';
import '../utils/address.dart';
import 'is_uri.dart';

final RegExp _domainRegExp = RegExp(
  r'^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}(:[0-9]{1,5})?$',
);
final RegExp _ipRegExp = RegExp(
  r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.'
  r'(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
  r'(:[0-9]{1,5})?$',
);
final RegExp _localhostRegExp = RegExp(r'^localhost(:[0-9]{1,5})?$');
final RegExp _nonceRegExp = RegExp(r'^[a-zA-Z0-9]{8,}$');
// Reproduced verbatim from viem's own schemeRegex, including the
// un-escaped `-` between `+`/`.` — see the note on parseSiweMessage's
// prefixRegex for why this is kept as-is rather than "fixed".
final RegExp _schemeRegExp = RegExp(r'^([a-zA-Z][a-zA-Z0-9+-.]*)$');

/// Builds an EIP-4361 ("Sign-In with Ethereum") formatted message ready to
/// be signed (e.g. via `signMessage`).
///
/// Throws [SiweInvalidMessageFieldError] if a field fails its EIP-4361
/// format requirement — see the EIP for each field's exact rules.
///
/// See https://eips.ethereum.org/EIPS/eip-4361
String createSiweMessage({
  required String address,
  required int chainId,
  required String domain,
  DateTime? expirationTime,
  DateTime? issuedAt,
  required String nonce,
  DateTime? notBefore,
  String? requestId,
  List<String>? resources,
  String? scheme,
  String? statement,
  required String uri,
  String version = '1',
}) {
  // Required fields.
  if (!(_domainRegExp.hasMatch(domain) ||
      _ipRegExp.hasMatch(domain) ||
      _localhostRegExp.hasMatch(domain))) {
    throw SiweInvalidMessageFieldError(
      field: 'domain',
      metaMessages: [
        '- Domain must be an RFC 3986 authority.',
        '- See https://www.rfc-editor.org/rfc/rfc3986',
        '',
        'Provided value: $domain',
      ],
    );
  }
  if (!_nonceRegExp.hasMatch(nonce)) {
    throw SiweInvalidMessageFieldError(
      field: 'nonce',
      metaMessages: [
        '- Nonce must be at least 8 characters.',
        '- Nonce must be alphanumeric.',
        '',
        'Provided value: $nonce',
      ],
    );
  }
  if (!isUri(uri)) {
    throw SiweInvalidMessageFieldError(
      field: 'uri',
      metaMessages: [
        '- URI must be a RFC 3986 URI referring to the resource that is '
            'the subject of the signing.',
        '- See https://www.rfc-editor.org/rfc/rfc3986',
        '',
        'Provided value: $uri',
      ],
    );
  }
  if (version != '1') {
    throw SiweInvalidMessageFieldError(
      field: 'version',
      metaMessages: ["- Version must be '1'.", '', 'Provided value: $version'],
    );
  }

  // Optional fields.
  if (scheme != null && !_schemeRegExp.hasMatch(scheme)) {
    throw SiweInvalidMessageFieldError(
      field: 'scheme',
      metaMessages: [
        '- Scheme must be an RFC 3986 URI scheme.',
        '- See https://www.rfc-editor.org/rfc/rfc3986#section-3.1',
        '',
        'Provided value: $scheme',
      ],
    );
  }
  if (statement != null && statement.contains('\n')) {
    throw SiweInvalidMessageFieldError(
      field: 'statement',
      metaMessages: [
        r"- Statement must not include '\n'.",
        '',
        'Provided value: $statement',
      ],
    );
  }

  // Construct message.
  final checksummedAddress = getAddress(address);
  final origin = scheme != null ? '$scheme://$domain' : domain;
  final statementLine = statement == null ? '' : '$statement\n';
  final prefix =
      '$origin wants you to sign in with your Ethereum account:\n'
      '$checksummedAddress\n\n$statementLine';

  var suffix =
      'URI: $uri\n'
      'Version: $version\n'
      'Chain ID: $chainId\n'
      'Nonce: $nonce\n'
      'Issued At: ${_isoStringMs(issuedAt ?? DateTime.now())}';

  if (expirationTime != null) {
    suffix += '\nExpiration Time: ${_isoStringMs(expirationTime)}';
  }
  if (notBefore != null) {
    suffix += '\nNot Before: ${_isoStringMs(notBefore)}';
  }
  if (requestId != null) {
    suffix += '\nRequest ID: $requestId';
  }
  if (resources != null) {
    var content = '\nResources:';
    for (final resource in resources) {
      if (!isUri(resource)) {
        throw SiweInvalidMessageFieldError(
          field: 'resources',
          metaMessages: [
            '- Every resource must be a RFC 3986 URI.',
            '- See https://www.rfc-editor.org/rfc/rfc3986',
            '',
            'Provided value: $resource',
          ],
        );
      }
      content += '\n- $resource';
    }
    suffix += content;
  }

  return '$prefix\n$suffix';
}

/// Renders [date] the same way JS's `Date.prototype.toISOString()` does:
/// always UTC, always exactly millisecond precision, `Z`-suffixed —
/// matching viem's own `issuedAt.toISOString()` et al.
String _isoStringMs(DateTime date) => DateTime.fromMillisecondsSinceEpoch(
  date.toUtc().millisecondsSinceEpoch,
  isUtc: true,
).toIso8601String();
