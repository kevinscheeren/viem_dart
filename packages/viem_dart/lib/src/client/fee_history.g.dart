// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeeHistory _$FeeHistoryFromJson(Map<String, dynamic> json) => _FeeHistory(
  oldestBlock: const HexBigIntConverter().fromJson(
    json['oldestBlock'] as String,
  ),
  baseFeePerGas: const HexBigIntListConverter().fromJson(
    json['baseFeePerGas'] as List,
  ),
  gasUsedRatio: (json['gasUsedRatio'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  reward: (json['reward'] as List<dynamic>?)
      ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
);

Map<String, dynamic> _$FeeHistoryToJson(_FeeHistory instance) =>
    <String, dynamic>{
      'oldestBlock': const HexBigIntConverter().toJson(instance.oldestBlock),
      'baseFeePerGas': const HexBigIntListConverter().toJson(
        instance.baseFeePerGas,
      ),
      'gasUsedRatio': instance.gasUsedRatio,
      'reward': instance.reward,
    };
