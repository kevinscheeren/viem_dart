import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
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

const _tokenAddress = '0xdbF03B407c01E7cD3CBea99509d93f8DDDC8C6FB';

const _resultsType = AbiParameter(
  name: '',
  type: 'tuple[]',
  components: [
    AbiParameter(name: 'success', type: 'bool'),
    AbiParameter(name: 'returnData', type: 'bytes'),
  ],
);

void main() {
  final balanceOf =
      parseAbiItem('function balanceOf(address owner) view returns (uint256)')
          as AbiFunction;

  group('multicall', () {
    test(
      'calls Multicall3 aggregate3 and decodes per-call success/failure',
      () async {
        final ownerA = '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed';
        final ownerB = '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359';

        final transport = _FakeTransport((method, params) {
          expect(method, 'eth_call');
          final callObject = params[0] as Map;
          expect(callObject['to'], MulticallActions.multicall3Address);

          final successReturnData = encodeAbiParameters(balanceOf.outputs, [
            BigInt.from(1000),
          ]);
          final results = [
            [true, successReturnData],
            [false, Uint8List(0)],
          ];
          return bytesToHex(encodeAbiParameters([_resultsType], [results]));
        });
        final client = PublicClient(transport: transport);

        final results = await client.multicall(
          calls: [
            (
              address: _tokenAddress,
              abi: balanceOf,
              args: [ownerA],
              allowFailure: true,
            ),
            (
              address: _tokenAddress,
              abi: balanceOf,
              args: [ownerB],
              allowFailure: true,
            ),
          ],
        );

        expect(results, hasLength(2));
        expect(results[0].success, isTrue);
        expect(results[0].result, BigInt.from(1000));
        expect(results[1].success, isFalse);
        expect(results[1].result, isNull);
      },
    );

    test(
      'sends each call with its own encoded calldata and allowFailure flag',
      () async {
        final transport = _FakeTransport((method, params) {
          final callObject = params[0] as Map;
          final data = hexToBytes(callObject['data'] as String);
          final decodedArgs =
              decodeAbiParameters([_aggregate3Input], data.sublist(4)).single
                  as List<Object?>;
          final calls = decodedArgs.cast<List<Object?>>();
          expect(calls, hasLength(1));
          expect(calls[0][0], _tokenAddress); // target
          expect(calls[0][1], true); // allowFailure
          expect(
            (calls[0][2] as List).length,
            greaterThan(0),
          ); // callData bytes

          final results = [
            [
              true,
              encodeAbiParameters(balanceOf.outputs, [BigInt.zero]),
            ],
          ];
          return bytesToHex(encodeAbiParameters([_resultsType], [results]));
        });
        final client = PublicClient(transport: transport);

        await client.multicall(
          calls: [
            (
              address: _tokenAddress,
              abi: balanceOf,
              args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
              allowFailure: true,
            ),
          ],
        );
      },
    );
  });
}

const _aggregate3Input = AbiParameter(
  name: '',
  type: 'tuple[]',
  components: [
    AbiParameter(name: 'target', type: 'address'),
    AbiParameter(name: 'allowFailure', type: 'bool'),
    AbiParameter(name: 'callData', type: 'bytes'),
  ],
);
