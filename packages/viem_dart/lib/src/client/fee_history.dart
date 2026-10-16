import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'fee_history.freezed.dart';
part 'fee_history.g.dart';

/// The result of `eth_feeHistory`: historical base fees and (optionally,
/// when reward percentiles were requested) priority fee percentiles per
/// block.
@freezed
abstract class FeeHistory with _$FeeHistory {
  /// Creates a [FeeHistory] from its raw fields.
  const factory FeeHistory({
    @HexBigIntConverter() required BigInt oldestBlock,
    @HexBigIntListConverter() required List<BigInt> baseFeePerGas,
    required List<double> gasUsedRatio,
    List<List<String>>? reward,
  }) = _FeeHistory;

  /// Parses a `eth_feeHistory` JSON-RPC result.
  factory FeeHistory.fromJson(Map<String, dynamic> json) =>
      _$FeeHistoryFromJson(json);
}
