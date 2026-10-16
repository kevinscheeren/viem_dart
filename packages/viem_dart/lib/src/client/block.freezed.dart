// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Block {

@HexBigIntNConverter() BigInt? get number; String? get hash; String get parentHash; String? get nonce; String get sha3Uncles; String? get logsBloom; String get transactionsRoot; String get stateRoot; String get receiptsRoot; String get miner;@HexBigIntConverter() BigInt get difficulty;@HexBigIntNConverter() BigInt? get totalDifficulty; String get extraData;@HexBigIntConverter() BigInt get size;@HexBigIntConverter() BigInt get gasLimit;@HexBigIntConverter() BigInt get gasUsed;@HexBigIntConverter() BigInt get timestamp; List<String> get transactions; List<String> get uncles;@HexBigIntNConverter() BigInt? get baseFeePerGas; String? get mixHash; String? get withdrawalsRoot;@HexBigIntNConverter() BigInt? get blobGasUsed;@HexBigIntNConverter() BigInt? get excessBlobGasUsed;
/// Create a copy of Block
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockCopyWith<Block> get copyWith => _$BlockCopyWithImpl<Block>(this as Block, _$identity);

  /// Serializes this Block to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Block&&(identical(other.number, number) || other.number == number)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.parentHash, parentHash) || other.parentHash == parentHash)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.sha3Uncles, sha3Uncles) || other.sha3Uncles == sha3Uncles)&&(identical(other.logsBloom, logsBloom) || other.logsBloom == logsBloom)&&(identical(other.transactionsRoot, transactionsRoot) || other.transactionsRoot == transactionsRoot)&&(identical(other.stateRoot, stateRoot) || other.stateRoot == stateRoot)&&(identical(other.receiptsRoot, receiptsRoot) || other.receiptsRoot == receiptsRoot)&&(identical(other.miner, miner) || other.miner == miner)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalDifficulty, totalDifficulty) || other.totalDifficulty == totalDifficulty)&&(identical(other.extraData, extraData) || other.extraData == extraData)&&(identical(other.size, size) || other.size == size)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.uncles, uncles)&&(identical(other.baseFeePerGas, baseFeePerGas) || other.baseFeePerGas == baseFeePerGas)&&(identical(other.mixHash, mixHash) || other.mixHash == mixHash)&&(identical(other.withdrawalsRoot, withdrawalsRoot) || other.withdrawalsRoot == withdrawalsRoot)&&(identical(other.blobGasUsed, blobGasUsed) || other.blobGasUsed == blobGasUsed)&&(identical(other.excessBlobGasUsed, excessBlobGasUsed) || other.excessBlobGasUsed == excessBlobGasUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,number,hash,parentHash,nonce,sha3Uncles,logsBloom,transactionsRoot,stateRoot,receiptsRoot,miner,difficulty,totalDifficulty,extraData,size,gasLimit,gasUsed,timestamp,const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(uncles),baseFeePerGas,mixHash,withdrawalsRoot,blobGasUsed,excessBlobGasUsed]);

@override
String toString() {
  return 'Block(number: $number, hash: $hash, parentHash: $parentHash, nonce: $nonce, sha3Uncles: $sha3Uncles, logsBloom: $logsBloom, transactionsRoot: $transactionsRoot, stateRoot: $stateRoot, receiptsRoot: $receiptsRoot, miner: $miner, difficulty: $difficulty, totalDifficulty: $totalDifficulty, extraData: $extraData, size: $size, gasLimit: $gasLimit, gasUsed: $gasUsed, timestamp: $timestamp, transactions: $transactions, uncles: $uncles, baseFeePerGas: $baseFeePerGas, mixHash: $mixHash, withdrawalsRoot: $withdrawalsRoot, blobGasUsed: $blobGasUsed, excessBlobGasUsed: $excessBlobGasUsed)';
}


}

/// @nodoc
abstract mixin class $BlockCopyWith<$Res>  {
  factory $BlockCopyWith(Block value, $Res Function(Block) _then) = _$BlockCopyWithImpl;
@useResult
$Res call({
@HexBigIntNConverter() BigInt? number, String? hash, String parentHash, String? nonce, String sha3Uncles, String? logsBloom, String transactionsRoot, String stateRoot, String receiptsRoot, String miner,@HexBigIntConverter() BigInt difficulty,@HexBigIntNConverter() BigInt? totalDifficulty, String extraData,@HexBigIntConverter() BigInt size,@HexBigIntConverter() BigInt gasLimit,@HexBigIntConverter() BigInt gasUsed,@HexBigIntConverter() BigInt timestamp, List<String> transactions, List<String> uncles,@HexBigIntNConverter() BigInt? baseFeePerGas, String? mixHash, String? withdrawalsRoot,@HexBigIntNConverter() BigInt? blobGasUsed,@HexBigIntNConverter() BigInt? excessBlobGasUsed
});




}
/// @nodoc
class _$BlockCopyWithImpl<$Res>
    implements $BlockCopyWith<$Res> {
  _$BlockCopyWithImpl(this._self, this._then);

  final Block _self;
  final $Res Function(Block) _then;

/// Create a copy of Block
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = freezed,Object? hash = freezed,Object? parentHash = null,Object? nonce = freezed,Object? sha3Uncles = null,Object? logsBloom = freezed,Object? transactionsRoot = null,Object? stateRoot = null,Object? receiptsRoot = null,Object? miner = null,Object? difficulty = null,Object? totalDifficulty = freezed,Object? extraData = null,Object? size = null,Object? gasLimit = null,Object? gasUsed = null,Object? timestamp = null,Object? transactions = null,Object? uncles = null,Object? baseFeePerGas = freezed,Object? mixHash = freezed,Object? withdrawalsRoot = freezed,Object? blobGasUsed = freezed,Object? excessBlobGasUsed = freezed,}) {
  return _then(Block(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as BigInt?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,parentHash: null == parentHash ? _self.parentHash : parentHash // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,sha3Uncles: null == sha3Uncles ? _self.sha3Uncles : sha3Uncles // ignore: cast_nullable_to_non_nullable
as String,logsBloom: freezed == logsBloom ? _self.logsBloom : logsBloom // ignore: cast_nullable_to_non_nullable
as String?,transactionsRoot: null == transactionsRoot ? _self.transactionsRoot : transactionsRoot // ignore: cast_nullable_to_non_nullable
as String,stateRoot: null == stateRoot ? _self.stateRoot : stateRoot // ignore: cast_nullable_to_non_nullable
as String,receiptsRoot: null == receiptsRoot ? _self.receiptsRoot : receiptsRoot // ignore: cast_nullable_to_non_nullable
as String,miner: null == miner ? _self.miner : miner // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as BigInt,totalDifficulty: freezed == totalDifficulty ? _self.totalDifficulty : totalDifficulty // ignore: cast_nullable_to_non_nullable
as BigInt?,extraData: null == extraData ? _self.extraData : extraData // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as BigInt,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<String>,uncles: null == uncles ? _self.uncles : uncles // ignore: cast_nullable_to_non_nullable
as List<String>,baseFeePerGas: freezed == baseFeePerGas ? _self.baseFeePerGas : baseFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,mixHash: freezed == mixHash ? _self.mixHash : mixHash // ignore: cast_nullable_to_non_nullable
as String?,withdrawalsRoot: freezed == withdrawalsRoot ? _self.withdrawalsRoot : withdrawalsRoot // ignore: cast_nullable_to_non_nullable
as String?,blobGasUsed: freezed == blobGasUsed ? _self.blobGasUsed : blobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,excessBlobGasUsed: freezed == excessBlobGasUsed ? _self.excessBlobGasUsed : excessBlobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

}


/// Adds pattern-matching-related methods to [Block].
extension BlockPatterns on Block {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Block value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Block() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Block value)  $default,){
final _that = this;
switch (_that) {
case _Block():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Block value)?  $default,){
final _that = this;
switch (_that) {
case _Block() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HexBigIntNConverter()  BigInt? number,  String? hash,  String parentHash,  String? nonce,  String sha3Uncles,  String? logsBloom,  String transactionsRoot,  String stateRoot,  String receiptsRoot,  String miner, @HexBigIntConverter()  BigInt difficulty, @HexBigIntNConverter()  BigInt? totalDifficulty,  String extraData, @HexBigIntConverter()  BigInt size, @HexBigIntConverter()  BigInt gasLimit, @HexBigIntConverter()  BigInt gasUsed, @HexBigIntConverter()  BigInt timestamp,  List<String> transactions,  List<String> uncles, @HexBigIntNConverter()  BigInt? baseFeePerGas,  String? mixHash,  String? withdrawalsRoot, @HexBigIntNConverter()  BigInt? blobGasUsed, @HexBigIntNConverter()  BigInt? excessBlobGasUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Block() when $default != null:
return $default(_that.number,_that.hash,_that.parentHash,_that.nonce,_that.sha3Uncles,_that.logsBloom,_that.transactionsRoot,_that.stateRoot,_that.receiptsRoot,_that.miner,_that.difficulty,_that.totalDifficulty,_that.extraData,_that.size,_that.gasLimit,_that.gasUsed,_that.timestamp,_that.transactions,_that.uncles,_that.baseFeePerGas,_that.mixHash,_that.withdrawalsRoot,_that.blobGasUsed,_that.excessBlobGasUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HexBigIntNConverter()  BigInt? number,  String? hash,  String parentHash,  String? nonce,  String sha3Uncles,  String? logsBloom,  String transactionsRoot,  String stateRoot,  String receiptsRoot,  String miner, @HexBigIntConverter()  BigInt difficulty, @HexBigIntNConverter()  BigInt? totalDifficulty,  String extraData, @HexBigIntConverter()  BigInt size, @HexBigIntConverter()  BigInt gasLimit, @HexBigIntConverter()  BigInt gasUsed, @HexBigIntConverter()  BigInt timestamp,  List<String> transactions,  List<String> uncles, @HexBigIntNConverter()  BigInt? baseFeePerGas,  String? mixHash,  String? withdrawalsRoot, @HexBigIntNConverter()  BigInt? blobGasUsed, @HexBigIntNConverter()  BigInt? excessBlobGasUsed)  $default,) {final _that = this;
switch (_that) {
case _Block():
return $default(_that.number,_that.hash,_that.parentHash,_that.nonce,_that.sha3Uncles,_that.logsBloom,_that.transactionsRoot,_that.stateRoot,_that.receiptsRoot,_that.miner,_that.difficulty,_that.totalDifficulty,_that.extraData,_that.size,_that.gasLimit,_that.gasUsed,_that.timestamp,_that.transactions,_that.uncles,_that.baseFeePerGas,_that.mixHash,_that.withdrawalsRoot,_that.blobGasUsed,_that.excessBlobGasUsed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HexBigIntNConverter()  BigInt? number,  String? hash,  String parentHash,  String? nonce,  String sha3Uncles,  String? logsBloom,  String transactionsRoot,  String stateRoot,  String receiptsRoot,  String miner, @HexBigIntConverter()  BigInt difficulty, @HexBigIntNConverter()  BigInt? totalDifficulty,  String extraData, @HexBigIntConverter()  BigInt size, @HexBigIntConverter()  BigInt gasLimit, @HexBigIntConverter()  BigInt gasUsed, @HexBigIntConverter()  BigInt timestamp,  List<String> transactions,  List<String> uncles, @HexBigIntNConverter()  BigInt? baseFeePerGas,  String? mixHash,  String? withdrawalsRoot, @HexBigIntNConverter()  BigInt? blobGasUsed, @HexBigIntNConverter()  BigInt? excessBlobGasUsed)?  $default,) {final _that = this;
switch (_that) {
case _Block() when $default != null:
return $default(_that.number,_that.hash,_that.parentHash,_that.nonce,_that.sha3Uncles,_that.logsBloom,_that.transactionsRoot,_that.stateRoot,_that.receiptsRoot,_that.miner,_that.difficulty,_that.totalDifficulty,_that.extraData,_that.size,_that.gasLimit,_that.gasUsed,_that.timestamp,_that.transactions,_that.uncles,_that.baseFeePerGas,_that.mixHash,_that.withdrawalsRoot,_that.blobGasUsed,_that.excessBlobGasUsed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Block implements Block {
  const _Block({@HexBigIntNConverter() this.number, this.hash, required this.parentHash, this.nonce, required this.sha3Uncles, this.logsBloom, required this.transactionsRoot, required this.stateRoot, required this.receiptsRoot, required this.miner, @HexBigIntConverter() required this.difficulty, @HexBigIntNConverter() this.totalDifficulty, required this.extraData, @HexBigIntConverter() required this.size, @HexBigIntConverter() required this.gasLimit, @HexBigIntConverter() required this.gasUsed, @HexBigIntConverter() required this.timestamp, required  List<String> transactions, required  List<String> uncles, @HexBigIntNConverter() this.baseFeePerGas, this.mixHash, this.withdrawalsRoot, @HexBigIntNConverter() this.blobGasUsed, @HexBigIntNConverter() this.excessBlobGasUsed}): _transactions = transactions,_uncles = uncles;
  factory _Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);

@override@HexBigIntNConverter() final  BigInt? number;
@override final  String? hash;
@override final  String parentHash;
@override final  String? nonce;
@override final  String sha3Uncles;
@override final  String? logsBloom;
@override final  String transactionsRoot;
@override final  String stateRoot;
@override final  String receiptsRoot;
@override final  String miner;
@override@HexBigIntConverter() final  BigInt difficulty;
@override@HexBigIntNConverter() final  BigInt? totalDifficulty;
@override final  String extraData;
@override@HexBigIntConverter() final  BigInt size;
@override@HexBigIntConverter() final  BigInt gasLimit;
@override@HexBigIntConverter() final  BigInt gasUsed;
@override@HexBigIntConverter() final  BigInt timestamp;
 final  List<String> _transactions;
@override List<String> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<String> _uncles;
@override List<String> get uncles {
  if (_uncles is EqualUnmodifiableListView) return _uncles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uncles);
}

@override@HexBigIntNConverter() final  BigInt? baseFeePerGas;
@override final  String? mixHash;
@override final  String? withdrawalsRoot;
@override@HexBigIntNConverter() final  BigInt? blobGasUsed;
@override@HexBigIntNConverter() final  BigInt? excessBlobGasUsed;

/// Create a copy of Block
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockCopyWith<_Block> get copyWith => __$BlockCopyWithImpl<_Block>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Block&&(identical(other.number, number) || other.number == number)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.parentHash, parentHash) || other.parentHash == parentHash)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.sha3Uncles, sha3Uncles) || other.sha3Uncles == sha3Uncles)&&(identical(other.logsBloom, logsBloom) || other.logsBloom == logsBloom)&&(identical(other.transactionsRoot, transactionsRoot) || other.transactionsRoot == transactionsRoot)&&(identical(other.stateRoot, stateRoot) || other.stateRoot == stateRoot)&&(identical(other.receiptsRoot, receiptsRoot) || other.receiptsRoot == receiptsRoot)&&(identical(other.miner, miner) || other.miner == miner)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.totalDifficulty, totalDifficulty) || other.totalDifficulty == totalDifficulty)&&(identical(other.extraData, extraData) || other.extraData == extraData)&&(identical(other.size, size) || other.size == size)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._uncles, _uncles)&&(identical(other.baseFeePerGas, baseFeePerGas) || other.baseFeePerGas == baseFeePerGas)&&(identical(other.mixHash, mixHash) || other.mixHash == mixHash)&&(identical(other.withdrawalsRoot, withdrawalsRoot) || other.withdrawalsRoot == withdrawalsRoot)&&(identical(other.blobGasUsed, blobGasUsed) || other.blobGasUsed == blobGasUsed)&&(identical(other.excessBlobGasUsed, excessBlobGasUsed) || other.excessBlobGasUsed == excessBlobGasUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,number,hash,parentHash,nonce,sha3Uncles,logsBloom,transactionsRoot,stateRoot,receiptsRoot,miner,difficulty,totalDifficulty,extraData,size,gasLimit,gasUsed,timestamp,const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_uncles),baseFeePerGas,mixHash,withdrawalsRoot,blobGasUsed,excessBlobGasUsed]);

@override
String toString() {
  return 'Block(number: $number, hash: $hash, parentHash: $parentHash, nonce: $nonce, sha3Uncles: $sha3Uncles, logsBloom: $logsBloom, transactionsRoot: $transactionsRoot, stateRoot: $stateRoot, receiptsRoot: $receiptsRoot, miner: $miner, difficulty: $difficulty, totalDifficulty: $totalDifficulty, extraData: $extraData, size: $size, gasLimit: $gasLimit, gasUsed: $gasUsed, timestamp: $timestamp, transactions: $transactions, uncles: $uncles, baseFeePerGas: $baseFeePerGas, mixHash: $mixHash, withdrawalsRoot: $withdrawalsRoot, blobGasUsed: $blobGasUsed, excessBlobGasUsed: $excessBlobGasUsed)';
}


}

/// @nodoc
abstract mixin class _$BlockCopyWith<$Res> implements $BlockCopyWith<$Res> {
  factory _$BlockCopyWith(_Block value, $Res Function(_Block) _then) = __$BlockCopyWithImpl;
@override @useResult
$Res call({
@HexBigIntNConverter() BigInt? number, String? hash, String parentHash, String? nonce, String sha3Uncles, String? logsBloom, String transactionsRoot, String stateRoot, String receiptsRoot, String miner,@HexBigIntConverter() BigInt difficulty,@HexBigIntNConverter() BigInt? totalDifficulty, String extraData,@HexBigIntConverter() BigInt size,@HexBigIntConverter() BigInt gasLimit,@HexBigIntConverter() BigInt gasUsed,@HexBigIntConverter() BigInt timestamp, List<String> transactions, List<String> uncles,@HexBigIntNConverter() BigInt? baseFeePerGas, String? mixHash, String? withdrawalsRoot,@HexBigIntNConverter() BigInt? blobGasUsed,@HexBigIntNConverter() BigInt? excessBlobGasUsed
});




}
/// @nodoc
class __$BlockCopyWithImpl<$Res>
    implements _$BlockCopyWith<$Res> {
  __$BlockCopyWithImpl(this._self, this._then);

  final _Block _self;
  final $Res Function(_Block) _then;

/// Create a copy of Block
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = freezed,Object? hash = freezed,Object? parentHash = null,Object? nonce = freezed,Object? sha3Uncles = null,Object? logsBloom = freezed,Object? transactionsRoot = null,Object? stateRoot = null,Object? receiptsRoot = null,Object? miner = null,Object? difficulty = null,Object? totalDifficulty = freezed,Object? extraData = null,Object? size = null,Object? gasLimit = null,Object? gasUsed = null,Object? timestamp = null,Object? transactions = null,Object? uncles = null,Object? baseFeePerGas = freezed,Object? mixHash = freezed,Object? withdrawalsRoot = freezed,Object? blobGasUsed = freezed,Object? excessBlobGasUsed = freezed,}) {
  return _then(_Block(
number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as BigInt?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,parentHash: null == parentHash ? _self.parentHash : parentHash // ignore: cast_nullable_to_non_nullable
as String,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,sha3Uncles: null == sha3Uncles ? _self.sha3Uncles : sha3Uncles // ignore: cast_nullable_to_non_nullable
as String,logsBloom: freezed == logsBloom ? _self.logsBloom : logsBloom // ignore: cast_nullable_to_non_nullable
as String?,transactionsRoot: null == transactionsRoot ? _self.transactionsRoot : transactionsRoot // ignore: cast_nullable_to_non_nullable
as String,stateRoot: null == stateRoot ? _self.stateRoot : stateRoot // ignore: cast_nullable_to_non_nullable
as String,receiptsRoot: null == receiptsRoot ? _self.receiptsRoot : receiptsRoot // ignore: cast_nullable_to_non_nullable
as String,miner: null == miner ? _self.miner : miner // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as BigInt,totalDifficulty: freezed == totalDifficulty ? _self.totalDifficulty : totalDifficulty // ignore: cast_nullable_to_non_nullable
as BigInt?,extraData: null == extraData ? _self.extraData : extraData // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as BigInt,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<String>,uncles: null == uncles ? _self._uncles : uncles // ignore: cast_nullable_to_non_nullable
as List<String>,baseFeePerGas: freezed == baseFeePerGas ? _self.baseFeePerGas : baseFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt?,mixHash: freezed == mixHash ? _self.mixHash : mixHash // ignore: cast_nullable_to_non_nullable
as String?,withdrawalsRoot: freezed == withdrawalsRoot ? _self.withdrawalsRoot : withdrawalsRoot // ignore: cast_nullable_to_non_nullable
as String?,blobGasUsed: freezed == blobGasUsed ? _self.blobGasUsed : blobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,excessBlobGasUsed: freezed == excessBlobGasUsed ? _self.excessBlobGasUsed : excessBlobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

// dart format on
