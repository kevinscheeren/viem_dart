// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'abi_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AbiItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AbiItem()';
}


}

/// @nodoc
class $AbiItemCopyWith<$Res>  {
$AbiItemCopyWith(AbiItem _, $Res Function(AbiItem) __);
}


/// Adds pattern-matching-related methods to [AbiItem].
extension AbiItemPatterns on AbiItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AbiFunction value)?  function,TResult Function( AbiEvent value)?  event,TResult Function( AbiError value)?  error,TResult Function( AbiConstructor value)?  constructor,TResult Function( AbiFallback value)?  fallback,TResult Function( AbiReceive value)?  receive,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AbiFunction() when function != null:
return function(_that);case AbiEvent() when event != null:
return event(_that);case AbiError() when error != null:
return error(_that);case AbiConstructor() when constructor != null:
return constructor(_that);case AbiFallback() when fallback != null:
return fallback(_that);case AbiReceive() when receive != null:
return receive(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AbiFunction value)  function,required TResult Function( AbiEvent value)  event,required TResult Function( AbiError value)  error,required TResult Function( AbiConstructor value)  constructor,required TResult Function( AbiFallback value)  fallback,required TResult Function( AbiReceive value)  receive,}){
final _that = this;
switch (_that) {
case AbiFunction():
return function(_that);case AbiEvent():
return event(_that);case AbiError():
return error(_that);case AbiConstructor():
return constructor(_that);case AbiFallback():
return fallback(_that);case AbiReceive():
return receive(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AbiFunction value)?  function,TResult? Function( AbiEvent value)?  event,TResult? Function( AbiError value)?  error,TResult? Function( AbiConstructor value)?  constructor,TResult? Function( AbiFallback value)?  fallback,TResult? Function( AbiReceive value)?  receive,}){
final _that = this;
switch (_that) {
case AbiFunction() when function != null:
return function(_that);case AbiEvent() when event != null:
return event(_that);case AbiError() when error != null:
return error(_that);case AbiConstructor() when constructor != null:
return constructor(_that);case AbiFallback() when fallback != null:
return fallback(_that);case AbiReceive() when receive != null:
return receive(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  List<AbiParameter> inputs,  List<AbiParameter> outputs,  String stateMutability)?  function,TResult Function( String name,  List<AbiParameter> inputs,  bool anonymous)?  event,TResult Function( String name,  List<AbiParameter> inputs)?  error,TResult Function( List<AbiParameter> inputs,  String stateMutability)?  constructor,TResult Function( String stateMutability)?  fallback,TResult Function()?  receive,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AbiFunction() when function != null:
return function(_that.name,_that.inputs,_that.outputs,_that.stateMutability);case AbiEvent() when event != null:
return event(_that.name,_that.inputs,_that.anonymous);case AbiError() when error != null:
return error(_that.name,_that.inputs);case AbiConstructor() when constructor != null:
return constructor(_that.inputs,_that.stateMutability);case AbiFallback() when fallback != null:
return fallback(_that.stateMutability);case AbiReceive() when receive != null:
return receive();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  List<AbiParameter> inputs,  List<AbiParameter> outputs,  String stateMutability)  function,required TResult Function( String name,  List<AbiParameter> inputs,  bool anonymous)  event,required TResult Function( String name,  List<AbiParameter> inputs)  error,required TResult Function( List<AbiParameter> inputs,  String stateMutability)  constructor,required TResult Function( String stateMutability)  fallback,required TResult Function()  receive,}) {final _that = this;
switch (_that) {
case AbiFunction():
return function(_that.name,_that.inputs,_that.outputs,_that.stateMutability);case AbiEvent():
return event(_that.name,_that.inputs,_that.anonymous);case AbiError():
return error(_that.name,_that.inputs);case AbiConstructor():
return constructor(_that.inputs,_that.stateMutability);case AbiFallback():
return fallback(_that.stateMutability);case AbiReceive():
return receive();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  List<AbiParameter> inputs,  List<AbiParameter> outputs,  String stateMutability)?  function,TResult? Function( String name,  List<AbiParameter> inputs,  bool anonymous)?  event,TResult? Function( String name,  List<AbiParameter> inputs)?  error,TResult? Function( List<AbiParameter> inputs,  String stateMutability)?  constructor,TResult? Function( String stateMutability)?  fallback,TResult? Function()?  receive,}) {final _that = this;
switch (_that) {
case AbiFunction() when function != null:
return function(_that.name,_that.inputs,_that.outputs,_that.stateMutability);case AbiEvent() when event != null:
return event(_that.name,_that.inputs,_that.anonymous);case AbiError() when error != null:
return error(_that.name,_that.inputs);case AbiConstructor() when constructor != null:
return constructor(_that.inputs,_that.stateMutability);case AbiFallback() when fallback != null:
return fallback(_that.stateMutability);case AbiReceive() when receive != null:
return receive();case _:
  return null;

}
}

}

/// @nodoc


class AbiFunction implements AbiItem {
  const AbiFunction({required this.name, required  List<AbiParameter> inputs, required  List<AbiParameter> outputs, this.stateMutability = 'nonpayable'}): _inputs = inputs,_outputs = outputs;
  

 final  String name;
 final  List<AbiParameter> _inputs;
 List<AbiParameter> get inputs {
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputs);
}

 final  List<AbiParameter> _outputs;
 List<AbiParameter> get outputs {
  if (_outputs is EqualUnmodifiableListView) return _outputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outputs);
}

@JsonKey() final  String stateMutability;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiFunctionCopyWith<AbiFunction> get copyWith => _$AbiFunctionCopyWithImpl<AbiFunction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiFunction&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._inputs, _inputs)&&const DeepCollectionEquality().equals(other._outputs, _outputs)&&(identical(other.stateMutability, stateMutability) || other.stateMutability == stateMutability));
}


@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_inputs),const DeepCollectionEquality().hash(_outputs),stateMutability);

@override
String toString() {
  return 'AbiItem.function(name: $name, inputs: $inputs, outputs: $outputs, stateMutability: $stateMutability)';
}


}

/// @nodoc
abstract mixin class $AbiFunctionCopyWith<$Res> implements $AbiItemCopyWith<$Res> {
  factory $AbiFunctionCopyWith(AbiFunction value, $Res Function(AbiFunction) _then) = _$AbiFunctionCopyWithImpl;
@useResult
$Res call({
 String name, List<AbiParameter> inputs, List<AbiParameter> outputs, String stateMutability
});




}
/// @nodoc
class _$AbiFunctionCopyWithImpl<$Res>
    implements $AbiFunctionCopyWith<$Res> {
  _$AbiFunctionCopyWithImpl(this._self, this._then);

  final AbiFunction _self;
  final $Res Function(AbiFunction) _then;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? inputs = null,Object? outputs = null,Object? stateMutability = null,}) {
  return _then(AbiFunction(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>,outputs: null == outputs ? _self._outputs : outputs // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>,stateMutability: null == stateMutability ? _self.stateMutability : stateMutability // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AbiEvent implements AbiItem {
  const AbiEvent({required this.name, required  List<AbiParameter> inputs, this.anonymous = false}): _inputs = inputs;
  

 final  String name;
 final  List<AbiParameter> _inputs;
 List<AbiParameter> get inputs {
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputs);
}

@JsonKey() final  bool anonymous;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiEventCopyWith<AbiEvent> get copyWith => _$AbiEventCopyWithImpl<AbiEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiEvent&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._inputs, _inputs)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous));
}


@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_inputs),anonymous);

@override
String toString() {
  return 'AbiItem.event(name: $name, inputs: $inputs, anonymous: $anonymous)';
}


}

/// @nodoc
abstract mixin class $AbiEventCopyWith<$Res> implements $AbiItemCopyWith<$Res> {
  factory $AbiEventCopyWith(AbiEvent value, $Res Function(AbiEvent) _then) = _$AbiEventCopyWithImpl;
@useResult
$Res call({
 String name, List<AbiParameter> inputs, bool anonymous
});




}
/// @nodoc
class _$AbiEventCopyWithImpl<$Res>
    implements $AbiEventCopyWith<$Res> {
  _$AbiEventCopyWithImpl(this._self, this._then);

  final AbiEvent _self;
  final $Res Function(AbiEvent) _then;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? inputs = null,Object? anonymous = null,}) {
  return _then(AbiEvent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class AbiError implements AbiItem {
  const AbiError({required this.name, required  List<AbiParameter> inputs}): _inputs = inputs;
  

 final  String name;
 final  List<AbiParameter> _inputs;
 List<AbiParameter> get inputs {
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputs);
}


/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiErrorCopyWith<AbiError> get copyWith => _$AbiErrorCopyWithImpl<AbiError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiError&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._inputs, _inputs));
}


@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_inputs));

@override
String toString() {
  return 'AbiItem.error(name: $name, inputs: $inputs)';
}


}

/// @nodoc
abstract mixin class $AbiErrorCopyWith<$Res> implements $AbiItemCopyWith<$Res> {
  factory $AbiErrorCopyWith(AbiError value, $Res Function(AbiError) _then) = _$AbiErrorCopyWithImpl;
@useResult
$Res call({
 String name, List<AbiParameter> inputs
});




}
/// @nodoc
class _$AbiErrorCopyWithImpl<$Res>
    implements $AbiErrorCopyWith<$Res> {
  _$AbiErrorCopyWithImpl(this._self, this._then);

  final AbiError _self;
  final $Res Function(AbiError) _then;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? inputs = null,}) {
  return _then(AbiError(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>,
  ));
}


}

/// @nodoc


class AbiConstructor implements AbiItem {
  const AbiConstructor({required  List<AbiParameter> inputs, this.stateMutability = 'nonpayable'}): _inputs = inputs;
  

 final  List<AbiParameter> _inputs;
 List<AbiParameter> get inputs {
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputs);
}

@JsonKey() final  String stateMutability;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiConstructorCopyWith<AbiConstructor> get copyWith => _$AbiConstructorCopyWithImpl<AbiConstructor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiConstructor&&const DeepCollectionEquality().equals(other._inputs, _inputs)&&(identical(other.stateMutability, stateMutability) || other.stateMutability == stateMutability));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_inputs),stateMutability);

@override
String toString() {
  return 'AbiItem.constructor(inputs: $inputs, stateMutability: $stateMutability)';
}


}

/// @nodoc
abstract mixin class $AbiConstructorCopyWith<$Res> implements $AbiItemCopyWith<$Res> {
  factory $AbiConstructorCopyWith(AbiConstructor value, $Res Function(AbiConstructor) _then) = _$AbiConstructorCopyWithImpl;
@useResult
$Res call({
 List<AbiParameter> inputs, String stateMutability
});




}
/// @nodoc
class _$AbiConstructorCopyWithImpl<$Res>
    implements $AbiConstructorCopyWith<$Res> {
  _$AbiConstructorCopyWithImpl(this._self, this._then);

  final AbiConstructor _self;
  final $Res Function(AbiConstructor) _then;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inputs = null,Object? stateMutability = null,}) {
  return _then(AbiConstructor(
inputs: null == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<AbiParameter>,stateMutability: null == stateMutability ? _self.stateMutability : stateMutability // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AbiFallback implements AbiItem {
  const AbiFallback({this.stateMutability = 'nonpayable'});
  

@JsonKey() final  String stateMutability;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbiFallbackCopyWith<AbiFallback> get copyWith => _$AbiFallbackCopyWithImpl<AbiFallback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiFallback&&(identical(other.stateMutability, stateMutability) || other.stateMutability == stateMutability));
}


@override
int get hashCode => Object.hash(runtimeType,stateMutability);

@override
String toString() {
  return 'AbiItem.fallback(stateMutability: $stateMutability)';
}


}

/// @nodoc
abstract mixin class $AbiFallbackCopyWith<$Res> implements $AbiItemCopyWith<$Res> {
  factory $AbiFallbackCopyWith(AbiFallback value, $Res Function(AbiFallback) _then) = _$AbiFallbackCopyWithImpl;
@useResult
$Res call({
 String stateMutability
});




}
/// @nodoc
class _$AbiFallbackCopyWithImpl<$Res>
    implements $AbiFallbackCopyWith<$Res> {
  _$AbiFallbackCopyWithImpl(this._self, this._then);

  final AbiFallback _self;
  final $Res Function(AbiFallback) _then;

/// Create a copy of AbiItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stateMutability = null,}) {
  return _then(AbiFallback(
stateMutability: null == stateMutability ? _self.stateMutability : stateMutability // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AbiReceive implements AbiItem {
  const AbiReceive();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbiReceive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AbiItem.receive()';
}


}




// dart format on
