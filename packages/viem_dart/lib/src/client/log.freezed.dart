// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Log {

 String get address; List<String> get topics; String get data;@HexBigIntNConverter() BigInt? get blockNumber; String? get blockHash; String? get transactionHash;@HexIntNConverter() int? get transactionIndex;@HexIntNConverter() int? get logIndex; bool get removed;
/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogCopyWith<Log> get copyWith => _$LogCopyWithImpl<Log>(this as Log, _$identity);

  /// Serializes this Log to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Log&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.data, data) || other.data == data)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.logIndex, logIndex) || other.logIndex == logIndex)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(topics),data,blockNumber,blockHash,transactionHash,transactionIndex,logIndex,removed);

@override
String toString() {
  return 'Log(address: $address, topics: $topics, data: $data, blockNumber: $blockNumber, blockHash: $blockHash, transactionHash: $transactionHash, transactionIndex: $transactionIndex, logIndex: $logIndex, removed: $removed)';
}


}

/// @nodoc
abstract mixin class $LogCopyWith<$Res>  {
  factory $LogCopyWith(Log value, $Res Function(Log) _then) = _$LogCopyWithImpl;
@useResult
$Res call({
 String address, List<String> topics, String data,@HexBigIntNConverter() BigInt? blockNumber, String? blockHash, String? transactionHash,@HexIntNConverter() int? transactionIndex,@HexIntNConverter() int? logIndex, bool removed
});




}
/// @nodoc
class _$LogCopyWithImpl<$Res>
    implements $LogCopyWith<$Res> {
  _$LogCopyWithImpl(this._self, this._then);

  final Log _self;
  final $Res Function(Log) _then;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? topics = null,Object? data = null,Object? blockNumber = freezed,Object? blockHash = freezed,Object? transactionHash = freezed,Object? transactionIndex = freezed,Object? logIndex = freezed,Object? removed = null,}) {
  return _then(Log(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,transactionHash: freezed == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String?,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int?,logIndex: freezed == logIndex ? _self.logIndex : logIndex // ignore: cast_nullable_to_non_nullable
as int?,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Log].
extension LogPatterns on Log {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Log value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Log() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Log value)  $default,){
final _that = this;
switch (_that) {
case _Log():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Log value)?  $default,){
final _that = this;
switch (_that) {
case _Log() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  List<String> topics,  String data, @HexBigIntNConverter()  BigInt? blockNumber,  String? blockHash,  String? transactionHash, @HexIntNConverter()  int? transactionIndex, @HexIntNConverter()  int? logIndex,  bool removed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Log() when $default != null:
return $default(_that.address,_that.topics,_that.data,_that.blockNumber,_that.blockHash,_that.transactionHash,_that.transactionIndex,_that.logIndex,_that.removed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  List<String> topics,  String data, @HexBigIntNConverter()  BigInt? blockNumber,  String? blockHash,  String? transactionHash, @HexIntNConverter()  int? transactionIndex, @HexIntNConverter()  int? logIndex,  bool removed)  $default,) {final _that = this;
switch (_that) {
case _Log():
return $default(_that.address,_that.topics,_that.data,_that.blockNumber,_that.blockHash,_that.transactionHash,_that.transactionIndex,_that.logIndex,_that.removed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  List<String> topics,  String data, @HexBigIntNConverter()  BigInt? blockNumber,  String? blockHash,  String? transactionHash, @HexIntNConverter()  int? transactionIndex, @HexIntNConverter()  int? logIndex,  bool removed)?  $default,) {final _that = this;
switch (_that) {
case _Log() when $default != null:
return $default(_that.address,_that.topics,_that.data,_that.blockNumber,_that.blockHash,_that.transactionHash,_that.transactionIndex,_that.logIndex,_that.removed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Log implements Log {
  const _Log({required this.address, required  List<String> topics, required this.data, @HexBigIntNConverter() this.blockNumber, this.blockHash, this.transactionHash, @HexIntNConverter() this.transactionIndex, @HexIntNConverter() this.logIndex, this.removed = false}): _topics = topics;
  factory _Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

@override final  String address;
 final  List<String> _topics;
@override List<String> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  String data;
@override@HexBigIntNConverter() final  BigInt? blockNumber;
@override final  String? blockHash;
@override final  String? transactionHash;
@override@HexIntNConverter() final  int? transactionIndex;
@override@HexIntNConverter() final  int? logIndex;
@override@JsonKey() final  bool removed;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogCopyWith<_Log> get copyWith => __$LogCopyWithImpl<_Log>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Log&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.data, data) || other.data == data)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.logIndex, logIndex) || other.logIndex == logIndex)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(_topics),data,blockNumber,blockHash,transactionHash,transactionIndex,logIndex,removed);

@override
String toString() {
  return 'Log(address: $address, topics: $topics, data: $data, blockNumber: $blockNumber, blockHash: $blockHash, transactionHash: $transactionHash, transactionIndex: $transactionIndex, logIndex: $logIndex, removed: $removed)';
}


}

/// @nodoc
abstract mixin class _$LogCopyWith<$Res> implements $LogCopyWith<$Res> {
  factory _$LogCopyWith(_Log value, $Res Function(_Log) _then) = __$LogCopyWithImpl;
@override @useResult
$Res call({
 String address, List<String> topics, String data,@HexBigIntNConverter() BigInt? blockNumber, String? blockHash, String? transactionHash,@HexIntNConverter() int? transactionIndex,@HexIntNConverter() int? logIndex, bool removed
});




}
/// @nodoc
class __$LogCopyWithImpl<$Res>
    implements _$LogCopyWith<$Res> {
  __$LogCopyWithImpl(this._self, this._then);

  final _Log _self;
  final $Res Function(_Log) _then;

/// Create a copy of Log
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? topics = null,Object? data = null,Object? blockNumber = freezed,Object? blockHash = freezed,Object? transactionHash = freezed,Object? transactionIndex = freezed,Object? logIndex = freezed,Object? removed = null,}) {
  return _then(_Log(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,transactionHash: freezed == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String?,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int?,logIndex: freezed == logIndex ? _self.logIndex : logIndex // ignore: cast_nullable_to_non_nullable
as int?,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
