import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/ens.dart';
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

void main() {
  group('ensUniversalResolverAddress', () {
    test('throws when the client has no chain', () {
      final client = PublicClient(transport: _FakeTransport((m, p) => null));
      expect(() => client.ensUniversalResolverAddress, throwsStateError);
    });

    test('throws when the chain has no ensUniversalResolver registered', () {
      final client = PublicClient(
        transport: _FakeTransport((m, p) => null),
        chain: base,
      );
      expect(() => client.ensUniversalResolverAddress, throwsStateError);
    });

    test('returns the mainnet address', () {
      final client = PublicClient(
        transport: _FakeTransport((m, p) => null),
        chain: mainnet,
      );
      expect(
        client.ensUniversalResolverAddress,
        '0xeeeeeeee14d718c2b47d9923deab1335e144eeee',
      );
    });
  });

  group('universalResolverResolve', () {
    test('DNS-encodes the name and forwards the resolver call data', () async {
      String? sentData;
      final resolverCallData = Uint8List.fromList([1, 2, 3, 4]);
      final mockResolver = '0x00000000000000000000000000000000000000AB';

      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_call');
        final txObject = params[0] as Map;
        expect(
          txObject['to'],
          mainnet.contracts!['ensUniversalResolver']!.address,
        );
        sentData = txObject['data'] as String;
        return bytesToHex(
          encodeAbiParameters(_resolveWithGateways.outputs, [
            resolverCallData,
            mockResolver,
          ]),
        );
      });
      final client = PublicClient(transport: transport, chain: mainnet);

      final result = await client.universalResolverResolve(
        name: 'vitalik.eth',
        data: Uint8List.fromList([0xaa, 0xbb]),
      );

      expect(result.data, resolverCallData);
      expect(result.resolver, mockResolver);

      final expectedCallData = encodeFunctionData(_resolveWithGateways, [
        dnsEncodeName('vitalik.eth'),
        Uint8List.fromList([0xaa, 0xbb]),
        <String>[],
      ]);
      expect(sentData, bytesToHex(expectedCallData));
    });
  });

  group('universalResolverReverse', () {
    test(
      'defaults coinType to 60 and decodes the reverse-lookup result',
      () async {
        String? sentData;
        final transport = _FakeTransport((method, params) {
          final txObject = params[0] as Map;
          sentData = txObject['data'] as String;
          return bytesToHex(
            encodeAbiParameters(_reverseWithGateways.outputs, [
              'vitalik.eth',
              '0x00000000000000000000000000000000000000AB',
              '0x00000000000000000000000000000000000000cD',
            ]),
          );
        });
        final client = PublicClient(transport: transport, chain: mainnet);

        final result = await client.universalResolverReverse(
          address: '0x1234567890123456789012345678901234567890',
        );

        expect(result.name, 'vitalik.eth');
        expect(result.resolver, '0x00000000000000000000000000000000000000AB');
        expect(
          result.reverseResolver,
          '0x00000000000000000000000000000000000000cD',
        );

        final expectedCallData = encodeFunctionData(_reverseWithGateways, [
          hexToBytes('0x1234567890123456789012345678901234567890'),
          BigInt.from(60),
          <String>[],
        ]);
        expect(sentData, bytesToHex(expectedCallData));
      },
    );
  });
}
