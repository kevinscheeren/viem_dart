// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transaction {

 String get hash;@HexIntConverter() int get nonce; String? get blockHash;@HexBigIntNConverter() BigInt? get blockNumber;@HexIntNConverter() int? get transactionIndex; String get from; String? get to;@HexBigIntConverter() BigInt get value;@HexBigIntConverter() BigInt get gas;@HexBigIntNConverter() BigInt? get gasPrice;@HexBigIntNConverter() BigInt? get maxFeePerGas;@HexBigIntNConverter() BigInt? get maxPriorityFeePerGas; String get input;@HexIntNConverter() int? get type;@HexBigIntNConverter() BigInt? get chainId; String? get v; String? get r; String? get s; List<Object?>? get accessList;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.input, input) || other.input == input)&&(identical(other.type, type) || other.type == type)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.v, v) || other.v == v)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s)&&const DeepCollectionEquality().equals(other.accessList, accessList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,hash,nonce,blockHash,blockNumber,transactionIndex,from,to,value,gas,gasPrice,maxFeePerGas,maxPriorityFeePerGas,input,type,chainId,v,r,s,const DeepCollectionEquality().hash(accessList)]);

@override
String toString() {
  return 'Transaction(hash: $hash, nonce: $nonce, blockHash: $blockHash, blockNumber: $blockNumber, transactionIndex: $transactionIndex, from: $from, to: $to, value: $value, gas: $gas, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, input: $input, type: $type, chainId: $chainId, v: $v, r: $r, s: $s, accessList: $accessList)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String hash,@HexIntConverter() int nonce, String? blockHash,@HexBigIntNConverter() BigInt? blockNumber,@HexIntNConverter() int? transactionIndex, String from, String? to,@HexBigIntConverter() BigInt value,@HexBigIntConverter() BigInt gas,@HexBigIntNConverter() BigInt? gasPrice,@HexBigIntNConverter() BigInt? maxFeePerGas,@HexBigIntNConverter() BigInt? maxPriorityFeePerGas, String input,@HexIntNConverter() int? type,@HexBigIntNConverter() BigInt? chainId, String? v, String? r, String? s, List<Object?>? accessList
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hash = null,Object? nonce = null,Object? blockHash = freezed,Object? blockNumber = freezed,Object? transactionIndex = freezed,Object? from = null,Object? to = freezed,Object? value = null,Object? gas = null,Object? gasPrice = freezed,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? input = null,Object? type = freezed,Object? chainId = freezed,Object? v = freezed,Object? r = freezed,Object? s = freezed,Object? accessList = freezed,}) {
  return _then(Transaction(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as int,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,gas: null == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as BigInt,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt?,v: freezed == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as String?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as String?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String?,accessList: freezed == accessList ? _self.accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<Object?>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String hash, @HexIntConverter()  int nonce,  String? blockHash, @HexBigIntNConverter()  BigInt? blockNumber, @HexIntNConverter()  int? transactionIndex,  String from,  String? to, @HexBigIntConverter()  BigInt value, @HexBigIntConverter()  BigInt gas, @HexBigIntNConverter()  BigInt? gasPrice, @HexBigIntNConverter()  BigInt? maxFeePerGas, @HexBigIntNConverter()  BigInt? maxPriorityFeePerGas,  String input, @HexIntNConverter()  int? type, @HexBigIntNConverter()  BigInt? chainId,  String? v,  String? r,  String? s,  List<Object?>? accessList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.hash,_that.nonce,_that.blockHash,_that.blockNumber,_that.transactionIndex,_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.type,_that.chainId,_that.v,_that.r,_that.s,_that.accessList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String hash, @HexIntConverter()  int nonce,  String? blockHash, @HexBigIntNConverter()  BigInt? blockNumber, @HexIntNConverter()  int? transactionIndex,  String from,  String? to, @HexBigIntConverter()  BigInt value, @HexBigIntConverter()  BigInt gas, @HexBigIntNConverter()  BigInt? gasPrice, @HexBigIntNConverter()  BigInt? maxFeePerGas, @HexBigIntNConverter()  BigInt? maxPriorityFeePerGas,  String input, @HexIntNConverter()  int? type, @HexBigIntNConverter()  BigInt? chainId,  String? v,  String? r,  String? s,  List<Object?>? accessList)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.hash,_that.nonce,_that.blockHash,_that.blockNumber,_that.transactionIndex,_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.type,_that.chainId,_that.v,_that.r,_that.s,_that.accessList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String hash, @HexIntConverter()  int nonce,  String? blockHash, @HexBigIntNConverter()  BigInt? blockNumber, @HexIntNConverter()  int? transactionIndex,  String from,  String? to, @HexBigIntConverter()  BigInt value, @HexBigIntConverter()  BigInt gas, @HexBigIntNConverter()  BigInt? gasPrice, @HexBigIntNConverter()  BigInt? maxFeePerGas, @HexBigIntNConverter()  BigInt? maxPriorityFeePerGas,  String input, @HexIntNConverter()  int? type, @HexBigIntNConverter()  BigInt? chainId,  String? v,  String? r,  String? s,  List<Object?>? accessList)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.hash,_that.nonce,_that.blockHash,_that.blockNumber,_that.transactionIndex,_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.type,_that.chainId,_that.v,_that.r,_that.s,_that.accessList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transaction implements Transaction {
  const _Transaction({required this.hash, @HexIntConverter() required this.nonce, this.blockHash, @HexBigIntNConverter() this.blockNumber, @HexIntNConverter() this.transactionIndex, required this.from, this.to, @HexBigIntConverter() required this.value, @HexBigIntConverter() required this.gas, @HexBigIntNConverter() this.gasPrice, @HexBigIntNConverter() this.maxFeePerGas, @HexBigIntNConverter() this.maxPriorityFeePerGas, required this.input, @HexIntNConverter() this.type, @HexBigIntNConverter() this.chainId, this.v, this.r, this.s,  List<Object?>? accessList}): _accessList = accessList;
  factory _Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

@override final  String hash;
@override@HexIntConverter() final  int nonce;
@override final  String? blockHash;
@override@HexBigIntNConverter() final  BigInt? blockNumber;
@override@HexIntNConverter() final  int? transactionIndex;
@override final  String from;
@override final  String? to;
@override@HexBigIntConverter() final  BigInt value;
@override@HexBigIntConverter() final  BigInt gas;
@override@HexBigIntNConverter() final  BigInt? gasPrice;
@override@HexBigIntNConverter() final  BigInt? maxFeePerGas;
@override@HexBigIntNConverter() final  BigInt? maxPriorityFeePerGas;
@override final  String input;
@override@HexIntNConverter() final  int? type;
@override@HexBigIntNConverter() final  BigInt? chainId;
@override final  String? v;
@override final  String? r;
@override final  String? s;
 final  List<Object?>? _accessList;
@override List<Object?>? get accessList {
  final value = _accessList;
  if (value == null) return null;
  if (_accessList is EqualUnmodifiableListView) return _accessList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.input, input) || other.input == input)&&(identical(other.type, type) || other.type == type)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.v, v) || other.v == v)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s)&&const DeepCollectionEquality().equals(other._accessList, _accessList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,hash,nonce,blockHash,blockNumber,transactionIndex,from,to,value,gas,gasPrice,maxFeePerGas,maxPriorityFeePerGas,input,type,chainId,v,r,s,const DeepCollectionEquality().hash(_accessList)]);

@override
String toString() {
  return 'Transaction(hash: $hash, nonce: $nonce, blockHash: $blockHash, blockNumber: $blockNumber, transactionIndex: $transactionIndex, from: $from, to: $to, value: $value, gas: $gas, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, input: $input, type: $type, chainId: $chainId, v: $v, r: $r, s: $s, accessList: $accessList)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String hash,@HexIntConverter() int nonce, String? blockHash,@HexBigIntNConverter() BigInt? blockNumber,@HexIntNConverter() int? transactionIndex, String from, String? to,@HexBigIntConverter() BigInt value,@HexBigIntConverter() BigInt gas,@HexBigIntNConverter() BigInt? gasPrice,@HexBigIntNConverter() BigInt? maxFeePerGas,@HexBigIntNConverter() BigInt? maxPriorityFeePerGas, String input,@HexIntNConverter() int? type,@HexBigIntNConverter() BigInt? chainId, String? v, String? r, String? s, List<Object?>? accessList
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hash = null,Object? nonce = null,Object? blockHash = freezed,Object? blockNumber = freezed,Object? transactionIndex = freezed,Object? from = null,Object? to = freezed,Object? value = null,Object? gas = null,Object? gasPrice = freezed,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? input = null,Object? type = freezed,Object? chainId = freezed,Object? v = freezed,Object? r = freezed,Object? s = freezed,Object? accessList = freezed,}) {
  return _then(_Transaction(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as int,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as int?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,gas: null == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as BigInt,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt?,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt?,v: freezed == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as String?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as String?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String?,accessList: freezed == accessList ? _self._accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<Object?>?,
  ));
}


}

// dart format on
