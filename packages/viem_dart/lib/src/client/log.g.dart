// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Log _$LogFromJson(Map<String, dynamic> json) => _Log(
  address: json['address'] as String,
  topics: (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
  data: json['data'] as String,
  blockNumber: const HexBigIntNConverter().fromJson(
    json['blockNumber'] as String?,
  ),
  blockHash: json['blockHash'] as String?,
  transactionHash: json['transactionHash'] as String?,
  transactionIndex: const HexIntNConverter().fromJson(
    json['transactionIndex'] as String?,
  ),
  logIndex: const HexIntNConverter().fromJson(json['logIndex'] as String?),
  removed: json['removed'] as bool? ?? false,
);

Map<String, dynamic> _$LogToJson(_Log instance) => <String, dynamic>{
  'address': instance.address,
  'topics': instance.topics,
  'data': instance.data,
  'blockNumber': const HexBigIntNConverter().toJson(instance.blockNumber),
  'blockHash': instance.blockHash,
  'transactionHash': instance.transactionHash,
  'transactionIndex': const HexIntNConverter().toJson(
    instance.transactionIndex,
  ),
  'logIndex': const HexIntNConverter().toJson(instance.logIndex),
  'removed': instance.removed,
};
