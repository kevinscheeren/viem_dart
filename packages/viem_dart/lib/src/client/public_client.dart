import '../chain/chain.dart';
import '../transports/transport.dart';
import 'client.dart';

/// Creates a [PublicClient] for reading on-chain state.
PublicClient createPublicClient({required Transport transport, Chain? chain}) =>
    PublicClient(transport: transport, chain: chain);
