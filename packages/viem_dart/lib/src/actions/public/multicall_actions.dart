import 'dart:typed_data';

import '../../abi/abi_item.dart';
import '../../abi/function_data.dart';
import '../../abi/human_readable/parse_abi.dart';
import '../../client/client.dart';
import '../../utils/hex.dart';
import 'state_actions.dart'; // for PublicClient.call()

/// A single call to batch into a [MulticallActions.multicall] request.
typedef MulticallCall = ({
  String address,
  AbiFunction abi,
  List<Object?> args,
  bool allowFailure,
});

/// The decoded outcome of one [MulticallCall]: `result` is the function's
/// decoded return value(s) (a single value if it has exactly one output,
/// otherwise the ordered list) when `success` — `null` on failure, with
/// `returnData` always holding the raw bytes returned for that call.
typedef MulticallResult = ({
  bool success,
  Object? result,
  Uint8List returnData,
});

final AbiFunction _aggregate3 =
    parseAbiItem(
          'function aggregate3((address target, bool allowFailure, bytes callData)[] calls) '
          'returns ((bool success, bytes returnData)[] returnData)',
        )
        as AbiFunction;

/// Batches multiple contract calls into a single `eth_call` via
/// [Multicall3](https://www.multicall3.com), deployed at the same address
/// on 250+ chains.
extension MulticallActions on PublicClient {
  /// The canonical Multicall3 deployment address (identical across every
  /// chain it's deployed on).
  static const String multicall3Address =
      '0xcA11bde05977b3631167028862bE2a173976CA11';

  /// Executes [calls] in one `eth_call` against [multicallAddress]
  /// (defaults to [multicall3Address]), returning one [MulticallResult] per
  /// call, in the same order. A call with `allowFailure: false` that
  /// reverts causes the *entire* multicall to revert (propagating as an
  /// [RpcError]) rather than reporting `success: false` for just that call
  /// — the same semantics Multicall3's `aggregate3` itself has.
  Future<List<MulticallResult>> multicall({
    required List<MulticallCall> calls,
    String multicallAddress = multicall3Address,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final encodedCalls = calls
        .map(
          (c) => [c.address, c.allowFailure, encodeFunctionData(c.abi, c.args)],
        )
        .toList();

    final data = encodeFunctionData(_aggregate3, [encodedCalls]);
    final rawResult = await call(
      to: multicallAddress,
      data: bytesToHex(data),
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    final decoded =
        decodeFunctionResult(_aggregate3, hexToBytes(rawResult)).single
            as List<Object?>;

    return List.generate(decoded.length, (i) {
      final entry = decoded[i] as List<Object?>;
      final success = entry[0] as bool;
      final returnData = entry[1] as Uint8List;
      Object? result;
      if (success) {
        final outputs = decodeFunctionResult(calls[i].abi, returnData);
        result = outputs.length == 1 ? outputs.single : outputs;
      }
      return (success: success, result: result, returnData: returnData);
    });
  }
}
