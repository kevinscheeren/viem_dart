// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) =>
    _JsonRpcRequest(
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      id: (json['id'] as num).toInt(),
      method: json['method'] as String,
      params: json['params'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$JsonRpcRequestToJson(_JsonRpcRequest instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'method': instance.method,
      'params': instance.params,
    };

_JsonRpcErrorPayload _$JsonRpcErrorPayloadFromJson(Map<String, dynamic> json) =>
    _JsonRpcErrorPayload(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$JsonRpcErrorPayloadToJson(
  _JsonRpcErrorPayload instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': instance.data,
};

_JsonRpcResponse _$JsonRpcResponseFromJson(Map<String, dynamic> json) =>
    _JsonRpcResponse(
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      id: (json['id'] as num?)?.toInt(),
      result: json['result'],
      error: json['error'] == null
          ? null
          : JsonRpcErrorPayload.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonRpcResponseToJson(_JsonRpcResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result,
      'error': instance.error?.toJson(),
    };
