// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Block _$BlockFromJson(Map<String, dynamic> json) => _Block(
  number: const HexBigIntNConverter().fromJson(json['number'] as String?),
  hash: json['hash'] as String?,
  parentHash: json['parentHash'] as String,
  nonce: json['nonce'] as String?,
  sha3Uncles: json['sha3Uncles'] as String,
  logsBloom: json['logsBloom'] as String?,
  transactionsRoot: json['transactionsRoot'] as String,
  stateRoot: json['stateRoot'] as String,
  receiptsRoot: json['receiptsRoot'] as String,
  miner: json['miner'] as String,
  difficulty: const HexBigIntConverter().fromJson(json['difficulty'] as String),
  totalDifficulty: const HexBigIntNConverter().fromJson(
    json['totalDifficulty'] as String?,
  ),
  extraData: json['extraData'] as String,
  size: const HexBigIntConverter().fromJson(json['size'] as String),
  gasLimit: const HexBigIntConverter().fromJson(json['gasLimit'] as String),
  gasUsed: const HexBigIntConverter().fromJson(json['gasUsed'] as String),
  timestamp: const HexBigIntConverter().fromJson(json['timestamp'] as String),
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  uncles: (json['uncles'] as List<dynamic>).map((e) => e as String).toList(),
  baseFeePerGas: const HexBigIntNConverter().fromJson(
    json['baseFeePerGas'] as String?,
  ),
  mixHash: json['mixHash'] as String?,
  withdrawalsRoot: json['withdrawalsRoot'] as String?,
  blobGasUsed: const HexBigIntNConverter().fromJson(
    json['blobGasUsed'] as String?,
  ),
  excessBlobGasUsed: const HexBigIntNConverter().fromJson(
    json['excessBlobGasUsed'] as String?,
  ),
);

Map<String, dynamic> _$BlockToJson(_Block instance) => <String, dynamic>{
  'number': const HexBigIntNConverter().toJson(instance.number),
  'hash': instance.hash,
  'parentHash': instance.parentHash,
  'nonce': instance.nonce,
  'sha3Uncles': instance.sha3Uncles,
  'logsBloom': instance.logsBloom,
  'transactionsRoot': instance.transactionsRoot,
  'stateRoot': instance.stateRoot,
  'receiptsRoot': instance.receiptsRoot,
  'miner': instance.miner,
  'difficulty': const HexBigIntConverter().toJson(instance.difficulty),
  'totalDifficulty': const HexBigIntNConverter().toJson(
    instance.totalDifficulty,
  ),
  'extraData': instance.extraData,
  'size': const HexBigIntConverter().toJson(instance.size),
  'gasLimit': const HexBigIntConverter().toJson(instance.gasLimit),
  'gasUsed': const HexBigIntConverter().toJson(instance.gasUsed),
  'timestamp': const HexBigIntConverter().toJson(instance.timestamp),
  'transactions': instance.transactions,
  'uncles': instance.uncles,
  'baseFeePerGas': const HexBigIntNConverter().toJson(instance.baseFeePerGas),
  'mixHash': instance.mixHash,
  'withdrawalsRoot': instance.withdrawalsRoot,
  'blobGasUsed': const HexBigIntNConverter().toJson(instance.blobGasUsed),
  'excessBlobGasUsed': const HexBigIntNConverter().toJson(
    instance.excessBlobGasUsed,
  ),
};
