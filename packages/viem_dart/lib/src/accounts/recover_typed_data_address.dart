import '../crypto/secp256k1.dart' as secp256k1;
import '../crypto/signature.dart';
import 'sign_typed_data.dart';
import 'typed_data.dart';

/// Recovers the (EIP-55 checksummed) address that produced [signature] over
/// the given EIP-712 typed data — the reverse of [signTypedData]. See
/// [hashTypedData] for the hashing algorithm.
String recoverTypedDataAddress({
  required Eip712Domain domain,
  required Map<String, List<TypedDataField>> types,
  required String primaryType,
  required Map<String, Object?> message,
  required Signature signature,
}) {
  final hash = hashTypedData(
    domain: domain,
    types: types,
    primaryType: primaryType,
    message: message,
  );
  return secp256k1.recoverAddress(hash, signature);
}
