import '../../client/log.dart';
import '../../client/wallet_client.dart';
import '../../errors/transaction_error.dart';
import '../../utils/hex.dart';
import '../public/public_actions.dart'; // for PublicClient.getChainId()

/// One call within a [BatchCallActions.sendCalls] batch — the same
/// `to`/`data`/`value` shape as a normal transaction, minus gas/nonce
/// (the wallet handles those).
typedef BatchCall = ({String? to, String? data, BigInt? value});

/// The wallet's immediate response to [BatchCallActions.sendCalls]: an
/// opaque [id] to poll via [BatchCallActions.getCallsStatus] (or
/// [BatchCallActions.waitForCallsStatus]), plus whatever [capabilities] it
/// reports back.
typedef SendCallsResult = ({String id, Map<String, Object?>? capabilities});

/// One transaction receipt within a [CallsStatus.receipts] list.
typedef CallReceipt = ({
  List<Log> logs,
  int status,
  String blockHash,
  BigInt blockNumber,
  BigInt gasUsed,
  String transactionHash,
});

/// The current status of a batch submitted via
/// [BatchCallActions.sendCalls] (`wallet_getCallsStatus`). [status] is the
/// raw EIP-5792 status code: `100` while pending, `200` once included
/// onchain without reverts, `400` for an offchain failure the wallet won't
/// retry, `500`/`600` for a complete/partial onchain revert. [receipts] is
/// only populated once the batch has landed onchain.
typedef CallsStatus = ({
  String version,
  String id,
  BigInt? chainId,
  int status,
  bool atomic,
  List<CallReceipt>? receipts,
  Map<String, Object?>? capabilities,
});

/// EIP-5792 batch-call actions available on every [WalletClient].
extension BatchCallActions on WalletClient {
  /// Submits [calls] together via `wallet_sendCalls`. The wallet executes
  /// them atomically when [atomicRequired] (the default) — set `false` to
  /// allow the wallet to fall back to executing them independently if it
  /// can't batch atomically. Returns the batch's opaque id and any
  /// capabilities the wallet reports; poll with [getCallsStatus] (or
  /// [waitForCallsStatus]) to check on completion.
  Future<SendCallsResult> sendCalls({
    required List<BatchCall> calls,
    bool atomicRequired = true,
    String? id,
    String? from,
    Map<String, Object?>? capabilities,
  }) async {
    final chainId = await getChainId();
    final result =
        await rpc.request('wallet_sendCalls', [
              {
                'version': '2.0.0',
                'id': ?id,
                'from': from ?? account.address,
                'chainId': bigIntToHex(chainId),
                'atomicRequired': atomicRequired,
                'calls': calls.map((c) {
                  final valueHex = c.value == null
                      ? null
                      : bigIntToHex(c.value!);
                  return {'to': ?c.to, 'data': ?c.data, 'value': ?valueHex};
                }).toList(),
                'capabilities': ?capabilities,
              },
            ])
            as Map<String, Object?>;
    return (
      id: result['id'] as String,
      capabilities: result['capabilities'] as Map<String, Object?>?,
    );
  }

  /// Fetches the current status of a batch submitted via [sendCalls]
  /// (`wallet_getCallsStatus`).
  Future<CallsStatus> getCallsStatus(String id) async {
    final result =
        await rpc.request('wallet_getCallsStatus', [id])
            as Map<String, Object?>;
    return _parseCallsStatus(result);
  }

  /// Polls [getCallsStatus] every [pollingInterval] until its `status` is
  /// no longer pending (`100`), or throws [WaitForCallsStatusTimeoutError]
  /// after [timeout].
  Future<CallsStatus> waitForCallsStatus(
    String id, {
    Duration pollingInterval = const Duration(seconds: 1),
    Duration timeout = const Duration(minutes: 2),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (true) {
      final status = await getCallsStatus(id);
      if (status.status != 100) return status;
      if (DateTime.now().isAfter(deadline)) {
        throw WaitForCallsStatusTimeoutError(id: id);
      }
      await Future<void>.delayed(pollingInterval);
    }
  }
}

CallsStatus _parseCallsStatus(Map<String, Object?> json) {
  final receiptsJson = json['receipts'] as List<Object?>?;
  final chainIdHex = json['chainId'] as String?;
  return (
    version: json['version'] as String,
    id: json['id'] as String,
    chainId: chainIdHex == null ? null : hexToBigInt(chainIdHex),
    status: json['status'] as int,
    atomic: json['atomic'] as bool,
    receipts: receiptsJson
        ?.map((r) => _parseCallReceipt((r as Map).cast<String, Object?>()))
        .toList(),
    capabilities: json['capabilities'] as Map<String, Object?>?,
  );
}

CallReceipt _parseCallReceipt(Map<String, Object?> json) {
  final logsJson = json['logs'] as List<Object?>? ?? const [];
  return (
    logs: logsJson
        .map((l) => Log.fromJson((l as Map).cast<String, dynamic>()))
        .toList(),
    status: hexToInt(json['status'] as String),
    blockHash: json['blockHash'] as String,
    blockNumber: hexToBigInt(json['blockNumber'] as String),
    gasUsed: hexToBigInt(json['gasUsed'] as String),
    transactionHash: json['transactionHash'] as String,
  );
}
