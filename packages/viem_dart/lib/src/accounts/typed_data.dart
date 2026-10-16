import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'typed_data.freezed.dart';

/// An EIP-712 domain separator's fields — only the non-null ones are
/// included when hashing (per the spec, `EIP712Domain`'s own type
/// definition is derived from whichever fields are actually present).
@freezed
abstract class Eip712Domain with _$Eip712Domain {
  /// Creates an EIP-712 domain separator from whichever fields apply.
  const factory Eip712Domain({
    String? name,
    String? version,
    BigInt? chainId,
    String? verifyingContract,
    Uint8List? salt,
  }) = _Eip712Domain;
}

/// One field of an EIP-712 struct type definition (as they appear in the
/// `types` map passed to `signTypedData`/`hashTypedData`).
@freezed
abstract class TypedDataField with _$TypedDataField {
  /// Creates a struct field definition with the given [name] and [type].
  const factory TypedDataField({required String name, required String type}) =
      _TypedDataField;
}
