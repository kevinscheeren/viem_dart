import 'dart:typed_data';

import '../abi/abi_item.dart';
import '../abi/function_data.dart';
import '../abi/human_readable/parse_abi.dart';
import '../client/client.dart';
import '../utils/hex.dart';
import '../actions/public/state_actions.dart'; // for PublicClient.call()
import 'dns_encode.dart';

final AbiFunction _resolveWithGateways =
    parseAbiItem(
          'function resolveWithGateways(bytes name, bytes data, string[] gateways) '
          'view returns (bytes, address)',
        )
        as AbiFunction;

final AbiFunction _reverseWithGateways =
    parseAbiItem(
          'function reverseWithGateways(bytes reverseName, uint256 coinType, string[] gateways) '
          'view returns (string resolvedName, address resolver, address reverseResolver)',
        )
        as AbiFunction;

/// Actions for calling ENS's Universal Resolver directly — the shared
/// plumbing `getEnsAddress`/`getEnsName`/`getEnsText`/`getEnsAvatar`/
/// `getEnsResolver` build on. Most callers should prefer those instead of
/// calling [universalResolverResolve]/[universalResolverReverse] directly.
///
/// **Known gap**: offchain (CCIP-Read, ENSIP-10 wildcard) resolution isn't
/// supported — [gateways] defaults to empty, so a name whose resolver
/// requires an offchain lookup will surface as a revert (an [RpcError]),
/// not resolve. Everyday onchain-resolvable names (the overwhelming
/// majority of registered `.eth` names) are unaffected.
extension UniversalResolverActions on PublicClient {
  /// The connected chain's `ensUniversalResolver` contract address —
  /// throws a [StateError] if the client has no [PublicClient.chain] set,
  /// or the chain has no Universal Resolver registered (ENS is a
  /// mainnet-anchored system; most chains don't have one).
  String get ensUniversalResolverAddress {
    final currentChain = chain;
    if (currentChain == null) {
      throw StateError('ENS actions require a Client created with a chain.');
    }
    final contract = currentChain.contracts?['ensUniversalResolver'];
    if (contract == null) {
      throw StateError(
        'Chain "${currentChain.name}" has no ensUniversalResolver contract '
        'registered — ENS resolution is only available on chains where '
        'it is (currently: mainnet, sepolia).',
      );
    }
    return contract.address;
  }

  /// Resolves [name] (DNS-encoded internally — see [dnsEncodeName]) via
  /// the Universal Resolver's `resolveWithGateways(name, data, gateways)`:
  /// [data] is the ABI-encoded call to make against [name]'s resolver
  /// (e.g. `addr(bytes32)`, `text(bytes32,string)`) — the Universal
  /// Resolver finds the right resolver contract and forwards the call.
  ///
  /// Returns the target resolver call's own raw ABI-encoded return bytes
  /// (decode with the same ABI you encoded [data] with) and the resolver
  /// contract's address.
  Future<({Uint8List data, String resolver})> universalResolverResolve({
    required String name,
    required Uint8List data,
    List<String> gateways = const [],
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final callData = encodeFunctionData(_resolveWithGateways, [
      dnsEncodeName(name),
      data,
      gateways,
    ]);
    final result = await call(
      to: ensUniversalResolverAddress,
      data: bytesToHex(callData),
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    final decoded = decodeFunctionResult(
      _resolveWithGateways,
      hexToBytes(result),
    );
    return (data: decoded[0] as Uint8List, resolver: decoded[1] as String);
  }

  /// Reverse-resolves [address] (its primary ENS name) via the Universal
  /// Resolver's `reverseWithGateways(address, coinType, gateways)`.
  /// [coinType] defaults to `60` (ETH mainnet, per SLIP-44/ENSIP-9/11) —
  /// pass a chain-specific value (`0x80000000 | chainId`, per ENSIP-11)
  /// for an L2's own reverse records, where supported.
  Future<({String name, String resolver, String reverseResolver})>
  universalResolverReverse({
    required String address,
    BigInt? coinType,
    List<String> gateways = const [],
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final callData = encodeFunctionData(_reverseWithGateways, [
      hexToBytes(address),
      coinType ?? BigInt.from(60),
      gateways,
    ]);
    final result = await call(
      to: ensUniversalResolverAddress,
      data: bytesToHex(callData),
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    final decoded = decodeFunctionResult(
      _reverseWithGateways,
      hexToBytes(result),
    );
    return (
      name: decoded[0] as String,
      resolver: decoded[1] as String,
      reverseResolver: decoded[2] as String,
    );
  }
}
