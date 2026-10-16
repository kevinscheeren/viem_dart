// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authorization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Authorization {

 BigInt get chainId; String get address; BigInt get nonce; int? get yParity; BigInt? get r; BigInt? get s;
/// Create a copy of Authorization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorizationCopyWith<Authorization> get copyWith => _$AuthorizationCopyWithImpl<Authorization>(this as Authorization, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authorization&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.address, address) || other.address == address)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,address,nonce,yParity,r,s);

@override
String toString() {
  return 'Authorization(chainId: $chainId, address: $address, nonce: $nonce, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $AuthorizationCopyWith<$Res>  {
  factory $AuthorizationCopyWith(Authorization value, $Res Function(Authorization) _then) = _$AuthorizationCopyWithImpl;
@useResult
$Res call({
 BigInt chainId, String address, BigInt nonce, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$AuthorizationCopyWithImpl<$Res>
    implements $AuthorizationCopyWith<$Res> {
  _$AuthorizationCopyWithImpl(this._self, this._then);

  final Authorization _self;
  final $Res Function(Authorization) _then;

/// Create a copy of Authorization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? address = null,Object? nonce = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(Authorization(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

}


/// Adds pattern-matching-related methods to [Authorization].
extension AuthorizationPatterns on Authorization {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Authorization value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Authorization() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Authorization value)  $default,){
final _that = this;
switch (_that) {
case _Authorization():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Authorization value)?  $default,){
final _that = this;
switch (_that) {
case _Authorization() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt chainId,  String address,  BigInt nonce,  int? yParity,  BigInt? r,  BigInt? s)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Authorization() when $default != null:
return $default(_that.chainId,_that.address,_that.nonce,_that.yParity,_that.r,_that.s);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt chainId,  String address,  BigInt nonce,  int? yParity,  BigInt? r,  BigInt? s)  $default,) {final _that = this;
switch (_that) {
case _Authorization():
return $default(_that.chainId,_that.address,_that.nonce,_that.yParity,_that.r,_that.s);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt chainId,  String address,  BigInt nonce,  int? yParity,  BigInt? r,  BigInt? s)?  $default,) {final _that = this;
switch (_that) {
case _Authorization() when $default != null:
return $default(_that.chainId,_that.address,_that.nonce,_that.yParity,_that.r,_that.s);case _:
  return null;

}
}

}

/// @nodoc


class _Authorization implements Authorization {
  const _Authorization({required this.chainId, required this.address, required this.nonce, this.yParity, this.r, this.s});
  

@override final  BigInt chainId;
@override final  String address;
@override final  BigInt nonce;
@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of Authorization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorizationCopyWith<_Authorization> get copyWith => __$AuthorizationCopyWithImpl<_Authorization>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authorization&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.address, address) || other.address == address)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,address,nonce,yParity,r,s);

@override
String toString() {
  return 'Authorization(chainId: $chainId, address: $address, nonce: $nonce, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class _$AuthorizationCopyWith<$Res> implements $AuthorizationCopyWith<$Res> {
  factory _$AuthorizationCopyWith(_Authorization value, $Res Function(_Authorization) _then) = __$AuthorizationCopyWithImpl;
@override @useResult
$Res call({
 BigInt chainId, String address, BigInt nonce, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class __$AuthorizationCopyWithImpl<$Res>
    implements _$AuthorizationCopyWith<$Res> {
  __$AuthorizationCopyWithImpl(this._self, this._then);

  final _Authorization _self;
  final $Res Function(_Authorization) _then;

/// Create a copy of Authorization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? address = null,Object? nonce = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(_Authorization(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

// dart format on
