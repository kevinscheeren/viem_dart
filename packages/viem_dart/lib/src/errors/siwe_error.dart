import 'base_error.dart';

/// Thrown by `createSiweMessage` when an EIP-4361 message field fails its
/// format requirement (e.g. an invalid `domain`, a `nonce` shorter than 8
/// alphanumeric characters, a non-RFC-3986 `uri`).
class SiweInvalidMessageFieldError extends ViemError {
  /// Creates a [SiweInvalidMessageFieldError] for the invalid [field].
  SiweInvalidMessageFieldError({
    required this.field,
    super.metaMessages = const [],
  }) : super('Invalid Sign-In with Ethereum message field "$field".');

  /// The name of the field that failed validation.
  final String field;
}
