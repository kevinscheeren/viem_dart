import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/ens.dart' show dnsEncodeName;
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());
  final Object? Function(String method, List<Object?> params) handler;

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async =>
      JsonRpcResponse(
        id: request.id,
        result: handler(request.method, request.params),
      );
}

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

const _resolverAddress = '0x00000000000000000000000000000000000000ab';

PublicClient _clientResolving(Uint8List resolverReturnData) {
  final transport = _FakeTransport((method, params) {
    return bytesToHex(
      encodeAbiParameters(_resolveWithGateways.outputs, [
        resolverReturnData,
        _resolverAddress,
      ]),
    );
  });
  return PublicClient(transport: transport, chain: mainnet);
}

void main() {
  group('getEnsAddress', () {
    test('resolves and checksums an addr(bytes32) result', () async {
      const rawAddress = '0x1234567890123456789012345678901234567890';
      final client = _clientResolving(
        encodeFunctionResultData(_addr, [rawAddress]),
      );
      expect(
        await client.getEnsAddress(name: 'vitalik.eth'),
        getAddress(rawAddress),
      );
    });

    test('returns null for the zero address', () async {
      final client = _clientResolving(
        encodeFunctionResultData(_addr, [
          '0x0000000000000000000000000000000000000000',
        ]),
      );
      expect(await client.getEnsAddress(name: 'nobody.eth'), isNull);
    });

    test('returns null when the resolver returns empty data', () async {
      final client = _clientResolving(Uint8List(0));
      expect(await client.getEnsAddress(name: 'nobody.eth'), isNull);
    });

    test('with coinType, checksums a 20-byte multicoin result', () async {
      const rawAddress = '0x1234567890123456789012345678901234567890';
      final client = _clientResolving(
        encodeFunctionResultData(_addrWithCoinType, [hexToBytes(rawAddress)]),
      );
      expect(
        await client.getEnsAddress(
          name: 'vitalik.eth',
          coinType: BigInt.from(60),
        ),
        getAddress(rawAddress),
      );
    });

    test('with coinType, returns raw hex for a non-20-byte result', () async {
      final raw = Uint8List.fromList([1, 2, 3]);
      final client = _clientResolving(
        encodeFunctionResultData(_addrWithCoinType, [raw]),
      );
      expect(
        await client.getEnsAddress(name: 'btc-user.eth', coinType: BigInt.zero),
        bytesToHex(raw),
      );
    });
  });

  group('getEnsName', () {
    test('returns the resolved primary name', () async {
      final transport = _FakeTransport((method, params) {
        return bytesToHex(
          encodeAbiParameters(_reverseWithGateways.outputs, [
            'vitalik.eth',
            _resolverAddress,
            _resolverAddress,
          ]),
        );
      });
      final client = PublicClient(transport: transport, chain: mainnet);
      expect(
        await client.getEnsName(
          address: '0x1234567890123456789012345678901234567890',
        ),
        'vitalik.eth',
      );
    });

    test('returns null when no primary name is set', () async {
      final transport = _FakeTransport((method, params) {
        return bytesToHex(
          encodeAbiParameters(_reverseWithGateways.outputs, [
            '',
            _resolverAddress,
            _resolverAddress,
          ]),
        );
      });
      final client = PublicClient(transport: transport, chain: mainnet);
      expect(
        await client.getEnsName(
          address: '0x1234567890123456789012345678901234567890',
        ),
        isNull,
      );
    });
  });

  group('getEnsText', () {
    test('resolves a text record', () async {
      final client = _clientResolving(
        encodeFunctionResultData(_text, ['https://vitalik.ca']),
      );
      expect(
        await client.getEnsText(name: 'vitalik.eth', key: 'url'),
        'https://vitalik.ca',
      );
    });

    test('returns null for an unset (empty string) record', () async {
      final client = _clientResolving(encodeFunctionResultData(_text, ['']));
      expect(await client.getEnsText(name: 'vitalik.eth', key: 'url'), isNull);
    });

    test('returns null when the resolver returns empty data', () async {
      final client = _clientResolving(Uint8List(0));
      expect(await client.getEnsText(name: 'nobody.eth', key: 'url'), isNull);
    });
  });

  group('getEnsAvatar', () {
    test(
      'resolves an ipfs:// avatar record through resolveAvatarUri',
      () async {
        final client = _clientResolving(
          encodeFunctionResultData(_text, [
            'ipfs://QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
          ]),
        );
        expect(
          await client.getEnsAvatar(name: 'vitalik.eth'),
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
        );
      },
    );

    test('returns null when no avatar is set', () async {
      final client = _clientResolving(encodeFunctionResultData(_text, ['']));
      expect(await client.getEnsAvatar(name: 'nobody.eth'), isNull);
    });

    test(
      'throws UnsupportedError for an NFT (eip155:) avatar record',
      () async {
        final client = _clientResolving(
          encodeFunctionResultData(_text, [
            'eip155:1/erc721:0x1234567890123456789012345678901234567890/1',
          ]),
        );
        expect(
          () => client.getEnsAvatar(name: 'nft-user.eth'),
          throwsUnsupportedError,
        );
      },
    );
  });

  group('getEnsResolver', () {
    test(
      'calls findResolver and returns the checksummed resolver address',
      () async {
        const rawResolver = '0x1234567890123456789012345678901234567890';
        String? sentData;
        final transport = _FakeTransport((method, params) {
          expect(method, 'eth_call');
          final txObject = params[0] as Map;
          expect(
            txObject['to'],
            mainnet.contracts!['ensUniversalResolver']!.address,
          );
          sentData = txObject['data'] as String;
          return bytesToHex(
            encodeAbiParameters(_findResolver.outputs, [
              rawResolver,
              Uint8List(32),
              BigInt.zero,
            ]),
          );
        });
        final client = PublicClient(transport: transport, chain: mainnet);

        final resolver = await client.getEnsResolver(name: 'vitalik.eth');

        expect(resolver, getAddress(rawResolver));
        final expectedCallData = encodeFunctionData(_findResolver, [
          dnsEncodeName('vitalik.eth'),
        ]);
        expect(sentData, bytesToHex(expectedCallData));
      },
    );
  });
}

/// Encodes a target resolver function's return value(s), for use as the
/// Universal Resolver's inner `bytes` result in these tests.
Uint8List encodeFunctionResultData(AbiFunction fn, List<Object?> values) =>
    encodeAbiParameters(fn.outputs, values);
