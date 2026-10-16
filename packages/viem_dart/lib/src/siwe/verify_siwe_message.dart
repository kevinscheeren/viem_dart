import 'dart:convert';
import 'dart:typed_data';

import '../accounts/sign_message.dart';
import '../accounts/verify_message.dart';
import '../actions/public/verify_hash_actions.dart';
import '../client/client.dart';
import '../crypto/signature.dart';
import 'parse_siwe_message.dart';
import 'validate_siwe_message.dart';

/// Verifies that an EIP-4361 [message] was signed (producing [signature])
/// by [address] — or by [message]'s own `address` field, if [address]
/// isn't given. Parses [message] via [parseSiweMessage], validates its
/// fields via [validateSiweMessage] ([domain]/[nonce]/[scheme]/[time] are
/// forwarded there), then checks [signature] via `verifyMessage`.
///
/// This needs no node, and so only verifies a signature by an externally
/// owned account (ECDSA recovery). For a message signed by a contract
/// account (ERC-1271), or by one that isn't deployed yet (ERC-6492), use
/// [SiweVerification.verifySiweMessage] on a `PublicClient`, which asks the
/// chain.
///
/// See https://eips.ethereum.org/EIPS/eip-4361
bool verifySiweMessage(
  String message, {
  required Signature signature,
  String? address,
  String? domain,
  String? nonce,
  String? scheme,
  DateTime? time,
}) {
  final signer = _validatedSigner(
    message,
    address: address,
    domain: domain,
    nonce: nonce,
    scheme: scheme,
    time: time,
  );
  if (signer == null) return false;

  return verifyMessage(address: signer, message: message, signature: signature);
}

/// Sign-In with Ethereum verification that asks the chain, available on
/// every `PublicClient`. Mirrors viem's `verifySiweMessage` client action.
extension SiweVerification on PublicClient {
  /// Like the top-level [verifySiweMessage], but [signature] may also come
  /// from a contract account: it is checked with [verifyHash] against the
  /// EIP-191 hash of [message], so it can be an EOA signature (no RPC call),
  /// an ERC-1271 signature from a deployed contract account such as a Safe,
  /// or an ERC-6492 signature from an account that isn't deployed yet.
  ///
  /// [signature] is a hex `String`, [Uint8List] or [Signature].
  /// [blockNumber]/[blockTag] pick the state the contract is asked at.
  ///
  /// See https://eips.ethereum.org/EIPS/eip-4361
  Future<bool> verifySiweMessage(
    String message, {
    required Object signature,
    String? address,
    String? domain,
    String? nonce,
    String? scheme,
    DateTime? time,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final signer = _validatedSigner(
      message,
      address: address,
      domain: domain,
      nonce: nonce,
      scheme: scheme,
      time: time,
    );
    if (signer == null) return false;

    return verifyHash(
      address: signer,
      hash: hashEip191Message(Uint8List.fromList(utf8.encode(message))),
      signature: signature,
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
  }
}

/// The address that must have signed [message] (its own `address` field), or
/// `null` if [message] has none or fails [validateSiweMessage].
String? _validatedSigner(
  String message, {
  String? address,
  String? domain,
  String? nonce,
  String? scheme,
  DateTime? time,
}) {
  final parsed = parseSiweMessage(message);
  final parsedAddress = parsed.address;
  if (parsedAddress == null) return null;

  final isValid = validateSiweMessage(
    message: parsed,
    address: address,
    domain: domain,
    nonce: nonce,
    scheme: scheme,
    time: time,
  );
  return isValid ? parsedAddress : null;
}
