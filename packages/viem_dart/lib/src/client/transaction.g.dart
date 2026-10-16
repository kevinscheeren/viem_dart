// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
  hash: json['hash'] as String,
  nonce: const HexIntConverter().fromJson(json['nonce'] as String),
  blockHash: json['blockHash'] as String?,
  blockNumber: const HexBigIntNConverter().fromJson(
    json['blockNumber'] as String?,
  ),
  transactionIndex: const HexIntNConverter().fromJson(
    json['transactionIndex'] as String?,
  ),
  from: json['from'] as String,
  to: json['to'] as String?,
  value: const HexBigIntConverter().fromJson(json['value'] as String),
  gas: const HexBigIntConverter().fromJson(json['gas'] as String),
  gasPrice: const HexBigIntNConverter().fromJson(json['gasPrice'] as String?),
  maxFeePerGas: const HexBigIntNConverter().fromJson(
    json['maxFeePerGas'] as String?,
  ),
  maxPriorityFeePerGas: const HexBigIntNConverter().fromJson(
    json['maxPriorityFeePerGas'] as String?,
  ),
  input: json['input'] as String,
  type: const HexIntNConverter().fromJson(json['type'] as String?),
  chainId: const HexBigIntNConverter().fromJson(json['chainId'] as String?),
  v: json['v'] as String?,
  r: json['r'] as String?,
  s: json['s'] as String?,
  accessList: json['accessList'] as List<dynamic>?,
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'nonce': const HexIntConverter().toJson(instance.nonce),
      'blockHash': instance.blockHash,
      'blockNumber': const HexBigIntNConverter().toJson(instance.blockNumber),
      'transactionIndex': const HexIntNConverter().toJson(
        instance.transactionIndex,
      ),
      'from': instance.from,
      'to': instance.to,
      'value': const HexBigIntConverter().toJson(instance.value),
      'gas': const HexBigIntConverter().toJson(instance.gas),
      'gasPrice': const HexBigIntNConverter().toJson(instance.gasPrice),
      'maxFeePerGas': const HexBigIntNConverter().toJson(instance.maxFeePerGas),
      'maxPriorityFeePerGas': const HexBigIntNConverter().toJson(
        instance.maxPriorityFeePerGas,
      ),
      'input': instance.input,
      'type': const HexIntNConverter().toJson(instance.type),
      'chainId': const HexBigIntNConverter().toJson(instance.chainId),
      'v': instance.v,
      'r': instance.r,
      's': instance.s,
      'accessList': instance.accessList,
    };
