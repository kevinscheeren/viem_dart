import '../crypto/signature.dart';
import '../utils/address.dart';
import 'recover_typed_data_address.dart';
import 'typed_data.dart';

/// Verifies that [signature] over the given EIP-712 typed data was produced
/// by [address] — compares [recoverTypedDataAddress] against [address] via
/// [isAddressEqual].
bool verifyTypedData({
  required String address,
  required Eip712Domain domain,
  required Map<String, List<TypedDataField>> types,
  required String primaryType,
  required Map<String, Object?> message,
  required Signature signature,
}) {
  final recovered = recoverTypedDataAddress(
    domain: domain,
    types: types,
    primaryType: primaryType,
    message: message,
    signature: signature,
  );
  return isAddressEqual(recovered, address);
}
