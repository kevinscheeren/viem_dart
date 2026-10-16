import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'log.freezed.dart';
part 'log.g.dart';

/// An event log entry, as returned by `eth_getLogs` /
/// `eth_getTransactionReceipt` / `eth_subscribe("logs")`.
@freezed
abstract class Log with _$Log {
  /// Creates a [Log] from its raw fields.
  const factory Log({
    required String address,
    required List<String> topics,
    required String data,
    @HexBigIntNConverter() BigInt? blockNumber,
    String? blockHash,
    String? transactionHash,
    @HexIntNConverter() int? transactionIndex,
    @HexIntNConverter() int? logIndex,
    @Default(false) bool removed,
  }) = _Log;

  /// Parses a single log entry from a JSON-RPC result.
  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
}
