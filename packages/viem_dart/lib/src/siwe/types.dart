import 'package:freezed_annotation/freezed_annotation.dart';

part 'types.freezed.dart';

/// EIP-4361 ("Sign-In with Ethereum") message fields.
///
/// Every field here is optional — unlike the EIP's own required/optional
/// split — since this type doubles as [parseSiweMessage]'s return shape,
/// which may only be able to extract a subset of fields from malformed or
/// partial input. [createSiweMessage] takes its own named parameters with
/// the EIP's real required/optional split enforced at the type level
/// instead of accepting a [SiweMessage].
///
/// See https://eips.ethereum.org/EIPS/eip-4361
@freezed
abstract class SiweMessage with _$SiweMessage {
  /// Creates a [SiweMessage] from its raw fields.
  const factory SiweMessage({
    String? address,
    int? chainId,
    String? domain,
    DateTime? expirationTime,
    DateTime? issuedAt,
    String? nonce,
    DateTime? notBefore,
    String? requestId,
    List<String>? resources,
    String? scheme,
    String? statement,
    String? uri,
    String? version,
  }) = _SiweMessage;
}
