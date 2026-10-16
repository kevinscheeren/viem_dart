// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Account {

 String get address;
/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCopyWith<Account> get copyWith => _$AccountCopyWithImpl<Account>(this as Account, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Account&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,address);

@override
String toString() {
  return 'Account(address: $address)';
}


}

/// @nodoc
abstract mixin class $AccountCopyWith<$Res>  {
  factory $AccountCopyWith(Account value, $Res Function(Account) _then) = _$AccountCopyWithImpl;
@useResult
$Res call({
 String address
});




}
/// @nodoc
class _$AccountCopyWithImpl<$Res>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._self, this._then);

  final Account _self;
  final $Res Function(Account) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Account].
extension AccountPatterns on Account {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocalAccount value)?  local,TResult Function( JsonRpcAccount value)?  jsonRpc,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocalAccount() when local != null:
return local(_that);case JsonRpcAccount() when jsonRpc != null:
return jsonRpc(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocalAccount value)  local,required TResult Function( JsonRpcAccount value)  jsonRpc,}){
final _that = this;
switch (_that) {
case LocalAccount():
return local(_that);case JsonRpcAccount():
return jsonRpc(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocalAccount value)?  local,TResult? Function( JsonRpcAccount value)?  jsonRpc,}){
final _that = this;
switch (_that) {
case LocalAccount() when local != null:
return local(_that);case JsonRpcAccount() when jsonRpc != null:
return jsonRpc(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String address,  Uint8List privateKey)?  local,TResult Function( String address)?  jsonRpc,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocalAccount() when local != null:
return local(_that.address,_that.privateKey);case JsonRpcAccount() when jsonRpc != null:
return jsonRpc(_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String address,  Uint8List privateKey)  local,required TResult Function( String address)  jsonRpc,}) {final _that = this;
switch (_that) {
case LocalAccount():
return local(_that.address,_that.privateKey);case JsonRpcAccount():
return jsonRpc(_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String address,  Uint8List privateKey)?  local,TResult? Function( String address)?  jsonRpc,}) {final _that = this;
switch (_that) {
case LocalAccount() when local != null:
return local(_that.address,_that.privateKey);case JsonRpcAccount() when jsonRpc != null:
return jsonRpc(_that.address);case _:
  return null;

}
}

}

/// @nodoc


class LocalAccount implements Account {
  const LocalAccount({required this.address, required this.privateKey});
  

@override final  String address;
 final  Uint8List privateKey;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalAccountCopyWith<LocalAccount> get copyWith => _$LocalAccountCopyWithImpl<LocalAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalAccount&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.privateKey, privateKey));
}


@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(privateKey));

@override
String toString() {
  return 'Account.local(address: $address, privateKey: $privateKey)';
}


}

/// @nodoc
abstract mixin class $LocalAccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory $LocalAccountCopyWith(LocalAccount value, $Res Function(LocalAccount) _then) = _$LocalAccountCopyWithImpl;
@override @useResult
$Res call({
 String address, Uint8List privateKey
});




}
/// @nodoc
class _$LocalAccountCopyWithImpl<$Res>
    implements $LocalAccountCopyWith<$Res> {
  _$LocalAccountCopyWithImpl(this._self, this._then);

  final LocalAccount _self;
  final $Res Function(LocalAccount) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? privateKey = null,}) {
  return _then(LocalAccount(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,privateKey: null == privateKey ? _self.privateKey : privateKey // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class JsonRpcAccount implements Account {
  const JsonRpcAccount({required this.address});
  

@override final  String address;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcAccountCopyWith<JsonRpcAccount> get copyWith => _$JsonRpcAccountCopyWithImpl<JsonRpcAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcAccount&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,address);

@override
String toString() {
  return 'Account.jsonRpc(address: $address)';
}


}

/// @nodoc
abstract mixin class $JsonRpcAccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory $JsonRpcAccountCopyWith(JsonRpcAccount value, $Res Function(JsonRpcAccount) _then) = _$JsonRpcAccountCopyWithImpl;
@override @useResult
$Res call({
 String address
});




}
/// @nodoc
class _$JsonRpcAccountCopyWithImpl<$Res>
    implements $JsonRpcAccountCopyWith<$Res> {
  _$JsonRpcAccountCopyWithImpl(this._self, this._then);

  final JsonRpcAccount _self;
  final $Res Function(JsonRpcAccount) _then;

/// Create a copy of Account
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,}) {
  return _then(JsonRpcAccount(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
