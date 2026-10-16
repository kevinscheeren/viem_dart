// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NativeCurrency {

 String get name; String get symbol; int get decimals;
/// Create a copy of NativeCurrency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NativeCurrencyCopyWith<NativeCurrency> get copyWith => _$NativeCurrencyCopyWithImpl<NativeCurrency>(this as NativeCurrency, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NativeCurrency&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}


@override
int get hashCode => Object.hash(runtimeType,name,symbol,decimals);

@override
String toString() {
  return 'NativeCurrency(name: $name, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $NativeCurrencyCopyWith<$Res>  {
  factory $NativeCurrencyCopyWith(NativeCurrency value, $Res Function(NativeCurrency) _then) = _$NativeCurrencyCopyWithImpl;
@useResult
$Res call({
 String name, String symbol, int decimals
});




}
/// @nodoc
class _$NativeCurrencyCopyWithImpl<$Res>
    implements $NativeCurrencyCopyWith<$Res> {
  _$NativeCurrencyCopyWithImpl(this._self, this._then);

  final NativeCurrency _self;
  final $Res Function(NativeCurrency) _then;

/// Create a copy of NativeCurrency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(NativeCurrency(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NativeCurrency].
extension NativeCurrencyPatterns on NativeCurrency {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NativeCurrency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NativeCurrency() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NativeCurrency value)  $default,){
final _that = this;
switch (_that) {
case _NativeCurrency():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NativeCurrency value)?  $default,){
final _that = this;
switch (_that) {
case _NativeCurrency() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String symbol,  int decimals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NativeCurrency() when $default != null:
return $default(_that.name,_that.symbol,_that.decimals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String symbol,  int decimals)  $default,) {final _that = this;
switch (_that) {
case _NativeCurrency():
return $default(_that.name,_that.symbol,_that.decimals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String symbol,  int decimals)?  $default,) {final _that = this;
switch (_that) {
case _NativeCurrency() when $default != null:
return $default(_that.name,_that.symbol,_that.decimals);case _:
  return null;

}
}

}

/// @nodoc


class _NativeCurrency implements NativeCurrency {
  const _NativeCurrency({required this.name, required this.symbol, required this.decimals});
  

@override final  String name;
@override final  String symbol;
@override final  int decimals;

/// Create a copy of NativeCurrency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NativeCurrencyCopyWith<_NativeCurrency> get copyWith => __$NativeCurrencyCopyWithImpl<_NativeCurrency>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NativeCurrency&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}


@override
int get hashCode => Object.hash(runtimeType,name,symbol,decimals);

@override
String toString() {
  return 'NativeCurrency(name: $name, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class _$NativeCurrencyCopyWith<$Res> implements $NativeCurrencyCopyWith<$Res> {
  factory _$NativeCurrencyCopyWith(_NativeCurrency value, $Res Function(_NativeCurrency) _then) = __$NativeCurrencyCopyWithImpl;
@override @useResult
$Res call({
 String name, String symbol, int decimals
});




}
/// @nodoc
class __$NativeCurrencyCopyWithImpl<$Res>
    implements _$NativeCurrencyCopyWith<$Res> {
  __$NativeCurrencyCopyWithImpl(this._self, this._then);

  final _NativeCurrency _self;
  final $Res Function(_NativeCurrency) _then;

/// Create a copy of NativeCurrency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(_NativeCurrency(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BlockExplorer {

 String get name; String get url;
/// Create a copy of BlockExplorer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockExplorerCopyWith<BlockExplorer> get copyWith => _$BlockExplorerCopyWithImpl<BlockExplorer>(this as BlockExplorer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockExplorer&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'BlockExplorer(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $BlockExplorerCopyWith<$Res>  {
  factory $BlockExplorerCopyWith(BlockExplorer value, $Res Function(BlockExplorer) _then) = _$BlockExplorerCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$BlockExplorerCopyWithImpl<$Res>
    implements $BlockExplorerCopyWith<$Res> {
  _$BlockExplorerCopyWithImpl(this._self, this._then);

  final BlockExplorer _self;
  final $Res Function(BlockExplorer) _then;

/// Create a copy of BlockExplorer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(BlockExplorer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockExplorer].
extension BlockExplorerPatterns on BlockExplorer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockExplorer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockExplorer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockExplorer value)  $default,){
final _that = this;
switch (_that) {
case _BlockExplorer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockExplorer value)?  $default,){
final _that = this;
switch (_that) {
case _BlockExplorer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockExplorer() when $default != null:
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url)  $default,) {final _that = this;
switch (_that) {
case _BlockExplorer():
return $default(_that.name,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url)?  $default,) {final _that = this;
switch (_that) {
case _BlockExplorer() when $default != null:
return $default(_that.name,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _BlockExplorer implements BlockExplorer {
  const _BlockExplorer({required this.name, required this.url});
  

@override final  String name;
@override final  String url;

/// Create a copy of BlockExplorer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockExplorerCopyWith<_BlockExplorer> get copyWith => __$BlockExplorerCopyWithImpl<_BlockExplorer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockExplorer&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'BlockExplorer(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$BlockExplorerCopyWith<$Res> implements $BlockExplorerCopyWith<$Res> {
  factory _$BlockExplorerCopyWith(_BlockExplorer value, $Res Function(_BlockExplorer) _then) = __$BlockExplorerCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$BlockExplorerCopyWithImpl<$Res>
    implements _$BlockExplorerCopyWith<$Res> {
  __$BlockExplorerCopyWithImpl(this._self, this._then);

  final _BlockExplorer _self;
  final $Res Function(_BlockExplorer) _then;

/// Create a copy of BlockExplorer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_BlockExplorer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChainContract {

 String get address; int? get blockCreated;
/// Create a copy of ChainContract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChainContractCopyWith<ChainContract> get copyWith => _$ChainContractCopyWithImpl<ChainContract>(this as ChainContract, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChainContract&&(identical(other.address, address) || other.address == address)&&(identical(other.blockCreated, blockCreated) || other.blockCreated == blockCreated));
}


@override
int get hashCode => Object.hash(runtimeType,address,blockCreated);

@override
String toString() {
  return 'ChainContract(address: $address, blockCreated: $blockCreated)';
}


}

/// @nodoc
abstract mixin class $ChainContractCopyWith<$Res>  {
  factory $ChainContractCopyWith(ChainContract value, $Res Function(ChainContract) _then) = _$ChainContractCopyWithImpl;
@useResult
$Res call({
 String address, int? blockCreated
});




}
/// @nodoc
class _$ChainContractCopyWithImpl<$Res>
    implements $ChainContractCopyWith<$Res> {
  _$ChainContractCopyWithImpl(this._self, this._then);

  final ChainContract _self;
  final $Res Function(ChainContract) _then;

/// Create a copy of ChainContract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? blockCreated = freezed,}) {
  return _then(ChainContract(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,blockCreated: freezed == blockCreated ? _self.blockCreated : blockCreated // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChainContract].
extension ChainContractPatterns on ChainContract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChainContract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChainContract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChainContract value)  $default,){
final _that = this;
switch (_that) {
case _ChainContract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChainContract value)?  $default,){
final _that = this;
switch (_that) {
case _ChainContract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  int? blockCreated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChainContract() when $default != null:
return $default(_that.address,_that.blockCreated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  int? blockCreated)  $default,) {final _that = this;
switch (_that) {
case _ChainContract():
return $default(_that.address,_that.blockCreated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  int? blockCreated)?  $default,) {final _that = this;
switch (_that) {
case _ChainContract() when $default != null:
return $default(_that.address,_that.blockCreated);case _:
  return null;

}
}

}

/// @nodoc


class _ChainContract implements ChainContract {
  const _ChainContract({required this.address, this.blockCreated});
  

@override final  String address;
@override final  int? blockCreated;

/// Create a copy of ChainContract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChainContractCopyWith<_ChainContract> get copyWith => __$ChainContractCopyWithImpl<_ChainContract>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChainContract&&(identical(other.address, address) || other.address == address)&&(identical(other.blockCreated, blockCreated) || other.blockCreated == blockCreated));
}


@override
int get hashCode => Object.hash(runtimeType,address,blockCreated);

@override
String toString() {
  return 'ChainContract(address: $address, blockCreated: $blockCreated)';
}


}

/// @nodoc
abstract mixin class _$ChainContractCopyWith<$Res> implements $ChainContractCopyWith<$Res> {
  factory _$ChainContractCopyWith(_ChainContract value, $Res Function(_ChainContract) _then) = __$ChainContractCopyWithImpl;
@override @useResult
$Res call({
 String address, int? blockCreated
});




}
/// @nodoc
class __$ChainContractCopyWithImpl<$Res>
    implements _$ChainContractCopyWith<$Res> {
  __$ChainContractCopyWithImpl(this._self, this._then);

  final _ChainContract _self;
  final $Res Function(_ChainContract) _then;

/// Create a copy of ChainContract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? blockCreated = freezed,}) {
  return _then(_ChainContract(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,blockCreated: freezed == blockCreated ? _self.blockCreated : blockCreated // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$Chain {

 int get id; String get name; NativeCurrency get nativeCurrency; List<String> get rpcUrls; BlockExplorer? get blockExplorer; Map<String, ChainContract>? get contracts;
/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChainCopyWith<Chain> get copyWith => _$ChainCopyWithImpl<Chain>(this as Chain, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nativeCurrency, nativeCurrency) || other.nativeCurrency == nativeCurrency)&&const DeepCollectionEquality().equals(other.rpcUrls, rpcUrls)&&(identical(other.blockExplorer, blockExplorer) || other.blockExplorer == blockExplorer)&&const DeepCollectionEquality().equals(other.contracts, contracts));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,nativeCurrency,const DeepCollectionEquality().hash(rpcUrls),blockExplorer,const DeepCollectionEquality().hash(contracts));

@override
String toString() {
  return 'Chain(id: $id, name: $name, nativeCurrency: $nativeCurrency, rpcUrls: $rpcUrls, blockExplorer: $blockExplorer, contracts: $contracts)';
}


}

/// @nodoc
abstract mixin class $ChainCopyWith<$Res>  {
  factory $ChainCopyWith(Chain value, $Res Function(Chain) _then) = _$ChainCopyWithImpl;
@useResult
$Res call({
 int id, String name, NativeCurrency nativeCurrency, List<String> rpcUrls, BlockExplorer? blockExplorer, Map<String, ChainContract>? contracts
});


$NativeCurrencyCopyWith<$Res> get nativeCurrency;$BlockExplorerCopyWith<$Res>? get blockExplorer;

}
/// @nodoc
class _$ChainCopyWithImpl<$Res>
    implements $ChainCopyWith<$Res> {
  _$ChainCopyWithImpl(this._self, this._then);

  final Chain _self;
  final $Res Function(Chain) _then;

/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? nativeCurrency = null,Object? rpcUrls = null,Object? blockExplorer = freezed,Object? contracts = freezed,}) {
  return _then(Chain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nativeCurrency: null == nativeCurrency ? _self.nativeCurrency : nativeCurrency // ignore: cast_nullable_to_non_nullable
as NativeCurrency,rpcUrls: null == rpcUrls ? _self.rpcUrls : rpcUrls // ignore: cast_nullable_to_non_nullable
as List<String>,blockExplorer: freezed == blockExplorer ? _self.blockExplorer : blockExplorer // ignore: cast_nullable_to_non_nullable
as BlockExplorer?,contracts: freezed == contracts ? _self.contracts : contracts // ignore: cast_nullable_to_non_nullable
as Map<String, ChainContract>?,
  ));
}
/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NativeCurrencyCopyWith<$Res> get nativeCurrency {
  
  return $NativeCurrencyCopyWith<$Res>(_self.nativeCurrency, (value) {
    return _then(_self.copyWith(nativeCurrency: value));
  });
}/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlockExplorerCopyWith<$Res>? get blockExplorer {
    if (_self.blockExplorer == null) {
    return null;
  }

  return $BlockExplorerCopyWith<$Res>(_self.blockExplorer!, (value) {
    return _then(_self.copyWith(blockExplorer: value));
  });
}
}


/// Adds pattern-matching-related methods to [Chain].
extension ChainPatterns on Chain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chain value)  $default,){
final _that = this;
switch (_that) {
case _Chain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chain value)?  $default,){
final _that = this;
switch (_that) {
case _Chain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  NativeCurrency nativeCurrency,  List<String> rpcUrls,  BlockExplorer? blockExplorer,  Map<String, ChainContract>? contracts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chain() when $default != null:
return $default(_that.id,_that.name,_that.nativeCurrency,_that.rpcUrls,_that.blockExplorer,_that.contracts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  NativeCurrency nativeCurrency,  List<String> rpcUrls,  BlockExplorer? blockExplorer,  Map<String, ChainContract>? contracts)  $default,) {final _that = this;
switch (_that) {
case _Chain():
return $default(_that.id,_that.name,_that.nativeCurrency,_that.rpcUrls,_that.blockExplorer,_that.contracts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  NativeCurrency nativeCurrency,  List<String> rpcUrls,  BlockExplorer? blockExplorer,  Map<String, ChainContract>? contracts)?  $default,) {final _that = this;
switch (_that) {
case _Chain() when $default != null:
return $default(_that.id,_that.name,_that.nativeCurrency,_that.rpcUrls,_that.blockExplorer,_that.contracts);case _:
  return null;

}
}

}

/// @nodoc


class _Chain implements Chain {
  const _Chain({required this.id, required this.name, required this.nativeCurrency, required  List<String> rpcUrls, this.blockExplorer,  Map<String, ChainContract>? contracts}): _rpcUrls = rpcUrls,_contracts = contracts;
  

@override final  int id;
@override final  String name;
@override final  NativeCurrency nativeCurrency;
 final  List<String> _rpcUrls;
@override List<String> get rpcUrls {
  if (_rpcUrls is EqualUnmodifiableListView) return _rpcUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rpcUrls);
}

@override final  BlockExplorer? blockExplorer;
 final  Map<String, ChainContract>? _contracts;
@override Map<String, ChainContract>? get contracts {
  final value = _contracts;
  if (value == null) return null;
  if (_contracts is EqualUnmodifiableMapView) return _contracts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChainCopyWith<_Chain> get copyWith => __$ChainCopyWithImpl<_Chain>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nativeCurrency, nativeCurrency) || other.nativeCurrency == nativeCurrency)&&const DeepCollectionEquality().equals(other._rpcUrls, _rpcUrls)&&(identical(other.blockExplorer, blockExplorer) || other.blockExplorer == blockExplorer)&&const DeepCollectionEquality().equals(other._contracts, _contracts));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,nativeCurrency,const DeepCollectionEquality().hash(_rpcUrls),blockExplorer,const DeepCollectionEquality().hash(_contracts));

@override
String toString() {
  return 'Chain(id: $id, name: $name, nativeCurrency: $nativeCurrency, rpcUrls: $rpcUrls, blockExplorer: $blockExplorer, contracts: $contracts)';
}


}

/// @nodoc
abstract mixin class _$ChainCopyWith<$Res> implements $ChainCopyWith<$Res> {
  factory _$ChainCopyWith(_Chain value, $Res Function(_Chain) _then) = __$ChainCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, NativeCurrency nativeCurrency, List<String> rpcUrls, BlockExplorer? blockExplorer, Map<String, ChainContract>? contracts
});


@override $NativeCurrencyCopyWith<$Res> get nativeCurrency;@override $BlockExplorerCopyWith<$Res>? get blockExplorer;

}
/// @nodoc
class __$ChainCopyWithImpl<$Res>
    implements _$ChainCopyWith<$Res> {
  __$ChainCopyWithImpl(this._self, this._then);

  final _Chain _self;
  final $Res Function(_Chain) _then;

/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? nativeCurrency = null,Object? rpcUrls = null,Object? blockExplorer = freezed,Object? contracts = freezed,}) {
  return _then(_Chain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nativeCurrency: null == nativeCurrency ? _self.nativeCurrency : nativeCurrency // ignore: cast_nullable_to_non_nullable
as NativeCurrency,rpcUrls: null == rpcUrls ? _self._rpcUrls : rpcUrls // ignore: cast_nullable_to_non_nullable
as List<String>,blockExplorer: freezed == blockExplorer ? _self.blockExplorer : blockExplorer // ignore: cast_nullable_to_non_nullable
as BlockExplorer?,contracts: freezed == contracts ? _self._contracts : contracts // ignore: cast_nullable_to_non_nullable
as Map<String, ChainContract>?,
  ));
}

/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NativeCurrencyCopyWith<$Res> get nativeCurrency {
  
  return $NativeCurrencyCopyWith<$Res>(_self.nativeCurrency, (value) {
    return _then(_self.copyWith(nativeCurrency: value));
  });
}/// Create a copy of Chain
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlockExplorerCopyWith<$Res>? get blockExplorer {
    if (_self.blockExplorer == null) {
    return null;
  }

  return $BlockExplorerCopyWith<$Res>(_self.blockExplorer!, (value) {
    return _then(_self.copyWith(blockExplorer: value));
  });
}
}

// dart format on
