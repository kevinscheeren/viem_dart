import 'base_error.dart';

/// Thrown when an ENS avatar's NFT metadata JSON is malformed or missing
/// an image field.
class EnsAvatarInvalidMetadataError extends ViemError {
  /// Creates an [EnsAvatarInvalidMetadataError] for the malformed [data].
  EnsAvatarInvalidMetadataError({required this.data})
    : super(
        'Unable to extract image from metadata. The metadata may be '
        'malformed or invalid.',
        metaMessages: [
          '- Metadata must be a JSON object with at least an `image`, '
              '`image_url`, or `image_data` property.',
          '',
          'Provided data: $data',
        ],
      );

  final Object? data;
}

/// Thrown when an ENS avatar's NFT (`eip155:...`) URI fails to parse.
class EnsAvatarInvalidNftUriError extends ViemError {
  /// Creates an [EnsAvatarInvalidNftUriError] with the given [reason].
  EnsAvatarInvalidNftUriError({required this.reason})
    : super('ENS NFT avatar URI is invalid. $reason');

  final String reason;
}

/// Thrown when a resolved ENS avatar [uri] can't be fetched into a valid
/// image.
class EnsAvatarUriResolutionError extends ViemError {
  /// Creates an [EnsAvatarUriResolutionError] for the unresolvable [uri].
  EnsAvatarUriResolutionError({required this.uri})
    : super(
        'Unable to resolve ENS avatar URI "$uri". The URI may be '
        'malformed, invalid, or does not respond with a valid image.',
      );

  final String uri;
}

/// Thrown when an ENS NFT avatar's [namespace] isn't `erc721` or
/// `erc1155`.
class EnsAvatarUnsupportedNamespaceError extends ViemError {
  /// Creates an [EnsAvatarUnsupportedNamespaceError] for the unsupported
  /// [namespace].
  EnsAvatarUnsupportedNamespaceError({required this.namespace})
    : super(
        'ENS NFT avatar namespace "$namespace" is not supported. Must be '
        '"erc721" or "erc1155".',
      );

  final String namespace;
}

/// Thrown when a [chainId] for ENSIP-11 chain-specific reverse resolution
/// is out of the valid range.
class EnsInvalidChainIdError extends ViemError {
  /// Creates an [EnsInvalidChainIdError] for the out-of-range [chainId].
  EnsInvalidChainIdError({required this.chainId})
    : super(
        'Invalid ENSIP-11 chainId: $chainId. Must be between 0 and '
        '0x7fffffff, or 1.',
      );

  final int chainId;
}
