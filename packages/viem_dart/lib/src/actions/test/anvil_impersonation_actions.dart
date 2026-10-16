import '../../client/test_client.dart';
import '../../utils/hex.dart';

/// Anvil account-impersonation actions available on every [TestClient] — for
/// driving a local anvil test node, not a real network.
extension AnvilImpersonationActions on TestClient {
  /// Lets subsequent transactions be sent `from` [address] without needing
  /// its private key (`anvil_impersonateAccount`) — anvil accepts any
  /// signature (or none) for an impersonated account's transactions.
  Future<void> impersonateAccount({required String address}) async {
    await rpc.request('anvil_impersonateAccount', [address]);
  }

  /// Reverses [impersonateAccount] for [address]
  /// (`anvil_stopImpersonatingAccount`).
  Future<void> stopImpersonatingAccount({required String address}) async {
    await rpc.request('anvil_stopImpersonatingAccount', [address]);
  }

  /// Submits a transaction with no signature at all
  /// (`eth_sendUnsignedTransaction`) — anvil executes it as if [from] had
  /// signed it, without checking. Typically paired with
  /// [impersonateAccount] to act as an account with no known private key.
  Future<String> sendUnsignedTransaction({
    required String from,
    String? to,
    BigInt? value,
    String? data,
    int? nonce,
    BigInt? gas,
    BigInt? gasPrice,
  }) async {
    final txObject = <String, Object?>{
      'from': from,
      'to': ?to,
      'data': ?data,
      if (value != null) 'value': bigIntToHex(value),
      if (nonce != null) 'nonce': intToHex(nonce),
      if (gas != null) 'gas': bigIntToHex(gas),
      if (gasPrice != null) 'gasPrice': bigIntToHex(gasPrice),
    };
    final result = await rpc.request('eth_sendUnsignedTransaction', [txObject]);
    return result as String;
  }
}
