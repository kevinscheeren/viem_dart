// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JsonRpcRequest {

 String get jsonrpc; int get id; String get method; List<Object?> get params;
/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcRequestCopyWith<JsonRpcRequest> get copyWith => _$JsonRpcRequestCopyWithImpl<JsonRpcRequest>(this as JsonRpcRequest, _$identity);

  /// Serializes this JsonRpcRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcRequest&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.id, id) || other.id == id)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jsonrpc,id,method,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'JsonRpcRequest(jsonrpc: $jsonrpc, id: $id, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $JsonRpcRequestCopyWith<$Res>  {
  factory $JsonRpcRequestCopyWith(JsonRpcRequest value, $Res Function(JsonRpcRequest) _then) = _$JsonRpcRequestCopyWithImpl;
@useResult
$Res call({
 String jsonrpc, int id, String method, List<Object?> params
});




}
/// @nodoc
class _$JsonRpcRequestCopyWithImpl<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  _$JsonRpcRequestCopyWithImpl(this._self, this._then);

  final JsonRpcRequest _self;
  final $Res Function(JsonRpcRequest) _then;

/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jsonrpc = null,Object? id = null,Object? method = null,Object? params = null,}) {
  return _then(JsonRpcRequest(
jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as List<Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonRpcRequest].
extension JsonRpcRequestPatterns on JsonRpcRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcRequest value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcRequest value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String jsonrpc,  int id,  String method,  List<Object?> params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that.jsonrpc,_that.id,_that.method,_that.params);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String jsonrpc,  int id,  String method,  List<Object?> params)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRequest():
return $default(_that.jsonrpc,_that.id,_that.method,_that.params);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String jsonrpc,  int id,  String method,  List<Object?> params)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that.jsonrpc,_that.id,_that.method,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JsonRpcRequest implements JsonRpcRequest {
  const _JsonRpcRequest({this.jsonrpc = '2.0', required this.id, required this.method,  List<Object?> params = const []}): _params = params;
  factory _JsonRpcRequest.fromJson(Map<String, dynamic> json) => _$JsonRpcRequestFromJson(json);

@override@JsonKey() final  String jsonrpc;
@override final  int id;
@override final  String method;
 final  List<Object?> _params;
@override@JsonKey() List<Object?> get params {
  if (_params is EqualUnmodifiableListView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_params);
}


/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcRequestCopyWith<_JsonRpcRequest> get copyWith => __$JsonRpcRequestCopyWithImpl<_JsonRpcRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcRequest&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.id, id) || other.id == id)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jsonrpc,id,method,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'JsonRpcRequest(jsonrpc: $jsonrpc, id: $id, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcRequestCopyWith<$Res> implements $JsonRpcRequestCopyWith<$Res> {
  factory _$JsonRpcRequestCopyWith(_JsonRpcRequest value, $Res Function(_JsonRpcRequest) _then) = __$JsonRpcRequestCopyWithImpl;
@override @useResult
$Res call({
 String jsonrpc, int id, String method, List<Object?> params
});




}
/// @nodoc
class __$JsonRpcRequestCopyWithImpl<$Res>
    implements _$JsonRpcRequestCopyWith<$Res> {
  __$JsonRpcRequestCopyWithImpl(this._self, this._then);

  final _JsonRpcRequest _self;
  final $Res Function(_JsonRpcRequest) _then;

/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jsonrpc = null,Object? id = null,Object? method = null,Object? params = null,}) {
  return _then(_JsonRpcRequest(
jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as List<Object?>,
  ));
}


}


/// @nodoc
mixin _$JsonRpcErrorPayload {

 int get code; String get message; Object? get data;
/// Create a copy of JsonRpcErrorPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcErrorPayloadCopyWith<JsonRpcErrorPayload> get copyWith => _$JsonRpcErrorPayloadCopyWithImpl<JsonRpcErrorPayload>(this as JsonRpcErrorPayload, _$identity);

  /// Serializes this JsonRpcErrorPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcErrorPayload&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'JsonRpcErrorPayload(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $JsonRpcErrorPayloadCopyWith<$Res>  {
  factory $JsonRpcErrorPayloadCopyWith(JsonRpcErrorPayload value, $Res Function(JsonRpcErrorPayload) _then) = _$JsonRpcErrorPayloadCopyWithImpl;
@useResult
$Res call({
 int code, String message, Object? data
});




}
/// @nodoc
class _$JsonRpcErrorPayloadCopyWithImpl<$Res>
    implements $JsonRpcErrorPayloadCopyWith<$Res> {
  _$JsonRpcErrorPayloadCopyWithImpl(this._self, this._then);

  final JsonRpcErrorPayload _self;
  final $Res Function(JsonRpcErrorPayload) _then;

/// Create a copy of JsonRpcErrorPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(JsonRpcErrorPayload(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data ,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonRpcErrorPayload].
extension JsonRpcErrorPayloadPatterns on JsonRpcErrorPayload {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcErrorPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcErrorPayload() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcErrorPayload value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcErrorPayload():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcErrorPayload value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcErrorPayload() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  Object? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcErrorPayload() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  Object? data)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcErrorPayload():
return $default(_that.code,_that.message,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  Object? data)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcErrorPayload() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JsonRpcErrorPayload implements JsonRpcErrorPayload {
  const _JsonRpcErrorPayload({required this.code, required this.message, this.data});
  factory _JsonRpcErrorPayload.fromJson(Map<String, dynamic> json) => _$JsonRpcErrorPayloadFromJson(json);

@override final  int code;
@override final  String message;
@override final  Object? data;

/// Create a copy of JsonRpcErrorPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcErrorPayloadCopyWith<_JsonRpcErrorPayload> get copyWith => __$JsonRpcErrorPayloadCopyWithImpl<_JsonRpcErrorPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcErrorPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcErrorPayload&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'JsonRpcErrorPayload(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcErrorPayloadCopyWith<$Res> implements $JsonRpcErrorPayloadCopyWith<$Res> {
  factory _$JsonRpcErrorPayloadCopyWith(_JsonRpcErrorPayload value, $Res Function(_JsonRpcErrorPayload) _then) = __$JsonRpcErrorPayloadCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, Object? data
});




}
/// @nodoc
class __$JsonRpcErrorPayloadCopyWithImpl<$Res>
    implements _$JsonRpcErrorPayloadCopyWith<$Res> {
  __$JsonRpcErrorPayloadCopyWithImpl(this._self, this._then);

  final _JsonRpcErrorPayload _self;
  final $Res Function(_JsonRpcErrorPayload) _then;

/// Create a copy of JsonRpcErrorPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_JsonRpcErrorPayload(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data ,
  ));
}


}


/// @nodoc
mixin _$JsonRpcResponse {

 String get jsonrpc; int? get id; Object? get result; JsonRpcErrorPayload? get error;
/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcResponseCopyWith<JsonRpcResponse> get copyWith => _$JsonRpcResponseCopyWithImpl<JsonRpcResponse>(this as JsonRpcResponse, _$identity);

  /// Serializes this JsonRpcResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcResponse&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jsonrpc,id,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'JsonRpcResponse(jsonrpc: $jsonrpc, id: $id, result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class $JsonRpcResponseCopyWith<$Res>  {
  factory $JsonRpcResponseCopyWith(JsonRpcResponse value, $Res Function(JsonRpcResponse) _then) = _$JsonRpcResponseCopyWithImpl;
@useResult
$Res call({
 String jsonrpc, int? id, Object? result, JsonRpcErrorPayload? error
});


$JsonRpcErrorPayloadCopyWith<$Res>? get error;

}
/// @nodoc
class _$JsonRpcResponseCopyWithImpl<$Res>
    implements $JsonRpcResponseCopyWith<$Res> {
  _$JsonRpcResponseCopyWithImpl(this._self, this._then);

  final JsonRpcResponse _self;
  final $Res Function(JsonRpcResponse) _then;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jsonrpc = null,Object? id = freezed,Object? result = freezed,Object? error = freezed,}) {
  return _then(JsonRpcResponse(
jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self.result : result ,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as JsonRpcErrorPayload?,
  ));
}
/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JsonRpcErrorPayloadCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $JsonRpcErrorPayloadCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [JsonRpcResponse].
extension JsonRpcResponsePatterns on JsonRpcResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcResponse value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String jsonrpc,  int? id,  Object? result,  JsonRpcErrorPayload? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that.jsonrpc,_that.id,_that.result,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String jsonrpc,  int? id,  Object? result,  JsonRpcErrorPayload? error)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcResponse():
return $default(_that.jsonrpc,_that.id,_that.result,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String jsonrpc,  int? id,  Object? result,  JsonRpcErrorPayload? error)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that.jsonrpc,_that.id,_that.result,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JsonRpcResponse implements JsonRpcResponse {
  const _JsonRpcResponse({this.jsonrpc = '2.0', required this.id, this.result, this.error});
  factory _JsonRpcResponse.fromJson(Map<String, dynamic> json) => _$JsonRpcResponseFromJson(json);

@override@JsonKey() final  String jsonrpc;
@override final  int? id;
@override final  Object? result;
@override final  JsonRpcErrorPayload? error;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcResponseCopyWith<_JsonRpcResponse> get copyWith => __$JsonRpcResponseCopyWithImpl<_JsonRpcResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcResponse&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jsonrpc,id,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'JsonRpcResponse(jsonrpc: $jsonrpc, id: $id, result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcResponseCopyWith<$Res> implements $JsonRpcResponseCopyWith<$Res> {
  factory _$JsonRpcResponseCopyWith(_JsonRpcResponse value, $Res Function(_JsonRpcResponse) _then) = __$JsonRpcResponseCopyWithImpl;
@override @useResult
$Res call({
 String jsonrpc, int? id, Object? result, JsonRpcErrorPayload? error
});


@override $JsonRpcErrorPayloadCopyWith<$Res>? get error;

}
/// @nodoc
class __$JsonRpcResponseCopyWithImpl<$Res>
    implements _$JsonRpcResponseCopyWith<$Res> {
  __$JsonRpcResponseCopyWithImpl(this._self, this._then);

  final _JsonRpcResponse _self;
  final $Res Function(_JsonRpcResponse) _then;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jsonrpc = null,Object? id = freezed,Object? result = freezed,Object? error = freezed,}) {
  return _then(_JsonRpcResponse(
jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self.result : result ,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as JsonRpcErrorPayload?,
  ));
}

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JsonRpcErrorPayloadCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $JsonRpcErrorPayloadCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
