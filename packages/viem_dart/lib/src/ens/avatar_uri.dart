import 'dart:convert';

import '../errors/ens_error.dart';

final RegExp _networkRegex = RegExp(
  r'(?<protocol>https?://[^/]*|ipfs:/|ipns:/|ar:/)?(?<root>/)?(?<subpath>ipfs/|ipns/)?(?<target>[\w\-.]+)(?<subtarget>/.*)?',
);

final RegExp _ipfsHashRegex = RegExp(
  r'^(Qm[1-9A-HJ-NP-Za-km-z]{44,}|b[A-Za-z2-7]{58,}|B[A-Z2-7]{58,}|z[1-9A-HJ-NP-Za-km-z]{48,}|F[0-9A-F]{50,})(/(?<target>[\w\-.]+))?(?<subtarget>/.*)?$',
);

final RegExp _base64Regex = RegExp(r'^data:([a-zA-Z\-/+]*);base64,([^"].*)');

final RegExp _dataUriRegex = RegExp(
  r'^data:([a-zA-Z\-/+]*)?(;[a-zA-Z0-9].*?)?(,)',
);

/// The resolved form of an avatar `uri` — `isOnChain` means it's already a
/// usable `data:`/inline-JSON value; otherwise it's a URL a caller would
/// fetch (via `package:http`, viem_dart doesn't fetch it itself).
typedef ResolvedAvatarUri = ({String uri, bool isOnChain, bool isEncoded});

/// Resolves an ENS avatar text record's raw `uri` to something directly
/// usable: an `ipfs://`/`ipns://` (or bare-CID/`/ipfs/.../ipns/...`) URI
/// becomes an [ipfsGateway] URL, an `ar://` URI becomes an [arweaveGateway]
/// URL, a plain `http(s)://` URI passes through unchanged, and inline
/// `data:`/base64/SVG content is returned as a `data:` URI.
///
/// Ported from viem's `resolveAvatarUri` (MIT) — see
/// https://github.com/wevm/viem/blob/main/src/utils/ens/avatar/utils.ts.
///
/// Does **not** handle NFT avatar records (`eip155:.../erc721:...` and
/// `eip155:.../erc1155:...`), which require an additional onchain
/// `tokenURI`/`uri` call plus fetching and parsing the token's metadata
/// JSON — call `getEnsText` with key `'avatar'` directly and handle that
/// case yourself if you need it; `getEnsAvatar` throws
/// [UnsupportedError] for it.
///
/// Throws [EnsAvatarUriResolutionError] if [uri] doesn't match any
/// recognized form.
ResolvedAvatarUri resolveAvatarUri(
  String uri, {
  String ipfsGateway = 'https://ipfs.io',
  String arweaveGateway = 'https://arweave.net',
}) {
  if (_base64Regex.hasMatch(uri)) {
    return (uri: uri, isOnChain: true, isEncoded: true);
  }

  final match = _networkRegex.firstMatch(uri);
  final protocol = match?.namedGroup('protocol');
  final subpath = match?.namedGroup('subpath');
  final target = match?.namedGroup('target');
  final subtarget = match?.namedGroup('subtarget') ?? '';

  final isIpns = protocol == 'ipns:/' || subpath == 'ipns/';
  final isIpfs =
      protocol == 'ipfs:/' ||
      subpath == 'ipfs/' ||
      _ipfsHashRegex.hasMatch(uri);

  if (uri.startsWith('http') && !isIpns && !isIpfs) {
    return (uri: uri, isOnChain: false, isEncoded: false);
  }

  if ((isIpns || isIpfs) && target != null) {
    return (
      uri: '$ipfsGateway/${isIpns ? 'ipns' : 'ipfs'}/$target$subtarget',
      isOnChain: false,
      isEncoded: false,
    );
  }

  if (protocol == 'ar:/' && target != null) {
    return (
      uri: '$arweaveGateway/$target$subtarget',
      isOnChain: false,
      isEncoded: false,
    );
  }

  var parsedUri = uri.replaceFirst(_dataUriRegex, '');
  if (parsedUri.startsWith('<svg')) {
    parsedUri =
        'data:image/svg+xml;base64,${base64Encode(utf8.encode(parsedUri))}';
  }

  if (parsedUri.startsWith('data:') || parsedUri.startsWith('{')) {
    return (uri: parsedUri, isOnChain: true, isEncoded: false);
  }

  throw EnsAvatarUriResolutionError(uri: uri);
}
