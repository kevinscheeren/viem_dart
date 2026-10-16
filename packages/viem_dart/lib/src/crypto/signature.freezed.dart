// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Signature {

 BigInt get r; BigInt get s; int get yParity;
/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureCopyWith<Signature> get copyWith => _$SignatureCopyWithImpl<Signature>(this as Signature, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Signature&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s)&&(identical(other.yParity, yParity) || other.yParity == yParity));
}


@override
int get hashCode => Object.hash(runtimeType,r,s,yParity);

@override
String toString() {
  return 'Signature(r: $r, s: $s, yParity: $yParity)';
}


}

/// @nodoc
abstract mixin class $SignatureCopyWith<$Res>  {
  factory $SignatureCopyWith(Signature value, $Res Function(Signature) _then) = _$SignatureCopyWithImpl;
@useResult
$Res call({
 BigInt r, BigInt s, int yParity
});




}
/// @nodoc
class _$SignatureCopyWithImpl<$Res>
    implements $SignatureCopyWith<$Res> {
  _$SignatureCopyWithImpl(this._self, this._then);

  final Signature _self;
  final $Res Function(Signature) _then;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? r = null,Object? s = null,Object? yParity = null,}) {
  return _then(Signature(
r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt,yParity: null == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Signature].
extension SignaturePatterns on Signature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Signature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Signature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Signature value)  $default,){
final _that = this;
switch (_that) {
case _Signature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Signature value)?  $default,){
final _that = this;
switch (_that) {
case _Signature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt r,  BigInt s,  int yParity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Signature() when $default != null:
return $default(_that.r,_that.s,_that.yParity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt r,  BigInt s,  int yParity)  $default,) {final _that = this;
switch (_that) {
case _Signature():
return $default(_that.r,_that.s,_that.yParity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt r,  BigInt s,  int yParity)?  $default,) {final _that = this;
switch (_that) {
case _Signature() when $default != null:
return $default(_that.r,_that.s,_that.yParity);case _:
  return null;

}
}

}

/// @nodoc


class _Signature extends Signature {
  const _Signature({required this.r, required this.s, required this.yParity}): super._();
  

@override final  BigInt r;
@override final  BigInt s;
@override final  int yParity;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureCopyWith<_Signature> get copyWith => __$SignatureCopyWithImpl<_Signature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Signature&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s)&&(identical(other.yParity, yParity) || other.yParity == yParity));
}


@override
int get hashCode => Object.hash(runtimeType,r,s,yParity);

@override
String toString() {
  return 'Signature(r: $r, s: $s, yParity: $yParity)';
}


}

/// @nodoc
abstract mixin class _$SignatureCopyWith<$Res> implements $SignatureCopyWith<$Res> {
  factory _$SignatureCopyWith(_Signature value, $Res Function(_Signature) _then) = __$SignatureCopyWithImpl;
@override @useResult
$Res call({
 BigInt r, BigInt s, int yParity
});




}
/// @nodoc
class __$SignatureCopyWithImpl<$Res>
    implements _$SignatureCopyWith<$Res> {
  __$SignatureCopyWithImpl(this._self, this._then);

  final _Signature _self;
  final $Res Function(_Signature) _then;

/// Create a copy of Signature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? r = null,Object? s = null,Object? yParity = null,}) {
  return _then(_Signature(
r: null == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt,yParity: null == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
