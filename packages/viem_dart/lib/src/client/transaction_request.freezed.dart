// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionRequest {

 String get from; String? get to; BigInt? get value; String? get data; int get nonce; BigInt get gas; BigInt? get maxFeePerGas; BigInt? get maxPriorityFeePerGas; BigInt? get gasPrice; BigInt get chainId;
/// Create a copy of TransactionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRequestCopyWith<TransactionRequest> get copyWith => _$TransactionRequestCopyWithImpl<TransactionRequest>(this as TransactionRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRequest&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.data, data) || other.data == data)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.chainId, chainId) || other.chainId == chainId));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,value,data,nonce,gas,maxFeePerGas,maxPriorityFeePerGas,gasPrice,chainId);

@override
String toString() {
  return 'TransactionRequest(from: $from, to: $to, value: $value, data: $data, nonce: $nonce, gas: $gas, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, gasPrice: $gasPrice, chainId: $chainId)';
}


}

/// @nodoc
abstract mixin class $TransactionRequestCopyWith<$Res>  {
  factory $TransactionRequestCopyWith(TransactionRequest value, $Res Function(TransactionRequest) _then) = _$TransactionRequestCopyWithImpl;
@useResult
$Res call({
 String from, String? to, BigInt? value, String? data, int nonce, BigInt gas, BigInt? maxFeePerGas, BigInt? maxPriorityFeePerGas, BigInt? gasPrice, BigInt chainId
});




}
/// @nodoc
class _$TransactionRequestCopyWithImpl<$Res>
    implements $TransactionRequestCopyWith<$Res> {
  _$TransactionRequestCopyWithImpl(this._self, this._then);

  final TransactionRequest _self;
  final $Res Function(TransactionRequest) _then;

/// Create a copy of TransactionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = freezed,Object? value = freezed,Object? data = freezed,Object? nonce = null,Object? gas = null,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? gasPrice = freezed,Object? chainId = null,}) {
  return _then(TransactionRequest(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as int,gas: null == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as BigInt,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRequest].
extension TransactionRequestPatterns on TransactionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionRequest value)  $default,){
final _that = this;
switch (_that) {
case _TransactionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String? to,  BigInt? value,  String? data,  int nonce,  BigInt gas,  BigInt? maxFeePerGas,  BigInt? maxPriorityFeePerGas,  BigInt? gasPrice,  BigInt chainId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionRequest() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.data,_that.nonce,_that.gas,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.gasPrice,_that.chainId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String? to,  BigInt? value,  String? data,  int nonce,  BigInt gas,  BigInt? maxFeePerGas,  BigInt? maxPriorityFeePerGas,  BigInt? gasPrice,  BigInt chainId)  $default,) {final _that = this;
switch (_that) {
case _TransactionRequest():
return $default(_that.from,_that.to,_that.value,_that.data,_that.nonce,_that.gas,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.gasPrice,_that.chainId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String? to,  BigInt? value,  String? data,  int nonce,  BigInt gas,  BigInt? maxFeePerGas,  BigInt? maxPriorityFeePerGas,  BigInt? gasPrice,  BigInt chainId)?  $default,) {final _that = this;
switch (_that) {
case _TransactionRequest() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.data,_that.nonce,_that.gas,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.gasPrice,_that.chainId);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionRequest implements TransactionRequest {
  const _TransactionRequest({required this.from, this.to, this.value, this.data, required this.nonce, required this.gas, this.maxFeePerGas, this.maxPriorityFeePerGas, this.gasPrice, required this.chainId});
  

@override final  String from;
@override final  String? to;
@override final  BigInt? value;
@override final  String? data;
@override final  int nonce;
@override final  BigInt gas;
@override final  BigInt? maxFeePerGas;
@override final  BigInt? maxPriorityFeePerGas;
@override final  BigInt? gasPrice;
@override final  BigInt chainId;

/// Create a copy of TransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionRequestCopyWith<_TransactionRequest> get copyWith => __$TransactionRequestCopyWithImpl<_TransactionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionRequest&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.data, data) || other.data == data)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.chainId, chainId) || other.chainId == chainId));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,value,data,nonce,gas,maxFeePerGas,maxPriorityFeePerGas,gasPrice,chainId);

@override
String toString() {
  return 'TransactionRequest(from: $from, to: $to, value: $value, data: $data, nonce: $nonce, gas: $gas, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, gasPrice: $gasPrice, chainId: $chainId)';
}


}

/// @nodoc
abstract mixin class _$TransactionRequestCopyWith<$Res> implements $TransactionRequestCopyWith<$Res> {
  factory _$TransactionRequestCopyWith(_TransactionRequest value, $Res Function(_TransactionRequest) _then) = __$TransactionRequestCopyWithImpl;
@override @useResult
$Res call({
 String from, String? to, BigInt? value, String? data, int nonce, BigInt gas, BigInt? maxFeePerGas, BigInt? maxPriorityFeePerGas, BigInt? gasPrice, BigInt chainId
});




}
/// @nodoc
class __$TransactionRequestCopyWithImpl<$Res>
    implements _$TransactionRequestCopyWith<$Res> {
  __$TransactionRequestCopyWithImpl(this._self, this._then);

  final _TransactionRequest _self;
  final $Res Function(_TransactionRequest) _then;

/// Create a copy of TransactionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = freezed,Object? value = freezed,Object? data = freezed,Object? nonce = null,Object? gas = null,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? gasPrice = freezed,Object? chainId = null,}) {
  return _then(_TransactionRequest(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as int,gas: null == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as BigInt,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}

// dart format on
