// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SiweMessage {

 String? get address; int? get chainId; String? get domain; DateTime? get expirationTime; DateTime? get issuedAt; String? get nonce; DateTime? get notBefore; String? get requestId; List<String>? get resources; String? get scheme; String? get statement; String? get uri; String? get version;
/// Create a copy of SiweMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiweMessageCopyWith<SiweMessage> get copyWith => _$SiweMessageCopyWithImpl<SiweMessage>(this as SiweMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiweMessage&&(identical(other.address, address) || other.address == address)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.expirationTime, expirationTime) || other.expirationTime == expirationTime)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.notBefore, notBefore) || other.notBefore == notBefore)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,address,chainId,domain,expirationTime,issuedAt,nonce,notBefore,requestId,const DeepCollectionEquality().hash(resources),scheme,statement,uri,version);

@override
String toString() {
  return 'SiweMessage(address: $address, chainId: $chainId, domain: $domain, expirationTime: $expirationTime, issuedAt: $issuedAt, nonce: $nonce, notBefore: $notBefore, requestId: $requestId, resources: $resources, scheme: $scheme, statement: $statement, uri: $uri, version: $version)';
}


}

/// @nodoc
abstract mixin class $SiweMessageCopyWith<$Res>  {
  factory $SiweMessageCopyWith(SiweMessage value, $Res Function(SiweMessage) _then) = _$SiweMessageCopyWithImpl;
@useResult
$Res call({
 String? address, int? chainId, String? domain, DateTime? expirationTime, DateTime? issuedAt, String? nonce, DateTime? notBefore, String? requestId, List<String>? resources, String? scheme, String? statement, String? uri, String? version
});




}
/// @nodoc
class _$SiweMessageCopyWithImpl<$Res>
    implements $SiweMessageCopyWith<$Res> {
  _$SiweMessageCopyWithImpl(this._self, this._then);

  final SiweMessage _self;
  final $Res Function(SiweMessage) _then;

/// Create a copy of SiweMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = freezed,Object? chainId = freezed,Object? domain = freezed,Object? expirationTime = freezed,Object? issuedAt = freezed,Object? nonce = freezed,Object? notBefore = freezed,Object? requestId = freezed,Object? resources = freezed,Object? scheme = freezed,Object? statement = freezed,Object? uri = freezed,Object? version = freezed,}) {
  return _then(SiweMessage(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String?,expirationTime: freezed == expirationTime ? _self.expirationTime : expirationTime // ignore: cast_nullable_to_non_nullable
as DateTime?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,notBefore: freezed == notBefore ? _self.notBefore : notBefore // ignore: cast_nullable_to_non_nullable
as DateTime?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,scheme: freezed == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SiweMessage].
extension SiweMessagePatterns on SiweMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SiweMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SiweMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SiweMessage value)  $default,){
final _that = this;
switch (_that) {
case _SiweMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SiweMessage value)?  $default,){
final _that = this;
switch (_that) {
case _SiweMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? address,  int? chainId,  String? domain,  DateTime? expirationTime,  DateTime? issuedAt,  String? nonce,  DateTime? notBefore,  String? requestId,  List<String>? resources,  String? scheme,  String? statement,  String? uri,  String? version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SiweMessage() when $default != null:
return $default(_that.address,_that.chainId,_that.domain,_that.expirationTime,_that.issuedAt,_that.nonce,_that.notBefore,_that.requestId,_that.resources,_that.scheme,_that.statement,_that.uri,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? address,  int? chainId,  String? domain,  DateTime? expirationTime,  DateTime? issuedAt,  String? nonce,  DateTime? notBefore,  String? requestId,  List<String>? resources,  String? scheme,  String? statement,  String? uri,  String? version)  $default,) {final _that = this;
switch (_that) {
case _SiweMessage():
return $default(_that.address,_that.chainId,_that.domain,_that.expirationTime,_that.issuedAt,_that.nonce,_that.notBefore,_that.requestId,_that.resources,_that.scheme,_that.statement,_that.uri,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? address,  int? chainId,  String? domain,  DateTime? expirationTime,  DateTime? issuedAt,  String? nonce,  DateTime? notBefore,  String? requestId,  List<String>? resources,  String? scheme,  String? statement,  String? uri,  String? version)?  $default,) {final _that = this;
switch (_that) {
case _SiweMessage() when $default != null:
return $default(_that.address,_that.chainId,_that.domain,_that.expirationTime,_that.issuedAt,_that.nonce,_that.notBefore,_that.requestId,_that.resources,_that.scheme,_that.statement,_that.uri,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _SiweMessage implements SiweMessage {
  const _SiweMessage({this.address, this.chainId, this.domain, this.expirationTime, this.issuedAt, this.nonce, this.notBefore, this.requestId,  List<String>? resources, this.scheme, this.statement, this.uri, this.version}): _resources = resources;
  

@override final  String? address;
@override final  int? chainId;
@override final  String? domain;
@override final  DateTime? expirationTime;
@override final  DateTime? issuedAt;
@override final  String? nonce;
@override final  DateTime? notBefore;
@override final  String? requestId;
 final  List<String>? _resources;
@override List<String>? get resources {
  final value = _resources;
  if (value == null) return null;
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? scheme;
@override final  String? statement;
@override final  String? uri;
@override final  String? version;

/// Create a copy of SiweMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SiweMessageCopyWith<_SiweMessage> get copyWith => __$SiweMessageCopyWithImpl<_SiweMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SiweMessage&&(identical(other.address, address) || other.address == address)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.expirationTime, expirationTime) || other.expirationTime == expirationTime)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.notBefore, notBefore) || other.notBefore == notBefore)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,address,chainId,domain,expirationTime,issuedAt,nonce,notBefore,requestId,const DeepCollectionEquality().hash(_resources),scheme,statement,uri,version);

@override
String toString() {
  return 'SiweMessage(address: $address, chainId: $chainId, domain: $domain, expirationTime: $expirationTime, issuedAt: $issuedAt, nonce: $nonce, notBefore: $notBefore, requestId: $requestId, resources: $resources, scheme: $scheme, statement: $statement, uri: $uri, version: $version)';
}


}

/// @nodoc
abstract mixin class _$SiweMessageCopyWith<$Res> implements $SiweMessageCopyWith<$Res> {
  factory _$SiweMessageCopyWith(_SiweMessage value, $Res Function(_SiweMessage) _then) = __$SiweMessageCopyWithImpl;
@override @useResult
$Res call({
 String? address, int? chainId, String? domain, DateTime? expirationTime, DateTime? issuedAt, String? nonce, DateTime? notBefore, String? requestId, List<String>? resources, String? scheme, String? statement, String? uri, String? version
});




}
/// @nodoc
class __$SiweMessageCopyWithImpl<$Res>
    implements _$SiweMessageCopyWith<$Res> {
  __$SiweMessageCopyWithImpl(this._self, this._then);

  final _SiweMessage _self;
  final $Res Function(_SiweMessage) _then;

/// Create a copy of SiweMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = freezed,Object? chainId = freezed,Object? domain = freezed,Object? expirationTime = freezed,Object? issuedAt = freezed,Object? nonce = freezed,Object? notBefore = freezed,Object? requestId = freezed,Object? resources = freezed,Object? scheme = freezed,Object? statement = freezed,Object? uri = freezed,Object? version = freezed,}) {
  return _then(_SiweMessage(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as int?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String?,expirationTime: freezed == expirationTime ? _self.expirationTime : expirationTime // ignore: cast_nullable_to_non_nullable
as DateTime?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,notBefore: freezed == notBefore ? _self.notBefore : notBefore // ignore: cast_nullable_to_non_nullable
as DateTime?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,scheme: freezed == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
