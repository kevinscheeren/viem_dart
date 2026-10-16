// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionReceipt _$TransactionReceiptFromJson(Map<String, dynamic> json) =>
    _TransactionReceipt(
      transactionHash: json['transactionHash'] as String,
      transactionIndex: const HexIntConverter().fromJson(
        json['transactionIndex'] as String,
      ),
      blockHash: json['blockHash'] as String,
      blockNumber: const HexBigIntConverter().fromJson(
        json['blockNumber'] as String,
      ),
      from: json['from'] as String,
      to: json['to'] as String?,
      cumulativeGasUsed: const HexBigIntConverter().fromJson(
        json['cumulativeGasUsed'] as String,
      ),
      gasUsed: const HexBigIntConverter().fromJson(json['gasUsed'] as String),
      contractAddress: json['contractAddress'] as String?,
      logs: (json['logs'] as List<dynamic>)
          .map((e) => Log.fromJson(e as Map<String, dynamic>))
          .toList(),
      logsBloom: json['logsBloom'] as String,
      status: const HexIntNConverter().fromJson(json['status'] as String?),
      effectiveGasPrice: const HexBigIntNConverter().fromJson(
        json['effectiveGasPrice'] as String?,
      ),
      type: const HexIntNConverter().fromJson(json['type'] as String?),
    );

Map<String, dynamic> _$TransactionReceiptToJson(
  _TransactionReceipt instance,
) => <String, dynamic>{
  'transactionHash': instance.transactionHash,
  'transactionIndex': const HexIntConverter().toJson(instance.transactionIndex),
  'blockHash': instance.blockHash,
  'blockNumber': const HexBigIntConverter().toJson(instance.blockNumber),
  'from': instance.from,
  'to': instance.to,
  'cumulativeGasUsed': const HexBigIntConverter().toJson(
    instance.cumulativeGasUsed,
  ),
  'gasUsed': const HexBigIntConverter().toJson(instance.gasUsed),
  'contractAddress': instance.contractAddress,
  'logs': instance.logs.map((e) => e.toJson()).toList(),
  'logsBloom': instance.logsBloom,
  'status': const HexIntNConverter().toJson(instance.status),
  'effectiveGasPrice': const HexBigIntNConverter().toJson(
    instance.effectiveGasPrice,
  ),
  'type': const HexIntNConverter().toJson(instance.type),
};
