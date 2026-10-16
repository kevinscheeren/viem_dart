import '../accounts/account.dart';
import '../crypto/secp256k1.dart' as secp256k1;
import 'authorization.dart';
import 'authorization_rlp.dart';

/// Signs [authorization] with [account]'s private key (per EIP-7702's
/// `0x05`-magic scheme, see [hashAuthorization]), returning a copy with
/// `yParity`/`r`/`s` populated and ready to add to a transaction's
/// `authorizationList`.
Authorization signAuthorization(
  Authorization authorization,
  LocalAccount account,
) {
  final signature = secp256k1.sign(
    hashAuthorization(authorization),
    account.privateKey,
  );
  return authorization.copyWith(
    yParity: signature.yParity,
    r: signature.r,
    s: signature.s,
  );
}
