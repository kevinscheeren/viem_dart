import 'dart:async';
import 'dart:typed_data';

import '../../abi/abi_item.dart';
import '../../abi/abi_parameter.dart';
import '../../abi/decode_parameters.dart';
import '../../abi/encode_parameters.dart';
import '../../abi/event_log.dart';
import '../../abi/function_data.dart';
import '../../client/client.dart';
import '../../client/wallet_client.dart';
import '../../errors/contract_error.dart';
import '../../utils/hex.dart';
import '../state_override.dart';
import '../wallet/wallet_actions.dart'; // for WalletClient.sendTransaction()
import 'multicall_actions.dart'; // for PublicClient.multicall()
import 'state_actions.dart'; // for PublicClient.call()/getLogs()
import 'watch_actions.dart'; // for PublicClient.watchEvent()

/// Contract-aware actions available on every [PublicClient]: read/simulate a
/// function call, or query/watch a specific event — built on top of
/// [StateActions] and the ABI encode/decode layer.
extension ContractActions on PublicClient {
  /// Calls the read-only (or any) function [abi] on the contract at
  /// [address] with [args], returning its decoded return value(s):
  /// a single value if [abi] has exactly one output, otherwise the full
  /// `List<Object?>` of outputs in order.
  ///
  /// When [PublicClient.multicallBatch] is set, concurrent calls sharing
  /// the same [blockNumber]/[blockTag] are auto-combined into a single
  /// `multicall` — see `MulticallBatchConfig`. Callers can't observe the
  /// difference beyond timing: a batched call that reverts throws
  /// [ContractFunctionRevertedError] here (multicall's `allowFailure`
  /// reports a revert as data, not an RPC error, unlike a direct
  /// `eth_call`), same as an unbatched call reverting would surface as an
  /// [RpcError] either way — both are just "this call failed".
  ///
  /// [stateOverride] runs the call against temporarily modified account
  /// state (see [AccountStateOverride]). A call with an override is never
  /// batched: a multicall can't carry per-call overrides.
  Future<Object?> readContract({
    required String address,
    required AbiFunction abi,
    List<Object?> args = const [],
    BigInt? blockNumber,
    String blockTag = 'latest',
    List<AccountStateOverride>? stateOverride,
  }) {
    final batchConfig = multicallBatch;
    if (batchConfig == null || stateOverride != null) {
      return _readContractDirect(
        address: address,
        abi: abi,
        args: args,
        blockNumber: blockNumber,
        blockTag: blockTag,
        stateOverride: stateOverride,
      );
    }
    return _enqueueForMulticallBatch(
      batchConfig,
      address: address,
      abi: abi,
      args: args,
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
  }

  Future<Object?> _readContractDirect({
    required String address,
    required AbiFunction abi,
    required List<Object?> args,
    required BigInt? blockNumber,
    required String blockTag,
    List<AccountStateOverride>? stateOverride,
  }) async {
    final callData = encodeFunctionData(abi, args);
    final result = await call(
      to: address,
      data: bytesToHex(callData),
      blockNumber: blockNumber,
      blockTag: blockTag,
      stateOverride: stateOverride,
    );
    return _unwrapSingle(decodeFunctionResult(abi, hexToBytes(result)));
  }

  Future<Object?> _enqueueForMulticallBatch(
    MulticallBatchConfig batchConfig, {
    required String address,
    required AbiFunction abi,
    required List<Object?> args,
    required BigInt? blockNumber,
    required String blockTag,
  }) {
    final queues = _multicallQueuesByClient[this] ??= {};
    // Every sub-call in one multicall executes against the same block, so
    // only calls sharing the same (blockNumber, blockTag) can share a batch.
    final blockKey = '${blockNumber ?? ''}:$blockTag';
    final queue = queues.putIfAbsent(blockKey, () => _MulticallQueue());

    final completer = Completer<Object?>();
    queue.pending.add(
      _PendingReadCall(
        address: address,
        abi: abi,
        args: args,
        completer: completer,
      ),
    );

    if (queue.pending.length >= batchConfig.batchSize) {
      _flushMulticallQueue(
        queues,
        blockKey,
        queue,
        batchConfig,
        blockNumber: blockNumber,
        blockTag: blockTag,
      );
    } else {
      queue.timer ??= Timer(batchConfig.wait, () {
        _flushMulticallQueue(
          queues,
          blockKey,
          queue,
          batchConfig,
          blockNumber: blockNumber,
          blockTag: blockTag,
        );
      });
    }
    return completer.future;
  }

  void _flushMulticallQueue(
    Map<String, _MulticallQueue> queues,
    String blockKey,
    _MulticallQueue queue,
    MulticallBatchConfig batchConfig, {
    required BigInt? blockNumber,
    required String blockTag,
  }) {
    queue.timer?.cancel();
    queue.timer = null;
    if (queue.pending.isEmpty) return;
    final batch = List<_PendingReadCall>.of(queue.pending);
    queue.pending.clear();
    queues.remove(blockKey);
    unawaited(
      _sendMulticallBatch(
        batch,
        batchConfig,
        blockNumber: blockNumber,
        blockTag: blockTag,
      ),
    );
  }

  Future<void> _sendMulticallBatch(
    List<_PendingReadCall> batch,
    MulticallBatchConfig batchConfig, {
    required BigInt? blockNumber,
    required String blockTag,
  }) async {
    // Not worth a multicall for just one call — send it directly instead.
    if (batch.length == 1) {
      final pending = batch.single;
      try {
        final result = await _readContractDirect(
          address: pending.address,
          abi: pending.abi,
          args: pending.args,
          blockNumber: blockNumber,
          blockTag: blockTag,
        );
        pending.completer.complete(result);
      } catch (error, stackTrace) {
        pending.completer.completeError(error, stackTrace);
      }
      return;
    }

    try {
      final results = await multicall(
        calls: batch
            .map(
              (p) => (
                address: p.address,
                abi: p.abi,
                args: p.args,
                allowFailure: true,
              ),
            )
            .toList(),
        multicallAddress:
            batchConfig.multicallAddress ?? MulticallActions.multicall3Address,
        blockNumber: blockNumber,
        blockTag: blockTag,
      );
      for (var i = 0; i < batch.length; i++) {
        final result = results[i];
        if (result.success) {
          batch[i].completer.complete(result.result);
        } else {
          batch[i].completer.completeError(
            ContractFunctionRevertedError(
              functionName: batch[i].abi.name,
              reason: _errorStringReason(result.returnData),
              data: result.returnData,
            ),
          );
        }
      }
    } catch (error, stackTrace) {
      for (final pending in batch) {
        pending.completer.completeError(error, stackTrace);
      }
    }
  }

  /// Simulates calling [abi] on the contract at [address] as if sent
  /// [from] a given account with [value] — useful for previewing a
  /// state-changing function's result or confirming it wouldn't revert,
  /// without submitting a transaction (`eth_call` never commits state
  /// regardless of the function's mutability). [stateOverride] runs the
  /// simulation against temporarily modified account state (see
  /// [AccountStateOverride]).
  Future<Object?> simulateContract({
    required String address,
    required AbiFunction abi,
    List<Object?> args = const [],
    String? from,
    BigInt? value,
    BigInt? blockNumber,
    String blockTag = 'latest',
    List<AccountStateOverride>? stateOverride,
  }) async {
    final callData = encodeFunctionData(abi, args);
    final result = await call(
      from: from,
      to: address,
      data: bytesToHex(callData),
      value: value,
      blockNumber: blockNumber,
      blockTag: blockTag,
      stateOverride: stateOverride,
    );
    return _unwrapSingle(decodeFunctionResult(abi, hexToBytes(result)));
  }

  /// Fetches and decodes past logs for [event] emitted by the contract at
  /// [address], optionally filtered by indexed parameter values in [args].
  Future<List<Map<String, Object?>>> getContractEvents({
    required String address,
    required AbiEvent event,
    Map<String, Object?> args = const {},
    BigInt? fromBlockNumber,
    String fromBlockTag = 'earliest',
    BigInt? toBlockNumber,
    String toBlockTag = 'latest',
  }) async {
    final logs = await getLogs(
      address: address,
      topics: encodeEventTopics(event, args),
      fromBlockNumber: fromBlockNumber,
      fromBlockTag: fromBlockTag,
      toBlockNumber: toBlockNumber,
      toBlockTag: toBlockTag,
    );
    return logs
        .map(
          (log) => decodeEventLog(
            event,
            topics: log.topics,
            data: hexToBytes(log.data),
          ),
        )
        .toList();
  }

  /// Emits each new decoded occurrence of [event] from the contract at
  /// [address], optionally filtered by indexed parameter values in [args].
  Stream<Map<String, Object?>> watchContractEvent({
    required String address,
    required AbiEvent event,
    Map<String, Object?> args = const {},
    Duration pollingInterval = const Duration(seconds: 4),
  }) async* {
    final topics = encodeEventTopics(event, args);
    await for (final log in watchEvent(
      address: address,
      topics: topics,
      pollingInterval: pollingInterval,
    )) {
      yield decodeEventLog(
        event,
        topics: log.topics,
        data: hexToBytes(log.data),
      );
    }
  }
}

/// Contract-aware write actions available on every [WalletClient].
extension ContractWalletActions on WalletClient {
  /// Calls the state-changing function [abi] on the contract at [address]
  /// with [args], signing and submitting the transaction (via
  /// [WalletActions.sendTransaction]) and returning its hash. Unlike
  /// [ContractActions.simulateContract], this actually commits state.
  Future<String> writeContract({
    required String address,
    required AbiFunction abi,
    List<Object?> args = const [],
    String? from,
    BigInt? value,
    BigInt? gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
    int? nonce,
  }) {
    final callData = encodeFunctionData(abi, args);
    return sendTransaction(
      from: from,
      to: address,
      data: bytesToHex(callData),
      value: value,
      gas: gas,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      nonce: nonce,
    );
  }

  /// Deploys a contract: signs and submits a `to`-less transaction whose
  /// data is [bytecode] followed by the ABI-encoded [args] (per [abi]'s
  /// constructor inputs, if any), returning the deployment transaction's
  /// hash. Pass [abi] (and [args]) only when the contract has constructor
  /// parameters to encode — omit both to deploy [bytecode] as-is.
  ///
  /// The deployed contract's address isn't returned directly — read it off
  /// `contractAddress` on the receipt once mined, e.g. via
  /// `waitForTransactionReceipt`.
  Future<String> deployContract({
    required Uint8List bytecode,
    AbiConstructor? abi,
    List<Object?> args = const [],
    String? from,
    BigInt? value,
    BigInt? gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
    int? nonce,
  }) {
    final encodedArgs = abi == null
        ? Uint8List(0)
        : encodeAbiParameters(abi.inputs, args);
    final data = Uint8List.fromList([...bytecode, ...encodedArgs]);
    return sendTransaction(
      from: from,
      data: bytesToHex(data),
      value: value,
      gas: gas,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
      nonce: nonce,
    );
  }
}

/// Per-[PublicClient] readContract batch queues, keyed by block context —
/// attached via [Expando] rather than a field on [PublicClient] itself, so
/// this batching machinery stays co-located with the action it serves
/// instead of leaking into the core client class.
final Expando<Map<String, _MulticallQueue>> _multicallQueuesByClient =
    Expando();

class _MulticallQueue {
  final List<_PendingReadCall> pending = [];
  Timer? timer;
}

class _PendingReadCall {
  _PendingReadCall({
    required this.address,
    required this.abi,
    required this.args,
    required this.completer,
  });
  final String address;
  final AbiFunction abi;
  final List<Object?> args;
  final Completer<Object?> completer;
}

/// The message of an `Error(string)` revert (selector `0x08c379a0`), or
/// `null` for any other revert data (custom errors, panics, empty data).
String? _errorStringReason(Uint8List data) {
  if (data.length < 4 ||
      data[0] != 0x08 ||
      data[1] != 0xc3 ||
      data[2] != 0x79 ||
      data[3] != 0xa0) {
    return null;
  }
  try {
    return decodeAbiParameters(const [
          AbiParameter(name: '', type: 'string'),
        ], data.sublist(4)).single
        as String;
  } on Object {
    return null;
  }
}

Object? _unwrapSingle(List<Object?> outputs) =>
    outputs.length == 1 ? outputs.single : outputs;
