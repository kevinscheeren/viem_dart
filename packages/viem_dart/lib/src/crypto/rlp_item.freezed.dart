// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rlp_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RlpItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RlpItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RlpItem()';
}


}

/// @nodoc
class $RlpItemCopyWith<$Res>  {
$RlpItemCopyWith(RlpItem _, $Res Function(RlpItem) __);
}


/// Adds pattern-matching-related methods to [RlpItem].
extension RlpItemPatterns on RlpItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RlpBytes value)?  bytes,TResult Function( RlpList value)?  list,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RlpBytes() when bytes != null:
return bytes(_that);case RlpList() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RlpBytes value)  bytes,required TResult Function( RlpList value)  list,}){
final _that = this;
switch (_that) {
case RlpBytes():
return bytes(_that);case RlpList():
return list(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RlpBytes value)?  bytes,TResult? Function( RlpList value)?  list,}){
final _that = this;
switch (_that) {
case RlpBytes() when bytes != null:
return bytes(_that);case RlpList() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Uint8List data)?  bytes,TResult Function( List<RlpItem> items)?  list,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RlpBytes() when bytes != null:
return bytes(_that.data);case RlpList() when list != null:
return list(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Uint8List data)  bytes,required TResult Function( List<RlpItem> items)  list,}) {final _that = this;
switch (_that) {
case RlpBytes():
return bytes(_that.data);case RlpList():
return list(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Uint8List data)?  bytes,TResult? Function( List<RlpItem> items)?  list,}) {final _that = this;
switch (_that) {
case RlpBytes() when bytes != null:
return bytes(_that.data);case RlpList() when list != null:
return list(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class RlpBytes implements RlpItem {
  const RlpBytes(this.data);
  

 final  Uint8List data;

/// Create a copy of RlpItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RlpBytesCopyWith<RlpBytes> get copyWith => _$RlpBytesCopyWithImpl<RlpBytes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RlpBytes&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'RlpItem.bytes(data: $data)';
}


}

/// @nodoc
abstract mixin class $RlpBytesCopyWith<$Res> implements $RlpItemCopyWith<$Res> {
  factory $RlpBytesCopyWith(RlpBytes value, $Res Function(RlpBytes) _then) = _$RlpBytesCopyWithImpl;
@useResult
$Res call({
 Uint8List data
});




}
/// @nodoc
class _$RlpBytesCopyWithImpl<$Res>
    implements $RlpBytesCopyWith<$Res> {
  _$RlpBytesCopyWithImpl(this._self, this._then);

  final RlpBytes _self;
  final $Res Function(RlpBytes) _then;

/// Create a copy of RlpItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(RlpBytes(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class RlpList implements RlpItem {
  const RlpList( List<RlpItem> items): _items = items;
  

 final  List<RlpItem> _items;
 List<RlpItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of RlpItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RlpListCopyWith<RlpList> get copyWith => _$RlpListCopyWithImpl<RlpList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RlpList&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'RlpItem.list(items: $items)';
}


}

/// @nodoc
abstract mixin class $RlpListCopyWith<$Res> implements $RlpItemCopyWith<$Res> {
  factory $RlpListCopyWith(RlpList value, $Res Function(RlpList) _then) = _$RlpListCopyWithImpl;
@useResult
$Res call({
 List<RlpItem> items
});




}
/// @nodoc
class _$RlpListCopyWithImpl<$Res>
    implements $RlpListCopyWith<$Res> {
  _$RlpListCopyWithImpl(this._self, this._then);

  final RlpList _self;
  final $Res Function(RlpList) _then;

/// Create a copy of RlpItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(RlpList(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RlpItem>,
  ));
}


}

// dart format on
