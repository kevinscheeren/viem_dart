import '../accounts/account.dart';
import '../chain/chain.dart';
import '../transports/transport.dart';
import 'client.dart';

/// A [PublicClient] with a required signing [account]. Wallet actions
/// (`sendTransaction`, `writeContract`, `signMessage`, ...) are Dart
/// extension methods on [WalletClient] — importing `viem_dart.dart` brings
/// them into scope. Unlike the old untyped `Client`, [account] can't be
/// `null` — a `WalletClient` simply can't exist without one, so wallet
/// actions no longer need to null-check it at runtime.
class WalletClient extends PublicClient {
  /// Creates a [WalletClient] over [transport], with an optional [chain]
  /// and the required signing [account].
  WalletClient({required super.transport, super.chain, required this.account});

  final LocalAccount account;
}

/// Creates a [WalletClient] for signing/sending transactions, with
/// [account] as its signer.
WalletClient createWalletClient({
  required Transport transport,
  Chain? chain,
  required LocalAccount account,
}) => WalletClient(transport: transport, chain: chain, account: account);
