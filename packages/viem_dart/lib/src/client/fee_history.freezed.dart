// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeeHistory {

@HexBigIntConverter() BigInt get oldestBlock;@HexBigIntListConverter() List<BigInt> get baseFeePerGas; List<double> get gasUsedRatio; List<List<String>>? get reward;
/// Create a copy of FeeHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeHistoryCopyWith<FeeHistory> get copyWith => _$FeeHistoryCopyWithImpl<FeeHistory>(this as FeeHistory, _$identity);

  /// Serializes this FeeHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeHistory&&(identical(other.oldestBlock, oldestBlock) || other.oldestBlock == oldestBlock)&&const DeepCollectionEquality().equals(other.baseFeePerGas, baseFeePerGas)&&const DeepCollectionEquality().equals(other.gasUsedRatio, gasUsedRatio)&&const DeepCollectionEquality().equals(other.reward, reward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldestBlock,const DeepCollectionEquality().hash(baseFeePerGas),const DeepCollectionEquality().hash(gasUsedRatio),const DeepCollectionEquality().hash(reward));

@override
String toString() {
  return 'FeeHistory(oldestBlock: $oldestBlock, baseFeePerGas: $baseFeePerGas, gasUsedRatio: $gasUsedRatio, reward: $reward)';
}


}

/// @nodoc
abstract mixin class $FeeHistoryCopyWith<$Res>  {
  factory $FeeHistoryCopyWith(FeeHistory value, $Res Function(FeeHistory) _then) = _$FeeHistoryCopyWithImpl;
@useResult
$Res call({
@HexBigIntConverter() BigInt oldestBlock,@HexBigIntListConverter() List<BigInt> baseFeePerGas, List<double> gasUsedRatio, List<List<String>>? reward
});




}
/// @nodoc
class _$FeeHistoryCopyWithImpl<$Res>
    implements $FeeHistoryCopyWith<$Res> {
  _$FeeHistoryCopyWithImpl(this._self, this._then);

  final FeeHistory _self;
  final $Res Function(FeeHistory) _then;

/// Create a copy of FeeHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oldestBlock = null,Object? baseFeePerGas = null,Object? gasUsedRatio = null,Object? reward = freezed,}) {
  return _then(FeeHistory(
oldestBlock: null == oldestBlock ? _self.oldestBlock : oldestBlock // ignore: cast_nullable_to_non_nullable
as BigInt,baseFeePerGas: null == baseFeePerGas ? _self.baseFeePerGas : baseFeePerGas // ignore: cast_nullable_to_non_nullable
as List<BigInt>,gasUsedRatio: null == gasUsedRatio ? _self.gasUsedRatio : gasUsedRatio // ignore: cast_nullable_to_non_nullable
as List<double>,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeHistory].
extension FeeHistoryPatterns on FeeHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeHistory value)  $default,){
final _that = this;
switch (_that) {
case _FeeHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeHistory value)?  $default,){
final _that = this;
switch (_that) {
case _FeeHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HexBigIntConverter()  BigInt oldestBlock, @HexBigIntListConverter()  List<BigInt> baseFeePerGas,  List<double> gasUsedRatio,  List<List<String>>? reward)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeHistory() when $default != null:
return $default(_that.oldestBlock,_that.baseFeePerGas,_that.gasUsedRatio,_that.reward);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HexBigIntConverter()  BigInt oldestBlock, @HexBigIntListConverter()  List<BigInt> baseFeePerGas,  List<double> gasUsedRatio,  List<List<String>>? reward)  $default,) {final _that = this;
switch (_that) {
case _FeeHistory():
return $default(_that.oldestBlock,_that.baseFeePerGas,_that.gasUsedRatio,_that.reward);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HexBigIntConverter()  BigInt oldestBlock, @HexBigIntListConverter()  List<BigInt> baseFeePerGas,  List<double> gasUsedRatio,  List<List<String>>? reward)?  $default,) {final _that = this;
switch (_that) {
case _FeeHistory() when $default != null:
return $default(_that.oldestBlock,_that.baseFeePerGas,_that.gasUsedRatio,_that.reward);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeHistory implements FeeHistory {
  const _FeeHistory({@HexBigIntConverter() required this.oldestBlock, @HexBigIntListConverter() required  List<BigInt> baseFeePerGas, required  List<double> gasUsedRatio,  List<List<String>>? reward}): _baseFeePerGas = baseFeePerGas,_gasUsedRatio = gasUsedRatio,_reward = reward;
  factory _FeeHistory.fromJson(Map<String, dynamic> json) => _$FeeHistoryFromJson(json);

@override@HexBigIntConverter() final  BigInt oldestBlock;
 final  List<BigInt> _baseFeePerGas;
@override@HexBigIntListConverter() List<BigInt> get baseFeePerGas {
  if (_baseFeePerGas is EqualUnmodifiableListView) return _baseFeePerGas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baseFeePerGas);
}

 final  List<double> _gasUsedRatio;
@override List<double> get gasUsedRatio {
  if (_gasUsedRatio is EqualUnmodifiableListView) return _gasUsedRatio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gasUsedRatio);
}

 final  List<List<String>>? _reward;
@override List<List<String>>? get reward {
  final value = _reward;
  if (value == null) return null;
  if (_reward is EqualUnmodifiableListView) return _reward;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FeeHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeHistoryCopyWith<_FeeHistory> get copyWith => __$FeeHistoryCopyWithImpl<_FeeHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeHistory&&(identical(other.oldestBlock, oldestBlock) || other.oldestBlock == oldestBlock)&&const DeepCollectionEquality().equals(other._baseFeePerGas, _baseFeePerGas)&&const DeepCollectionEquality().equals(other._gasUsedRatio, _gasUsedRatio)&&const DeepCollectionEquality().equals(other._reward, _reward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldestBlock,const DeepCollectionEquality().hash(_baseFeePerGas),const DeepCollectionEquality().hash(_gasUsedRatio),const DeepCollectionEquality().hash(_reward));

@override
String toString() {
  return 'FeeHistory(oldestBlock: $oldestBlock, baseFeePerGas: $baseFeePerGas, gasUsedRatio: $gasUsedRatio, reward: $reward)';
}


}

/// @nodoc
abstract mixin class _$FeeHistoryCopyWith<$Res> implements $FeeHistoryCopyWith<$Res> {
  factory _$FeeHistoryCopyWith(_FeeHistory value, $Res Function(_FeeHistory) _then) = __$FeeHistoryCopyWithImpl;
@override @useResult
$Res call({
@HexBigIntConverter() BigInt oldestBlock,@HexBigIntListConverter() List<BigInt> baseFeePerGas, List<double> gasUsedRatio, List<List<String>>? reward
});




}
/// @nodoc
class __$FeeHistoryCopyWithImpl<$Res>
    implements _$FeeHistoryCopyWith<$Res> {
  __$FeeHistoryCopyWithImpl(this._self, this._then);

  final _FeeHistory _self;
  final $Res Function(_FeeHistory) _then;

/// Create a copy of FeeHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oldestBlock = null,Object? baseFeePerGas = null,Object? gasUsedRatio = null,Object? reward = freezed,}) {
  return _then(_FeeHistory(
oldestBlock: null == oldestBlock ? _self.oldestBlock : oldestBlock // ignore: cast_nullable_to_non_nullable
as BigInt,baseFeePerGas: null == baseFeePerGas ? _self._baseFeePerGas : baseFeePerGas // ignore: cast_nullable_to_non_nullable
as List<BigInt>,gasUsedRatio: null == gasUsedRatio ? _self._gasUsedRatio : gasUsedRatio // ignore: cast_nullable_to_non_nullable
as List<double>,reward: freezed == reward ? _self._reward : reward // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}


}

// dart format on
