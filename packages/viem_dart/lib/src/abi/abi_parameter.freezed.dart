// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'abi_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AbiParameter {

 String get name; String get type; List<AbiParameter>? get components; bool? get indexed;
/// Create a copy of AbiParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiParameterCopyWith<AbiParameter> get copyWith => _$AbiParameterCopyWithImpl<AbiParameter>(this as AbiParameter, _$identity);

  /// Serializes this AbiParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiParameter&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.components, components)&&(identical(other.indexed, indexed) || other.indexed == indexed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,const DeepCollectionEquality().hash(components),indexed);

@override
String toString() {
  return 'AbiParameter(name: $name, type: $type, components: $components, indexed: $indexed)';
}


}

/// @nodoc
abstract mixin class $AbiParameterCopyWith<$Res>  {
  factory $AbiParameterCopyWith(AbiParameter value, $Res Function(AbiParameter) _then) = _$AbiParameterCopyWithImpl;
@useResult
$Res call({
 String name, String type, List<AbiParameter>? components, bool? indexed
});




}
/// @nodoc
class _$AbiParameterCopyWithImpl<$Res>
    implements $AbiParameterCopyWith<$Res> {
  _$AbiParameterCopyWithImpl(this._self, this._then);

  final AbiParameter _self;
  final $Res Function(AbiParameter) _then;

/// Create a copy of AbiParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? components = freezed,Object? indexed = freezed,}) {
  return _then(AbiParameter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,components: freezed == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>?,indexed: freezed == indexed ? _self.indexed : indexed // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AbiParameter].
extension AbiParameterPatterns on AbiParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AbiParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AbiParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AbiParameter value)  $default,){
final _that = this;
switch (_that) {
case _AbiParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AbiParameter value)?  $default,){
final _that = this;
switch (_that) {
case _AbiParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String type,  List<AbiParameter>? components,  bool? indexed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AbiParameter() when $default != null:
return $default(_that.name,_that.type,_that.components,_that.indexed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String type,  List<AbiParameter>? components,  bool? indexed)  $default,) {final _that = this;
switch (_that) {
case _AbiParameter():
return $default(_that.name,_that.type,_that.components,_that.indexed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String type,  List<AbiParameter>? components,  bool? indexed)?  $default,) {final _that = this;
switch (_that) {
case _AbiParameter() when $default != null:
return $default(_that.name,_that.type,_that.components,_that.indexed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AbiParameter implements AbiParameter {
  const _AbiParameter({required this.name, required this.type,  List<AbiParameter>? components, this.indexed}): _components = components;
  factory _AbiParameter.fromJson(Map<String, dynamic> json) => _$AbiParameterFromJson(json);

@override final  String name;
@override final  String type;
 final  List<AbiParameter>? _components;
@override List<AbiParameter>? get components {
  final value = _components;
  if (value == null) return null;
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? indexed;

/// Create a copy of AbiParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbiParameterCopyWith<_AbiParameter> get copyWith => __$AbiParameterCopyWithImpl<_AbiParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AbiParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbiParameter&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._components, _components)&&(identical(other.indexed, indexed) || other.indexed == indexed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,type,const DeepCollectionEquality().hash(_components),indexed);

@override
String toString() {
  return 'AbiParameter(name: $name, type: $type, components: $components, indexed: $indexed)';
}


}

/// @nodoc
abstract mixin class _$AbiParameterCopyWith<$Res> implements $AbiParameterCopyWith<$Res> {
  factory _$AbiParameterCopyWith(_AbiParameter value, $Res Function(_AbiParameter) _then) = __$AbiParameterCopyWithImpl;
@override @useResult
$Res call({
 String name, String type, List<AbiParameter>? components, bool? indexed
});




}
/// @nodoc
class __$AbiParameterCopyWithImpl<$Res>
    implements _$AbiParameterCopyWith<$Res> {
  __$AbiParameterCopyWithImpl(this._self, this._then);

  final _AbiParameter _self;
  final $Res Function(_AbiParameter) _then;

/// Create a copy of AbiParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? components = freezed,Object? indexed = freezed,}) {
  return _then(_AbiParameter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,components: freezed == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>?,indexed: freezed == indexed ? _self.indexed : indexed // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
