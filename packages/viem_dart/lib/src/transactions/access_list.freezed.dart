// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccessListEntry {

 String get address; List<Uint8List> get storageKeys;
/// Create a copy of AccessListEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccessListEntryCopyWith<AccessListEntry> get copyWith => _$AccessListEntryCopyWithImpl<AccessListEntry>(this as AccessListEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessListEntry&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.storageKeys, storageKeys));
}


@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(storageKeys));

@override
String toString() {
  return 'AccessListEntry(address: $address, storageKeys: $storageKeys)';
}


}

/// @nodoc
abstract mixin class $AccessListEntryCopyWith<$Res>  {
  factory $AccessListEntryCopyWith(AccessListEntry value, $Res Function(AccessListEntry) _then) = _$AccessListEntryCopyWithImpl;
@useResult
$Res call({
 String address, List<Uint8List> storageKeys
});




}
/// @nodoc
class _$AccessListEntryCopyWithImpl<$Res>
    implements $AccessListEntryCopyWith<$Res> {
  _$AccessListEntryCopyWithImpl(this._self, this._then);

  final AccessListEntry _self;
  final $Res Function(AccessListEntry) _then;

/// Create a copy of AccessListEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? storageKeys = null,}) {
  return _then(AccessListEntry(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,storageKeys: null == storageKeys ? _self.storageKeys : storageKeys // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccessListEntry].
extension AccessListEntryPatterns on AccessListEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccessListEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccessListEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccessListEntry value)  $default,){
final _that = this;
switch (_that) {
case _AccessListEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccessListEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AccessListEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  List<Uint8List> storageKeys)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccessListEntry() when $default != null:
return $default(_that.address,_that.storageKeys);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  List<Uint8List> storageKeys)  $default,) {final _that = this;
switch (_that) {
case _AccessListEntry():
return $default(_that.address,_that.storageKeys);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  List<Uint8List> storageKeys)?  $default,) {final _that = this;
switch (_that) {
case _AccessListEntry() when $default != null:
return $default(_that.address,_that.storageKeys);case _:
  return null;

}
}

}

/// @nodoc


class _AccessListEntry implements AccessListEntry {
  const _AccessListEntry({required this.address, required  List<Uint8List> storageKeys}): _storageKeys = storageKeys;
  

@override final  String address;
 final  List<Uint8List> _storageKeys;
@override List<Uint8List> get storageKeys {
  if (_storageKeys is EqualUnmodifiableListView) return _storageKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storageKeys);
}


/// Create a copy of AccessListEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccessListEntryCopyWith<_AccessListEntry> get copyWith => __$AccessListEntryCopyWithImpl<_AccessListEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccessListEntry&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._storageKeys, _storageKeys));
}


@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(_storageKeys));

@override
String toString() {
  return 'AccessListEntry(address: $address, storageKeys: $storageKeys)';
}


}

/// @nodoc
abstract mixin class _$AccessListEntryCopyWith<$Res> implements $AccessListEntryCopyWith<$Res> {
  factory _$AccessListEntryCopyWith(_AccessListEntry value, $Res Function(_AccessListEntry) _then) = __$AccessListEntryCopyWithImpl;
@override @useResult
$Res call({
 String address, List<Uint8List> storageKeys
});




}
/// @nodoc
class __$AccessListEntryCopyWithImpl<$Res>
    implements _$AccessListEntryCopyWith<$Res> {
  __$AccessListEntryCopyWithImpl(this._self, this._then);

  final _AccessListEntry _self;
  final $Res Function(_AccessListEntry) _then;

/// Create a copy of AccessListEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? storageKeys = null,}) {
  return _then(_AccessListEntry(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,storageKeys: null == storageKeys ? _self._storageKeys : storageKeys // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,
  ));
}


}

// dart format on
