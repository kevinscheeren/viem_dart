// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_envelope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionEnvelope {

 BigInt get nonce; BigInt get gasLimit;/// Required (never `null`) — blob transactions can't create contracts.
 String? get to; BigInt get value; Uint8List get data;/// `null` = pre-EIP-155 (no replay protection — effectively unused
/// today); set = EIP-155's `v = chainId*2 + 35 + yParity` scheme,
/// which every modern signer uses unconditionally.
 BigInt? get chainId; int? get yParity; BigInt? get r; BigInt? get s;
/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionEnvelopeCopyWith<TransactionEnvelope> get copyWith => _$TransactionEnvelopeCopyWithImpl<TransactionEnvelope>(this as TransactionEnvelope, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionEnvelope&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,nonce,gasLimit,to,value,const DeepCollectionEquality().hash(data),chainId,yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope(nonce: $nonce, gasLimit: $gasLimit, to: $to, value: $value, data: $data, chainId: $chainId, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $TransactionEnvelopeCopyWith<$Res>  {
  factory $TransactionEnvelopeCopyWith(TransactionEnvelope value, $Res Function(TransactionEnvelope) _then) = _$TransactionEnvelopeCopyWithImpl;
@useResult
$Res call({
 BigInt nonce, BigInt gasLimit, String to, BigInt value, Uint8List data, BigInt chainId, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$TransactionEnvelopeCopyWithImpl<$Res>
    implements $TransactionEnvelopeCopyWith<$Res> {
  _$TransactionEnvelopeCopyWithImpl(this._self, this._then);

  final TransactionEnvelope _self;
  final $Res Function(TransactionEnvelope) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nonce = null,Object? gasLimit = null,Object? to = null,Object? value = null,Object? data = null,Object? chainId = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(_self.copyWith(
nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: null == to ? _self.to! : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,chainId: null == chainId ? _self.chainId! : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionEnvelope].
extension TransactionEnvelopePatterns on TransactionEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LegacyTransaction value)?  legacy,TResult Function( Eip2930Transaction value)?  eip2930,TResult Function( Eip1559Transaction value)?  eip1559,TResult Function( Eip7702Transaction value)?  eip7702,TResult Function( Eip4844Transaction value)?  eip4844,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LegacyTransaction() when legacy != null:
return legacy(_that);case Eip2930Transaction() when eip2930 != null:
return eip2930(_that);case Eip1559Transaction() when eip1559 != null:
return eip1559(_that);case Eip7702Transaction() when eip7702 != null:
return eip7702(_that);case Eip4844Transaction() when eip4844 != null:
return eip4844(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LegacyTransaction value)  legacy,required TResult Function( Eip2930Transaction value)  eip2930,required TResult Function( Eip1559Transaction value)  eip1559,required TResult Function( Eip7702Transaction value)  eip7702,required TResult Function( Eip4844Transaction value)  eip4844,}){
final _that = this;
switch (_that) {
case LegacyTransaction():
return legacy(_that);case Eip2930Transaction():
return eip2930(_that);case Eip1559Transaction():
return eip1559(_that);case Eip7702Transaction():
return eip7702(_that);case Eip4844Transaction():
return eip4844(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LegacyTransaction value)?  legacy,TResult? Function( Eip2930Transaction value)?  eip2930,TResult? Function( Eip1559Transaction value)?  eip1559,TResult? Function( Eip7702Transaction value)?  eip7702,TResult? Function( Eip4844Transaction value)?  eip4844,}){
final _that = this;
switch (_that) {
case LegacyTransaction() when legacy != null:
return legacy(_that);case Eip2930Transaction() when eip2930 != null:
return eip2930(_that);case Eip1559Transaction() when eip1559 != null:
return eip1559(_that);case Eip7702Transaction() when eip7702 != null:
return eip7702(_that);case Eip4844Transaction() when eip4844 != null:
return eip4844(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  BigInt? chainId,  int? yParity,  BigInt? r,  BigInt? s)?  legacy,TResult Function( BigInt chainId,  BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)?  eip2930,TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)?  eip1559,TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  List<Authorization> authorizationList,  int? yParity,  BigInt? r,  BigInt? s)?  eip7702,TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  BigInt maxFeePerBlobGas,  List<Uint8List> blobVersionedHashes,  int? yParity,  BigInt? r,  BigInt? s)?  eip4844,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LegacyTransaction() when legacy != null:
return legacy(_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.chainId,_that.yParity,_that.r,_that.s);case Eip2930Transaction() when eip2930 != null:
return eip2930(_that.chainId,_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip1559Transaction() when eip1559 != null:
return eip1559(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip7702Transaction() when eip7702 != null:
return eip7702(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.authorizationList,_that.yParity,_that.r,_that.s);case Eip4844Transaction() when eip4844 != null:
return eip4844(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.maxFeePerBlobGas,_that.blobVersionedHashes,_that.yParity,_that.r,_that.s);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  BigInt? chainId,  int? yParity,  BigInt? r,  BigInt? s)  legacy,required TResult Function( BigInt chainId,  BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)  eip2930,required TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)  eip1559,required TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  List<Authorization> authorizationList,  int? yParity,  BigInt? r,  BigInt? s)  eip7702,required TResult Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  BigInt maxFeePerBlobGas,  List<Uint8List> blobVersionedHashes,  int? yParity,  BigInt? r,  BigInt? s)  eip4844,}) {final _that = this;
switch (_that) {
case LegacyTransaction():
return legacy(_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.chainId,_that.yParity,_that.r,_that.s);case Eip2930Transaction():
return eip2930(_that.chainId,_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip1559Transaction():
return eip1559(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip7702Transaction():
return eip7702(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.authorizationList,_that.yParity,_that.r,_that.s);case Eip4844Transaction():
return eip4844(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.maxFeePerBlobGas,_that.blobVersionedHashes,_that.yParity,_that.r,_that.s);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  BigInt? chainId,  int? yParity,  BigInt? r,  BigInt? s)?  legacy,TResult? Function( BigInt chainId,  BigInt nonce,  BigInt gasPrice,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)?  eip2930,TResult? Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  int? yParity,  BigInt? r,  BigInt? s)?  eip1559,TResult? Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String? to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  List<Authorization> authorizationList,  int? yParity,  BigInt? r,  BigInt? s)?  eip7702,TResult? Function( BigInt chainId,  BigInt nonce,  BigInt maxPriorityFeePerGas,  BigInt maxFeePerGas,  BigInt gasLimit,  String to,  BigInt value,  Uint8List data,  List<AccessListEntry> accessList,  BigInt maxFeePerBlobGas,  List<Uint8List> blobVersionedHashes,  int? yParity,  BigInt? r,  BigInt? s)?  eip4844,}) {final _that = this;
switch (_that) {
case LegacyTransaction() when legacy != null:
return legacy(_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.chainId,_that.yParity,_that.r,_that.s);case Eip2930Transaction() when eip2930 != null:
return eip2930(_that.chainId,_that.nonce,_that.gasPrice,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip1559Transaction() when eip1559 != null:
return eip1559(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.yParity,_that.r,_that.s);case Eip7702Transaction() when eip7702 != null:
return eip7702(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.authorizationList,_that.yParity,_that.r,_that.s);case Eip4844Transaction() when eip4844 != null:
return eip4844(_that.chainId,_that.nonce,_that.maxPriorityFeePerGas,_that.maxFeePerGas,_that.gasLimit,_that.to,_that.value,_that.data,_that.accessList,_that.maxFeePerBlobGas,_that.blobVersionedHashes,_that.yParity,_that.r,_that.s);case _:
  return null;

}
}

}

/// @nodoc


class LegacyTransaction implements TransactionEnvelope {
  const LegacyTransaction({required this.nonce, required this.gasPrice, required this.gasLimit, this.to, required this.value, required this.data, this.chainId, this.yParity, this.r, this.s});
  

@override final  BigInt nonce;
 final  BigInt gasPrice;
@override final  BigInt gasLimit;
@override final  String? to;
@override final  BigInt value;
@override final  Uint8List data;
/// `null` = pre-EIP-155 (no replay protection — effectively unused
/// today); set = EIP-155's `v = chainId*2 + 35 + yParity` scheme,
/// which every modern signer uses unconditionally.
@override final  BigInt? chainId;
@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegacyTransactionCopyWith<LegacyTransaction> get copyWith => _$LegacyTransactionCopyWithImpl<LegacyTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegacyTransaction&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,nonce,gasPrice,gasLimit,to,value,const DeepCollectionEquality().hash(data),chainId,yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope.legacy(nonce: $nonce, gasPrice: $gasPrice, gasLimit: $gasLimit, to: $to, value: $value, data: $data, chainId: $chainId, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $LegacyTransactionCopyWith<$Res> implements $TransactionEnvelopeCopyWith<$Res> {
  factory $LegacyTransactionCopyWith(LegacyTransaction value, $Res Function(LegacyTransaction) _then) = _$LegacyTransactionCopyWithImpl;
@override @useResult
$Res call({
 BigInt nonce, BigInt gasPrice, BigInt gasLimit, String? to, BigInt value, Uint8List data, BigInt? chainId, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$LegacyTransactionCopyWithImpl<$Res>
    implements $LegacyTransactionCopyWith<$Res> {
  _$LegacyTransactionCopyWithImpl(this._self, this._then);

  final LegacyTransaction _self;
  final $Res Function(LegacyTransaction) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nonce = null,Object? gasPrice = null,Object? gasLimit = null,Object? to = freezed,Object? value = null,Object? data = null,Object? chainId = freezed,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(LegacyTransaction(
nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,gasPrice: null == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt?,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

/// @nodoc


class Eip2930Transaction implements TransactionEnvelope {
  const Eip2930Transaction({required this.chainId, required this.nonce, required this.gasPrice, required this.gasLimit, this.to, required this.value, required this.data, required  List<AccessListEntry> accessList, this.yParity, this.r, this.s}): _accessList = accessList;
  

@override final  BigInt chainId;
@override final  BigInt nonce;
 final  BigInt gasPrice;
@override final  BigInt gasLimit;
@override final  String? to;
@override final  BigInt value;
@override final  Uint8List data;
 final  List<AccessListEntry> _accessList;
 List<AccessListEntry> get accessList {
  if (_accessList is EqualUnmodifiableListView) return _accessList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessList);
}

@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip2930TransactionCopyWith<Eip2930Transaction> get copyWith => _$Eip2930TransactionCopyWithImpl<Eip2930Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip2930Transaction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._accessList, _accessList)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,nonce,gasPrice,gasLimit,to,value,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_accessList),yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope.eip2930(chainId: $chainId, nonce: $nonce, gasPrice: $gasPrice, gasLimit: $gasLimit, to: $to, value: $value, data: $data, accessList: $accessList, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $Eip2930TransactionCopyWith<$Res> implements $TransactionEnvelopeCopyWith<$Res> {
  factory $Eip2930TransactionCopyWith(Eip2930Transaction value, $Res Function(Eip2930Transaction) _then) = _$Eip2930TransactionCopyWithImpl;
@override @useResult
$Res call({
 BigInt chainId, BigInt nonce, BigInt gasPrice, BigInt gasLimit, String? to, BigInt value, Uint8List data, List<AccessListEntry> accessList, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$Eip2930TransactionCopyWithImpl<$Res>
    implements $Eip2930TransactionCopyWith<$Res> {
  _$Eip2930TransactionCopyWithImpl(this._self, this._then);

  final Eip2930Transaction _self;
  final $Res Function(Eip2930Transaction) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? nonce = null,Object? gasPrice = null,Object? gasLimit = null,Object? to = freezed,Object? value = null,Object? data = null,Object? accessList = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(Eip2930Transaction(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,gasPrice: null == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,accessList: null == accessList ? _self._accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<AccessListEntry>,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

/// @nodoc


class Eip1559Transaction implements TransactionEnvelope {
  const Eip1559Transaction({required this.chainId, required this.nonce, required this.maxPriorityFeePerGas, required this.maxFeePerGas, required this.gasLimit, this.to, required this.value, required this.data, required  List<AccessListEntry> accessList, this.yParity, this.r, this.s}): _accessList = accessList;
  

@override final  BigInt chainId;
@override final  BigInt nonce;
 final  BigInt maxPriorityFeePerGas;
 final  BigInt maxFeePerGas;
@override final  BigInt gasLimit;
@override final  String? to;
@override final  BigInt value;
@override final  Uint8List data;
 final  List<AccessListEntry> _accessList;
 List<AccessListEntry> get accessList {
  if (_accessList is EqualUnmodifiableListView) return _accessList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessList);
}

@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip1559TransactionCopyWith<Eip1559Transaction> get copyWith => _$Eip1559TransactionCopyWithImpl<Eip1559Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip1559Transaction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._accessList, _accessList)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,nonce,maxPriorityFeePerGas,maxFeePerGas,gasLimit,to,value,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_accessList),yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope.eip1559(chainId: $chainId, nonce: $nonce, maxPriorityFeePerGas: $maxPriorityFeePerGas, maxFeePerGas: $maxFeePerGas, gasLimit: $gasLimit, to: $to, value: $value, data: $data, accessList: $accessList, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $Eip1559TransactionCopyWith<$Res> implements $TransactionEnvelopeCopyWith<$Res> {
  factory $Eip1559TransactionCopyWith(Eip1559Transaction value, $Res Function(Eip1559Transaction) _then) = _$Eip1559TransactionCopyWithImpl;
@override @useResult
$Res call({
 BigInt chainId, BigInt nonce, BigInt maxPriorityFeePerGas, BigInt maxFeePerGas, BigInt gasLimit, String? to, BigInt value, Uint8List data, List<AccessListEntry> accessList, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$Eip1559TransactionCopyWithImpl<$Res>
    implements $Eip1559TransactionCopyWith<$Res> {
  _$Eip1559TransactionCopyWithImpl(this._self, this._then);

  final Eip1559Transaction _self;
  final $Res Function(Eip1559Transaction) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? nonce = null,Object? maxPriorityFeePerGas = null,Object? maxFeePerGas = null,Object? gasLimit = null,Object? to = freezed,Object? value = null,Object? data = null,Object? accessList = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(Eip1559Transaction(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,accessList: null == accessList ? _self._accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<AccessListEntry>,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

/// @nodoc


class Eip7702Transaction implements TransactionEnvelope {
  const Eip7702Transaction({required this.chainId, required this.nonce, required this.maxPriorityFeePerGas, required this.maxFeePerGas, required this.gasLimit, this.to, required this.value, required this.data, required  List<AccessListEntry> accessList, required  List<Authorization> authorizationList, this.yParity, this.r, this.s}): _accessList = accessList,_authorizationList = authorizationList;
  

@override final  BigInt chainId;
@override final  BigInt nonce;
 final  BigInt maxPriorityFeePerGas;
 final  BigInt maxFeePerGas;
@override final  BigInt gasLimit;
@override final  String? to;
@override final  BigInt value;
@override final  Uint8List data;
 final  List<AccessListEntry> _accessList;
 List<AccessListEntry> get accessList {
  if (_accessList is EqualUnmodifiableListView) return _accessList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessList);
}

 final  List<Authorization> _authorizationList;
 List<Authorization> get authorizationList {
  if (_authorizationList is EqualUnmodifiableListView) return _authorizationList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authorizationList);
}

@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip7702TransactionCopyWith<Eip7702Transaction> get copyWith => _$Eip7702TransactionCopyWithImpl<Eip7702Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip7702Transaction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._accessList, _accessList)&&const DeepCollectionEquality().equals(other._authorizationList, _authorizationList)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,nonce,maxPriorityFeePerGas,maxFeePerGas,gasLimit,to,value,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_accessList),const DeepCollectionEquality().hash(_authorizationList),yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope.eip7702(chainId: $chainId, nonce: $nonce, maxPriorityFeePerGas: $maxPriorityFeePerGas, maxFeePerGas: $maxFeePerGas, gasLimit: $gasLimit, to: $to, value: $value, data: $data, accessList: $accessList, authorizationList: $authorizationList, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $Eip7702TransactionCopyWith<$Res> implements $TransactionEnvelopeCopyWith<$Res> {
  factory $Eip7702TransactionCopyWith(Eip7702Transaction value, $Res Function(Eip7702Transaction) _then) = _$Eip7702TransactionCopyWithImpl;
@override @useResult
$Res call({
 BigInt chainId, BigInt nonce, BigInt maxPriorityFeePerGas, BigInt maxFeePerGas, BigInt gasLimit, String? to, BigInt value, Uint8List data, List<AccessListEntry> accessList, List<Authorization> authorizationList, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$Eip7702TransactionCopyWithImpl<$Res>
    implements $Eip7702TransactionCopyWith<$Res> {
  _$Eip7702TransactionCopyWithImpl(this._self, this._then);

  final Eip7702Transaction _self;
  final $Res Function(Eip7702Transaction) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? nonce = null,Object? maxPriorityFeePerGas = null,Object? maxFeePerGas = null,Object? gasLimit = null,Object? to = freezed,Object? value = null,Object? data = null,Object? accessList = null,Object? authorizationList = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(Eip7702Transaction(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,accessList: null == accessList ? _self._accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<AccessListEntry>,authorizationList: null == authorizationList ? _self._authorizationList : authorizationList // ignore: cast_nullable_to_non_nullable
as List<Authorization>,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

/// @nodoc


class Eip4844Transaction implements TransactionEnvelope {
  const Eip4844Transaction({required this.chainId, required this.nonce, required this.maxPriorityFeePerGas, required this.maxFeePerGas, required this.gasLimit, required this.to, required this.value, required this.data, required  List<AccessListEntry> accessList, required this.maxFeePerBlobGas, required  List<Uint8List> blobVersionedHashes, this.yParity, this.r, this.s}): _accessList = accessList,_blobVersionedHashes = blobVersionedHashes;
  

@override final  BigInt chainId;
@override final  BigInt nonce;
 final  BigInt maxPriorityFeePerGas;
 final  BigInt maxFeePerGas;
@override final  BigInt gasLimit;
/// Required (never `null`) — blob transactions can't create contracts.
@override final  String to;
@override final  BigInt value;
@override final  Uint8List data;
 final  List<AccessListEntry> _accessList;
 List<AccessListEntry> get accessList {
  if (_accessList is EqualUnmodifiableListView) return _accessList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accessList);
}

 final  BigInt maxFeePerBlobGas;
 final  List<Uint8List> _blobVersionedHashes;
 List<Uint8List> get blobVersionedHashes {
  if (_blobVersionedHashes is EqualUnmodifiableListView) return _blobVersionedHashes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blobVersionedHashes);
}

@override final  int? yParity;
@override final  BigInt? r;
@override final  BigInt? s;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip4844TransactionCopyWith<Eip4844Transaction> get copyWith => _$Eip4844TransactionCopyWithImpl<Eip4844Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip4844Transaction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._accessList, _accessList)&&(identical(other.maxFeePerBlobGas, maxFeePerBlobGas) || other.maxFeePerBlobGas == maxFeePerBlobGas)&&const DeepCollectionEquality().equals(other._blobVersionedHashes, _blobVersionedHashes)&&(identical(other.yParity, yParity) || other.yParity == yParity)&&(identical(other.r, r) || other.r == r)&&(identical(other.s, s) || other.s == s));
}


@override
int get hashCode => Object.hash(runtimeType,chainId,nonce,maxPriorityFeePerGas,maxFeePerGas,gasLimit,to,value,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_accessList),maxFeePerBlobGas,const DeepCollectionEquality().hash(_blobVersionedHashes),yParity,r,s);

@override
String toString() {
  return 'TransactionEnvelope.eip4844(chainId: $chainId, nonce: $nonce, maxPriorityFeePerGas: $maxPriorityFeePerGas, maxFeePerGas: $maxFeePerGas, gasLimit: $gasLimit, to: $to, value: $value, data: $data, accessList: $accessList, maxFeePerBlobGas: $maxFeePerBlobGas, blobVersionedHashes: $blobVersionedHashes, yParity: $yParity, r: $r, s: $s)';
}


}

/// @nodoc
abstract mixin class $Eip4844TransactionCopyWith<$Res> implements $TransactionEnvelopeCopyWith<$Res> {
  factory $Eip4844TransactionCopyWith(Eip4844Transaction value, $Res Function(Eip4844Transaction) _then) = _$Eip4844TransactionCopyWithImpl;
@override @useResult
$Res call({
 BigInt chainId, BigInt nonce, BigInt maxPriorityFeePerGas, BigInt maxFeePerGas, BigInt gasLimit, String to, BigInt value, Uint8List data, List<AccessListEntry> accessList, BigInt maxFeePerBlobGas, List<Uint8List> blobVersionedHashes, int? yParity, BigInt? r, BigInt? s
});




}
/// @nodoc
class _$Eip4844TransactionCopyWithImpl<$Res>
    implements $Eip4844TransactionCopyWith<$Res> {
  _$Eip4844TransactionCopyWithImpl(this._self, this._then);

  final Eip4844Transaction _self;
  final $Res Function(Eip4844Transaction) _then;

/// Create a copy of TransactionEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? nonce = null,Object? maxPriorityFeePerGas = null,Object? maxFeePerGas = null,Object? gasLimit = null,Object? to = null,Object? value = null,Object? data = null,Object? accessList = null,Object? maxFeePerBlobGas = null,Object? blobVersionedHashes = null,Object? yParity = freezed,Object? r = freezed,Object? s = freezed,}) {
  return _then(Eip4844Transaction(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as BigInt,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,accessList: null == accessList ? _self._accessList : accessList // ignore: cast_nullable_to_non_nullable
as List<AccessListEntry>,maxFeePerBlobGas: null == maxFeePerBlobGas ? _self.maxFeePerBlobGas : maxFeePerBlobGas // ignore: cast_nullable_to_non_nullable
as BigInt,blobVersionedHashes: null == blobVersionedHashes ? _self._blobVersionedHashes : blobVersionedHashes // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,yParity: freezed == yParity ? _self.yParity : yParity // ignore: cast_nullable_to_non_nullable
as int?,r: freezed == r ? _self.r : r // ignore: cast_nullable_to_non_nullable
as BigInt?,s: freezed == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

// dart format on
