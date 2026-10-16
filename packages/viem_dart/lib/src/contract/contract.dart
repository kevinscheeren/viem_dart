import '../abi/abi_item.dart';
import '../actions/public/contract_actions.dart';
import '../client/client.dart';
import '../client/wallet_client.dart';

/// An ergonomic, runtime-ABI contract handle bundling [address]/[abi] with a
/// [client], so callers don't have to repeat them on every action call.
///
/// This is the *runtime* counterpart to `viem_dart_builders`' compile-time
/// code generation: use
/// this class when a contract's ABI is only known at runtime (e.g. fetched
/// from a block explorer); prefer generated typed bindings when the ABI is
/// known ahead of time.
///
/// Functions/events are looked up by name via [args] arity when a name is
/// overloaded (e.g. `safeTransferFrom(address,address,uint256)` vs. its
/// 4-argument overload) — unlike viem's JS `getContract()`, there's no
/// per-function typed property (`contract.read.balanceOf(...)`), since Dart
/// has no dynamic-proxy equivalent; call by name instead:
/// `contract.read('balanceOf', [owner])`.
class Contract {
  /// Creates a read-only [Contract] handle for the contract at [address]
  /// with the given [abi], bound to [client]. Use [getContract] rather than
  /// this constructor directly for viem-parity naming.
  const Contract({
    required this.address,
    required this.abi,
    required this.client,
  });

  /// The contract's deployed address.
  final String address;

  /// The contract's ABI (functions, events, and any other item kinds).
  final List<AbiItem> abi;

  /// The client used to send read/simulate/event actions.
  final PublicClient client;

  /// Calls the read-only (or any) function named [functionName] with
  /// [args] — see [ContractActions.readContract].
  Future<Object?> read(
    String functionName, [
    List<Object?> args = const [],
    BigInt? blockNumber,
    String blockTag = 'latest',
  ]) => client.readContract(
    address: address,
    abi: _function(functionName, args.length),
    args: args,
    blockNumber: blockNumber,
    blockTag: blockTag,
  );

  /// Simulates calling the function named [functionName] with [args] —
  /// see [ContractActions.simulateContract].
  Future<Object?> simulate(
    String functionName, [
    List<Object?> args = const [],
    String? from,
    BigInt? value,
    BigInt? blockNumber,
    String blockTag = 'latest',
  ]) => client.simulateContract(
    address: address,
    abi: _function(functionName, args.length),
    args: args,
    from: from,
    value: value,
    blockNumber: blockNumber,
    blockTag: blockTag,
  );

  /// Fetches past logs for the event named [eventName] — see
  /// [ContractActions.getContractEvents].
  Future<List<Map<String, Object?>>> getEvents(
    String eventName, {
    Map<String, Object?> args = const {},
    BigInt? fromBlockNumber,
    String fromBlockTag = 'earliest',
    BigInt? toBlockNumber,
    String toBlockTag = 'latest',
  }) => client.getContractEvents(
    address: address,
    event: _event(eventName),
    args: args,
    fromBlockNumber: fromBlockNumber,
    fromBlockTag: fromBlockTag,
    toBlockNumber: toBlockNumber,
    toBlockTag: toBlockTag,
  );

  /// Watches for new occurrences of the event named [eventName] — see
  /// [ContractActions.watchContractEvent].
  Stream<Map<String, Object?>> watchEvent(
    String eventName, {
    Map<String, Object?> args = const {},
    Duration pollingInterval = const Duration(seconds: 4),
  }) => client.watchContractEvent(
    address: address,
    event: _event(eventName),
    args: args,
    pollingInterval: pollingInterval,
  );

  AbiFunction _function(String name, int argCount) {
    final candidates = abi.whereType<AbiFunction>().where(
      (f) => f.name == name,
    );
    if (candidates.isEmpty) {
      throw ArgumentError('No function named "$name" in this contract\'s ABI.');
    }
    return candidates.length == 1
        ? candidates.single
        : candidates.firstWhere(
            (f) => f.inputs.length == argCount,
            orElse: () => throw ArgumentError(
              'No overload of "$name" takes $argCount argument(s).',
            ),
          );
  }

  AbiEvent _event(String name) {
    final event = abi.whereType<AbiEvent>().where((e) => e.name == name);
    if (event.isEmpty) {
      throw ArgumentError('No event named "$name" in this contract\'s ABI.');
    }
    return event.first;
  }
}

/// A [Contract] handle bound to a [WalletClient], additionally exposing
/// [write] for state-changing calls. Created via [getWalletContract].
class WalletContract extends Contract {
  /// Creates a [WalletContract] handle for the contract at [address] with
  /// the given [abi], bound to [client].
  const WalletContract({
    required super.address,
    required super.abi,
    required WalletClient client,
  }) : super(client: client);

  WalletClient get _walletClient => client as WalletClient;

  /// Calls the state-changing function named [functionName] with [args],
  /// signing and submitting the transaction — see
  /// [ContractWalletActions.writeContract].
  Future<String> write(
    String functionName, [
    List<Object?> args = const [],
    String? from,
    BigInt? value,
    BigInt? gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
    int? nonce,
  ]) => _walletClient.writeContract(
    address: address,
    abi: _function(functionName, args.length),
    args: args,
    from: from,
    value: value,
    gas: gas,
    maxFeePerGas: maxFeePerGas,
    maxPriorityFeePerGas: maxPriorityFeePerGas,
    nonce: nonce,
  );
}

/// Creates a read-only [Contract] handle for the contract at [address] with
/// [abi], bound to [client] — mirrors viem's `getContract()`. Use
/// [getWalletContract] instead when state-changing calls are needed.
Contract getContract({
  required String address,
  required List<AbiItem> abi,
  required PublicClient client,
}) => Contract(address: address, abi: abi, client: client);

/// Creates a [WalletContract] handle for the contract at [address] with
/// [abi], bound to [client] — adds [WalletContract.write] for
/// state-changing calls over [getContract]'s read-only [Contract].
WalletContract getWalletContract({
  required String address,
  required List<AbiItem> abi,
  required WalletClient client,
}) => WalletContract(address: address, abi: abi, client: client);
