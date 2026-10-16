// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abi_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AbiParameter _$AbiParameterFromJson(Map<String, dynamic> json) =>
    _AbiParameter(
      name: json['name'] as String,
      type: json['type'] as String,
      components: (json['components'] as List<dynamic>?)
          ?.map((e) => AbiParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      indexed: json['indexed'] as bool?,
    );

Map<String, dynamic> _$AbiParameterToJson(_AbiParameter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'components': instance.components?.map((e) => e.toJson()).toList(),
      'indexed': instance.indexed,
    };
