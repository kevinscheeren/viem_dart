import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain.freezed.dart';

/// A chain's native currency (e.g. ETH, MATIC).
@freezed
abstract class NativeCurrency with _$NativeCurrency {
  /// Creates a [NativeCurrency] with the given [name], [symbol], and
  /// [decimals].
  const factory NativeCurrency({
    required String name,
    required String symbol,
    required int decimals,
  }) = _NativeCurrency;
}

/// A block explorer for a chain (e.g. Etherscan).
@freezed
abstract class BlockExplorer with _$BlockExplorer {
  /// Creates a [BlockExplorer] with the given [name] and [url].
  const factory BlockExplorer({required String name, required String url}) =
      _BlockExplorer;
}

/// A well-known contract deployed on a chain (e.g. Multicall3), keyed by
/// name in `Chain.contracts`.
@freezed
abstract class ChainContract with _$ChainContract {
  /// Creates a [ChainContract] at the given [address].
  const factory ChainContract({required String address, int? blockCreated}) =
      _ChainContract;
}

/// An EVM chain definition: id, display name, native currency, default RPC
/// URLs, block explorer, and any well-known contract addresses.
@freezed
abstract class Chain with _$Chain {
  /// Creates a [Chain] definition.
  const factory Chain({
    required int id,
    required String name,
    required NativeCurrency nativeCurrency,
    required List<String> rpcUrls,
    BlockExplorer? blockExplorer,
    Map<String, ChainContract>? contracts,
  }) = _Chain;
}
