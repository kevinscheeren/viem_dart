import '../utils/address.dart';
import 'types.dart';

/// Validates a (typically [parseSiweMessage]-parsed) [message] against the
/// caller's own expectations: [domain]/[nonce]/[scheme] must match if
/// given, [address] must match [message]'s `address` if given, and
/// [message]'s `expirationTime`/`notBefore` window (checked against [time],
/// defaulting to now) must currently be open.
///
/// Doesn't check the signature itself — see `verifySiweMessage` for that.
///
/// See https://eips.ethereum.org/EIPS/eip-4361
bool validateSiweMessage({
  required SiweMessage message,
  String? address,
  String? domain,
  String? nonce,
  String? scheme,
  DateTime? time,
}) {
  final checkTime = time ?? DateTime.now();

  if (domain != null && message.domain != domain) return false;
  if (nonce != null && message.nonce != nonce) return false;
  if (scheme != null && message.scheme != scheme) return false;

  final expirationTime = message.expirationTime;
  if (expirationTime != null && !checkTime.isBefore(expirationTime)) {
    return false;
  }
  final notBefore = message.notBefore;
  if (notBefore != null && checkTime.isBefore(notBefore)) return false;

  final messageAddress = message.address;
  if (messageAddress == null) return false;
  if (!isAddress(messageAddress)) return false;
  if (address != null && !isAddressEqual(messageAddress, address)) {
    return false;
  }

  return true;
}
