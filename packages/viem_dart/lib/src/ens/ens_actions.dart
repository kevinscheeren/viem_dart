import 'dart:typed_data';

import '../abi/abi_item.dart';
import '../abi/function_data.dart';
import '../abi/human_readable/parse_abi.dart';
import '../actions/public/state_actions.dart'; // for PublicClient.call()
import '../client/client.dart';
import '../utils/address.dart';
import '../utils/hex.dart';
import 'avatar_uri.dart';
import 'dns_encode.dart';
import 'namehash.dart';
import 'universal_resolver.dart';

final AbiFunction _addr =
    parseAbiItem('function addr(bytes32 node) returns (address)')
        as AbiFunction;

final AbiFunction _addrWithCoinType =
    parseAbiItem(
          'function addr(bytes32 node, uint256 coinType) returns (bytes)',
        )
        as AbiFunction;

final AbiFunction _text =
    parseAbiItem('function text(bytes32 node, string key) returns (string)')
        as AbiFunction;

final AbiFunction _findResolver =
    parseAbiItem(
          'function findResolver(bytes name) returns (address, bytes32, uint256)',
        )
        as AbiFunction;

/// Core ENS forward/reverse resolution actions, built on
/// [UniversalResolverActions].
extension EnsActions on PublicClient {
  /// Resolves [name]'s address record. Without [coinType], calls the
  /// resolver's `addr(bytes32)` (the ETH mainnet address, per ENSIP-1) and
  /// returns an EIP-55-checksummed address. With [coinType] (a SLIP-44
  /// coin type, per ENSIP-9/11), calls the multicoin `addr(bytes32,
  /// uint256)` instead — returned as a checksummed address when the
  /// result is exactly 20 bytes (i.e. another EVM chain), otherwise as
  /// raw hex (non-EVM coin address formats aren't decoded further).
  ///
  /// Returns `null` if [name] has no address record set (or no resolver
  /// at all) — distinguishing "not set" from a genuine RPC/network error,
  /// which still throws.
  Future<String?> getEnsAddress({
    required String name,
    BigInt? coinType,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final node = hexToBytes(namehash(name));
    final abi = coinType == null ? _addr : _addrWithCoinType;
    final callData = encodeFunctionData(
      abi,
      coinType == null ? [node] : [node, coinType],
    );

    final resolved = await universalResolverResolve(
      name: name,
      data: callData,
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    if (resolved.data.isEmpty) return null;

    final decoded = decodeFunctionResult(abi, resolved.data).single;
    if (coinType == null) {
      final address = decoded as String;
      return hexToBigInt(address) == BigInt.zero ? null : address;
    }

    final raw = decoded as Uint8List;
    if (raw.isEmpty) return null;
    return raw.length == 20 ? getAddress(bytesToHex(raw)) : bytesToHex(raw);
  }

  /// Resolves [address]'s primary ENS name (reverse resolution). Returns
  /// `null` if no primary name is set.
  Future<String?> getEnsName({
    required String address,
    BigInt? coinType,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final reversed = await universalResolverReverse(
      address: address,
      coinType: coinType,
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    return reversed.name.isEmpty ? null : reversed.name;
  }

  /// Resolves [name]'s `text(bytes32,string)` record for [key] (e.g.
  /// `'com.twitter'`, `'url'`, `'avatar'` — see ENSIP-5 for the common
  /// key registry). Returns `null` if unset (or no resolver at all).
  Future<String?> getEnsText({
    required String name,
    required String key,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final node = hexToBytes(namehash(name));
    final callData = encodeFunctionData(_text, [node, key]);

    final resolved = await universalResolverResolve(
      name: name,
      data: callData,
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    if (resolved.data.isEmpty) return null;

    final decoded = decodeFunctionResult(_text, resolved.data).single as String;
    return decoded.isEmpty ? null : decoded;
  }

  /// Resolves [name]'s `avatar` text record to a directly usable URI (an
  /// IPFS/Arweave record becomes a gateway URL, `http(s)://` passes
  /// through, inline content becomes a `data:` URI) — see
  /// [resolveAvatarUri]. Returns `null` if no avatar is set.
  ///
  /// Throws [UnsupportedError] for an NFT avatar record (`eip155:...`),
  /// which needs an additional onchain call plus fetching the token's
  /// metadata — not yet supported (call [getEnsText] with key `'avatar'`
  /// directly and handle that case yourself if you need it).
  Future<String?> getEnsAvatar({
    required String name,
    String ipfsGateway = 'https://ipfs.io',
    String arweaveGateway = 'https://arweave.net',
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final record = await getEnsText(
      name: name,
      key: 'avatar',
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    if (record == null) return null;
    if (record.startsWith('eip155:')) {
      throw UnsupportedError(
        'NFT avatar records (eip155:...) require an additional onchain '
        'tokenURI/uri call plus fetching and parsing the token\'s metadata '
        '— not yet supported. Got: $record',
      );
    }
    return resolveAvatarUri(
      record,
      ipfsGateway: ipfsGateway,
      arweaveGateway: arweaveGateway,
    ).uri;
  }

  /// The resolver contract address registered for [name], via the
  /// Universal Resolver's `findResolver(bytes)` — a dedicated lookup that
  /// doesn't make any resolver-specific record call. Throws (an
  /// [RpcError]) if [name] has no resolver, rather than returning `null`
  /// — a caller specifically wants a resolver address here, not a record
  /// value, so there's no ambiguous "not set" case to distinguish.
  Future<String> getEnsResolver({
    required String name,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    final callData = encodeFunctionData(_findResolver, [dnsEncodeName(name)]);
    final result = await call(
      to: ensUniversalResolverAddress,
      data: bytesToHex(callData),
      blockNumber: blockNumber,
      blockTag: blockTag,
    );
    final decoded = decodeFunctionResult(_findResolver, hexToBytes(result));
    return decoded[0] as String;
  }
}
