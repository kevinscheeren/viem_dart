import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization.freezed.dart';

/// One entry of an EIP-7702 authorization list: a signed statement from
/// [address]'s (or rather, the signer's — the entry's own recovered
/// signer, which must equal the delegating EOA) private key authorizing
/// that EOA to delegate execution to the contract at [address] for the
/// duration the delegation is installed. [yParity]/[r]/[s] are `null`
/// before the entry is signed.
@freezed
abstract class Authorization with _$Authorization {
  /// Creates an [Authorization] entry for [address], signed or unsigned.
  const factory Authorization({
    required BigInt chainId,
    required String address,
    required BigInt nonce,
    int? yParity,
    BigInt? r,
    BigInt? s,
  }) = _Authorization;
}
