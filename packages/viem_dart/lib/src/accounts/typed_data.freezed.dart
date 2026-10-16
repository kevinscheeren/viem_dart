// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typed_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Eip712Domain {

 String? get name; String? get version; BigInt? get chainId; String? get verifyingContract; Uint8List? get salt;
/// Create a copy of Eip712Domain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip712DomainCopyWith<Eip712Domain> get copyWith => _$Eip712DomainCopyWithImpl<Eip712Domain>(this as Eip712Domain, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip712Domain&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.verifyingContract, verifyingContract) || other.verifyingContract == verifyingContract)&&const DeepCollectionEquality().equals(other.salt, salt));
}


@override
int get hashCode => Object.hash(runtimeType,name,version,chainId,verifyingContract,const DeepCollectionEquality().hash(salt));

@override
String toString() {
  return 'Eip712Domain(name: $name, version: $version, chainId: $chainId, verifyingContract: $verifyingContract, salt: $salt)';
}


}

/// @nodoc
abstract mixin class $Eip712DomainCopyWith<$Res>  {
  factory $Eip712DomainCopyWith(Eip712Domain value, $Res Function(Eip712Domain) _then) = _$Eip712DomainCopyWithImpl;
@useResult
$Res call({
 String? name, String? version, BigInt? chainId, String? verifyingContract, Uint8List? salt
});




}
/// @nodoc
class _$Eip712DomainCopyWithImpl<$Res>
    implements $Eip712DomainCopyWith<$Res> {
  _$Eip712DomainCopyWithImpl(this._self, this._then);

  final Eip712Domain _self;
  final $Res Function(Eip712Domain) _then;

/// Create a copy of Eip712Domain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? version = freezed,Object? chainId = freezed,Object? verifyingContract = freezed,Object? salt = freezed,}) {
  return _then(Eip712Domain(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt?,verifyingContract: freezed == verifyingContract ? _self.verifyingContract : verifyingContract // ignore: cast_nullable_to_non_nullable
as String?,salt: freezed == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}

}


/// Adds pattern-matching-related methods to [Eip712Domain].
extension Eip712DomainPatterns on Eip712Domain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Eip712Domain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Eip712Domain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Eip712Domain value)  $default,){
final _that = this;
switch (_that) {
case _Eip712Domain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Eip712Domain value)?  $default,){
final _that = this;
switch (_that) {
case _Eip712Domain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? version,  BigInt? chainId,  String? verifyingContract,  Uint8List? salt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Eip712Domain() when $default != null:
return $default(_that.name,_that.version,_that.chainId,_that.verifyingContract,_that.salt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? version,  BigInt? chainId,  String? verifyingContract,  Uint8List? salt)  $default,) {final _that = this;
switch (_that) {
case _Eip712Domain():
return $default(_that.name,_that.version,_that.chainId,_that.verifyingContract,_that.salt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? version,  BigInt? chainId,  String? verifyingContract,  Uint8List? salt)?  $default,) {final _that = this;
switch (_that) {
case _Eip712Domain() when $default != null:
return $default(_that.name,_that.version,_that.chainId,_that.verifyingContract,_that.salt);case _:
  return null;

}
}

}

/// @nodoc


class _Eip712Domain implements Eip712Domain {
  const _Eip712Domain({this.name, this.version, this.chainId, this.verifyingContract, this.salt});
  

@override final  String? name;
@override final  String? version;
@override final  BigInt? chainId;
@override final  String? verifyingContract;
@override final  Uint8List? salt;

/// Create a copy of Eip712Domain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Eip712DomainCopyWith<_Eip712Domain> get copyWith => __$Eip712DomainCopyWithImpl<_Eip712Domain>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Eip712Domain&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.verifyingContract, verifyingContract) || other.verifyingContract == verifyingContract)&&const DeepCollectionEquality().equals(other.salt, salt));
}


@override
int get hashCode => Object.hash(runtimeType,name,version,chainId,verifyingContract,const DeepCollectionEquality().hash(salt));

@override
String toString() {
  return 'Eip712Domain(name: $name, version: $version, chainId: $chainId, verifyingContract: $verifyingContract, salt: $salt)';
}


}

/// @nodoc
abstract mixin class _$Eip712DomainCopyWith<$Res> implements $Eip712DomainCopyWith<$Res> {
  factory _$Eip712DomainCopyWith(_Eip712Domain value, $Res Function(_Eip712Domain) _then) = __$Eip712DomainCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? version, BigInt? chainId, String? verifyingContract, Uint8List? salt
});




}
/// @nodoc
class __$Eip712DomainCopyWithImpl<$Res>
    implements _$Eip712DomainCopyWith<$Res> {
  __$Eip712DomainCopyWithImpl(this._self, this._then);

  final _Eip712Domain _self;
  final $Res Function(_Eip712Domain) _then;

/// Create a copy of Eip712Domain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? version = freezed,Object? chainId = freezed,Object? verifyingContract = freezed,Object? salt = freezed,}) {
  return _then(_Eip712Domain(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt?,verifyingContract: freezed == verifyingContract ? _self.verifyingContract : verifyingContract // ignore: cast_nullable_to_non_nullable
as String?,salt: freezed == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}


}

/// @nodoc
mixin _$TypedDataField {

 String get name; String get type;
/// Create a copy of TypedDataField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypedDataFieldCopyWith<TypedDataField> get copyWith => _$TypedDataFieldCopyWithImpl<TypedDataField>(this as TypedDataField, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypedDataField&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,name,type);

@override
String toString() {
  return 'TypedDataField(name: $name, type: $type)';
}


}

/// @nodoc
abstract mixin class $TypedDataFieldCopyWith<$Res>  {
  factory $TypedDataFieldCopyWith(TypedDataField value, $Res Function(TypedDataField) _then) = _$TypedDataFieldCopyWithImpl;
@useResult
$Res call({
 String name, String type
});




}
/// @nodoc
class _$TypedDataFieldCopyWithImpl<$Res>
    implements $TypedDataFieldCopyWith<$Res> {
  _$TypedDataFieldCopyWithImpl(this._self, this._then);

  final TypedDataField _self;
  final $Res Function(TypedDataField) _then;

/// Create a copy of TypedDataField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,}) {
  return _then(TypedDataField(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TypedDataField].
extension TypedDataFieldPatterns on TypedDataField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypedDataField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypedDataField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypedDataField value)  $default,){
final _that = this;
switch (_that) {
case _TypedDataField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypedDataField value)?  $default,){
final _that = this;
switch (_that) {
case _TypedDataField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypedDataField() when $default != null:
return $default(_that.name,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String type)  $default,) {final _that = this;
switch (_that) {
case _TypedDataField():
return $default(_that.name,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String type)?  $default,) {final _that = this;
switch (_that) {
case _TypedDataField() when $default != null:
return $default(_that.name,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _TypedDataField implements TypedDataField {
  const _TypedDataField({required this.name, required this.type});
  

@override final  String name;
@override final  String type;

/// Create a copy of TypedDataField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypedDataFieldCopyWith<_TypedDataField> get copyWith => __$TypedDataFieldCopyWithImpl<_TypedDataField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypedDataField&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,name,type);

@override
String toString() {
  return 'TypedDataField(name: $name, type: $type)';
}


}

/// @nodoc
abstract mixin class _$TypedDataFieldCopyWith<$Res> implements $TypedDataFieldCopyWith<$Res> {
  factory _$TypedDataFieldCopyWith(_TypedDataField value, $Res Function(_TypedDataField) _then) = __$TypedDataFieldCopyWithImpl;
@override @useResult
$Res call({
 String name, String type
});




}
/// @nodoc
class __$TypedDataFieldCopyWithImpl<$Res>
    implements _$TypedDataFieldCopyWith<$Res> {
  __$TypedDataFieldCopyWithImpl(this._self, this._then);

  final _TypedDataField _self;
  final $Res Function(_TypedDataField) _then;

/// Create a copy of TypedDataField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,}) {
  return _then(_TypedDataField(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
