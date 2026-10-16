// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionReceipt {

 String get transactionHash;@HexIntConverter() int get transactionIndex; String get blockHash;@HexBigIntConverter() BigInt get blockNumber; String get from; String? get to;@HexBigIntConverter() BigInt get cumulativeGasUsed;@HexBigIntConverter() BigInt get gasUsed; String? get contractAddress; List<Log> get logs; String get logsBloom;@HexIntNConverter() int? get status;@HexBigIntNConverter() BigInt? get effectiveGasPrice;@HexIntNConverter() int? get type;
/// Create a copy of TransactionReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionReceiptCopyWith<TransactionReceipt> get copyWith => _$TransactionReceiptCopyWithImpl<TransactionReceipt>(this as TransactionReceipt, _$identity);

  /// Serializes this TransactionReceipt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionReceipt&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.cumulativeGasUsed, cumulativeGasUsed) || other.cumulativeGasUsed == cumulativeGasUsed)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.logsBloom, logsBloom) || other.logsBloom == logsBloom)&&(identical(other.status, status) || other.status == status)&&(identical(other.effectiveGasPrice, effectiveGasPrice) || other.effectiveGasPrice == effectiveGasPrice)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionHash,transactionIndex,blockHash,blockNumber,from,to,cumulativeGasUsed,gasUsed,contractAddress,const DeepCollectionEquality().hash(logs),logsBloom,status,effectiveGasPrice,type);

@override
String toString() {
  return 'TransactionReceipt(transactionHash: $transactionHash, transactionIndex: $transactionIndex, blockHash: $blockHash, blockNumber: $blockNumber, from: $from, to: $to, cumulativeGasUsed: $cumulativeGasUsed, gasUsed: $gasUsed, contractAddress: $contractAddress, logs: $logs, logsBloom: $logsBloom, status: $status, effectiveGasPrice: $effectiveGasPrice, type: $type)';
}


}

/// @nodoc
abstract mixin class $TransactionReceiptCopyWith<$Res>  {
  factory $TransactionReceiptCopyWith(TransactionReceipt value, $Res Function(TransactionReceipt) _then) = _$TransactionReceiptCopyWithImpl;
@useResult
$Res call({
 String transactionHash,@HexIntConverter() int transactionIndex, String blockHash,@HexBigIntConverter() BigInt blockNumber, String from, String? to,@HexBigIntConverter() BigInt cumulativeGasUsed,@HexBigIntConverter() BigInt gasUsed, String? contractAddress, List<Log> logs, String logsBloom,@HexIntNConverter() int? status,@HexBigIntNConverter() BigInt? effectiveGasPrice,@HexIntNConverter() int? type
});




}
/// @nodoc
class _$TransactionReceiptCopyWithImpl<$Res>
    implements $TransactionReceiptCopyWith<$Res> {
  _$TransactionReceiptCopyWithImpl(this._self, this._then);

  final TransactionReceipt _self;
  final $Res Function(TransactionReceipt) _then;

/// Create a copy of TransactionReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionHash = null,Object? transactionIndex = null,Object? blockHash = null,Object? blockNumber = null,Object? from = null,Object? to = freezed,Object? cumulativeGasUsed = null,Object? gasUsed = null,Object? contractAddress = freezed,Object? logs = null,Object? logsBloom = null,Object? status = freezed,Object? effectiveGasPrice = freezed,Object? type = freezed,}) {
  return _then(TransactionReceipt(
transactionHash: null == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String,transactionIndex: null == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int,blockHash: null == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String,blockNumber: null == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,cumulativeGasUsed: null == cumulativeGasUsed ? _self.cumulativeGasUsed : cumulativeGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<Log>,logsBloom: null == logsBloom ? _self.logsBloom : logsBloom // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,effectiveGasPrice: freezed == effectiveGasPrice ? _self.effectiveGasPrice : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionReceipt].
extension TransactionReceiptPatterns on TransactionReceipt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionReceipt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionReceipt value)  $default,){
final _that = this;
switch (_that) {
case _TransactionReceipt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionReceipt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionHash, @HexIntConverter()  int transactionIndex,  String blockHash, @HexBigIntConverter()  BigInt blockNumber,  String from,  String? to, @HexBigIntConverter()  BigInt cumulativeGasUsed, @HexBigIntConverter()  BigInt gasUsed,  String? contractAddress,  List<Log> logs,  String logsBloom, @HexIntNConverter()  int? status, @HexBigIntNConverter()  BigInt? effectiveGasPrice, @HexIntNConverter()  int? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionReceipt() when $default != null:
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.from,_that.to,_that.cumulativeGasUsed,_that.gasUsed,_that.contractAddress,_that.logs,_that.logsBloom,_that.status,_that.effectiveGasPrice,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionHash, @HexIntConverter()  int transactionIndex,  String blockHash, @HexBigIntConverter()  BigInt blockNumber,  String from,  String? to, @HexBigIntConverter()  BigInt cumulativeGasUsed, @HexBigIntConverter()  BigInt gasUsed,  String? contractAddress,  List<Log> logs,  String logsBloom, @HexIntNConverter()  int? status, @HexBigIntNConverter()  BigInt? effectiveGasPrice, @HexIntNConverter()  int? type)  $default,) {final _that = this;
switch (_that) {
case _TransactionReceipt():
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.from,_that.to,_that.cumulativeGasUsed,_that.gasUsed,_that.contractAddress,_that.logs,_that.logsBloom,_that.status,_that.effectiveGasPrice,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionHash, @HexIntConverter()  int transactionIndex,  String blockHash, @HexBigIntConverter()  BigInt blockNumber,  String from,  String? to, @HexBigIntConverter()  BigInt cumulativeGasUsed, @HexBigIntConverter()  BigInt gasUsed,  String? contractAddress,  List<Log> logs,  String logsBloom, @HexIntNConverter()  int? status, @HexBigIntNConverter()  BigInt? effectiveGasPrice, @HexIntNConverter()  int? type)?  $default,) {final _that = this;
switch (_that) {
case _TransactionReceipt() when $default != null:
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.from,_that.to,_that.cumulativeGasUsed,_that.gasUsed,_that.contractAddress,_that.logs,_that.logsBloom,_that.status,_that.effectiveGasPrice,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionReceipt implements TransactionReceipt {
  const _TransactionReceipt({required this.transactionHash, @HexIntConverter() required this.transactionIndex, required this.blockHash, @HexBigIntConverter() required this.blockNumber, required this.from, this.to, @HexBigIntConverter() required this.cumulativeGasUsed, @HexBigIntConverter() required this.gasUsed, this.contractAddress, required  List<Log> logs, required this.logsBloom, @HexIntNConverter() this.status, @HexBigIntNConverter() this.effectiveGasPrice, @HexIntNConverter() this.type}): _logs = logs;
  factory _TransactionReceipt.fromJson(Map<String, dynamic> json) => _$TransactionReceiptFromJson(json);

@override final  String transactionHash;
@override@HexIntConverter() final  int transactionIndex;
@override final  String blockHash;
@override@HexBigIntConverter() final  BigInt blockNumber;
@override final  String from;
@override final  String? to;
@override@HexBigIntConverter() final  BigInt cumulativeGasUsed;
@override@HexBigIntConverter() final  BigInt gasUsed;
@override final  String? contractAddress;
 final  List<Log> _logs;
@override List<Log> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override final  String logsBloom;
@override@HexIntNConverter() final  int? status;
@override@HexBigIntNConverter() final  BigInt? effectiveGasPrice;
@override@HexIntNConverter() final  int? type;

/// Create a copy of TransactionReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionReceiptCopyWith<_TransactionReceipt> get copyWith => __$TransactionReceiptCopyWithImpl<_TransactionReceipt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionReceiptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionReceipt&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.cumulativeGasUsed, cumulativeGasUsed) || other.cumulativeGasUsed == cumulativeGasUsed)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress)&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.logsBloom, logsBloom) || other.logsBloom == logsBloom)&&(identical(other.status, status) || other.status == status)&&(identical(other.effectiveGasPrice, effectiveGasPrice) || other.effectiveGasPrice == effectiveGasPrice)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionHash,transactionIndex,blockHash,blockNumber,from,to,cumulativeGasUsed,gasUsed,contractAddress,const DeepCollectionEquality().hash(_logs),logsBloom,status,effectiveGasPrice,type);

@override
String toString() {
  return 'TransactionReceipt(transactionHash: $transactionHash, transactionIndex: $transactionIndex, blockHash: $blockHash, blockNumber: $blockNumber, from: $from, to: $to, cumulativeGasUsed: $cumulativeGasUsed, gasUsed: $gasUsed, contractAddress: $contractAddress, logs: $logs, logsBloom: $logsBloom, status: $status, effectiveGasPrice: $effectiveGasPrice, type: $type)';
}


}

/// @nodoc
abstract mixin class _$TransactionReceiptCopyWith<$Res> implements $TransactionReceiptCopyWith<$Res> {
  factory _$TransactionReceiptCopyWith(_TransactionReceipt value, $Res Function(_TransactionReceipt) _then) = __$TransactionReceiptCopyWithImpl;
@override @useResult
$Res call({
 String transactionHash,@HexIntConverter() int transactionIndex, String blockHash,@HexBigIntConverter() BigInt blockNumber, String from, String? to,@HexBigIntConverter() BigInt cumulativeGasUsed,@HexBigIntConverter() BigInt gasUsed, String? contractAddress, List<Log> logs, String logsBloom,@HexIntNConverter() int? status,@HexBigIntNConverter() BigInt? effectiveGasPrice,@HexIntNConverter() int? type
});




}
/// @nodoc
class __$TransactionReceiptCopyWithImpl<$Res>
    implements _$TransactionReceiptCopyWith<$Res> {
  __$TransactionReceiptCopyWithImpl(this._self, this._then);

  final _TransactionReceipt _self;
  final $Res Function(_TransactionReceipt) _then;

/// Create a copy of TransactionReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionHash = null,Object? transactionIndex = null,Object? blockHash = null,Object? blockNumber = null,Object? from = null,Object? to = freezed,Object? cumulativeGasUsed = null,Object? gasUsed = null,Object? contractAddress = freezed,Object? logs = null,Object? logsBloom = null,Object? status = freezed,Object? effectiveGasPrice = freezed,Object? type = freezed,}) {
  return _then(_TransactionReceipt(
transactionHash: null == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String,transactionIndex: null == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int,blockHash: null == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String,blockNumber: null == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,cumulativeGasUsed: null == cumulativeGasUsed ? _self.cumulativeGasUsed : cumulativeGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<Log>,logsBloom: null == logsBloom ? _self.logsBloom : logsBloom // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,effectiveGasPrice: freezed == effectiveGasPrice ? _self.effectiveGasPrice : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
