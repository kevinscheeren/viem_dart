import '../chain/chain.dart';
import '../transports/transport.dart';
import 'client.dart';

/// A [PublicClient] for driving a local test node (anvil/hardhat) —
/// state-mutation, impersonation, and snapshot/time-control actions
/// (`setBalance`, `impersonateAccount`, `snapshot`, `mine`, ...) are Dart
/// extension methods on [TestClient] — importing `test_actions.dart` (or
/// `viem_dart.dart`) brings them into scope. Calling anvil-only actions
/// against a non-anvil node will still fail at the RPC layer — [TestClient]
/// only guarantees the actions are *available*, not that the node
/// understands them.
class TestClient extends PublicClient {
  /// Creates a [TestClient] over [transport], with an optional [chain].
  TestClient({required super.transport, super.chain});
}

/// Creates a [TestClient] for driving a local test node.
TestClient createTestClient({required Transport transport, Chain? chain}) =>
    TestClient(transport: transport, chain: chain);
