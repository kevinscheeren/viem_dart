import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

/// Answers each `eth_call` with [onCall] (a result, or an error payload),
/// and records every request.
class _FakeTransport extends Transport {
  _FakeTransport(this.onCall) : super(const TransportConfig());
  final JsonRpcResponse Function(JsonRpcRequest request) onCall;
  final List<JsonRpcRequest> requests = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    requests.add(request);
    return onCall(request);
  }
}

JsonRpcResponse _result(JsonRpcRequest r, String result) =>
    JsonRpcResponse(id: r.id, result: result);

JsonRpcResponse _error(JsonRpcRequest r, int code, String message) =>
    JsonRpcResponse(
      id: r.id,
      error: JsonRpcErrorPayload(code: code, message: message),
    );

const _magicWord =
    '0x1626ba7e00000000000000000000000000000000000000000000000000000000';

final _privateKey = hexToBytes(
  '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
);
final _signer = privateKeyToAccount(_privateKey);
final _hash = hexToBytes(keccak256String('verifyHash'));
const _contract = '0x5555555555555555555555555555555555555555';
const _factory = '0x6666666666666666666666666666666666666666';

const _wrapperParams = [
  AbiParameter(name: 'factory', type: 'address'),
  AbiParameter(name: 'factoryCalldata', type: 'bytes'),
  AbiParameter(name: 'signature', type: 'bytes'),
];

Uint8List _wrap(Uint8List factoryCalldata, Uint8List signature) =>
    Uint8List.fromList([
      ...encodeAbiParameters(_wrapperParams, [
        _factory,
        factoryCalldata,
        signature,
      ]),
      ...hexToBytes(erc6492MagicSuffix),
    ]);

void main() {
  group('verifyHash', () {
    late _FakeTransport transport;
    late PublicClient client;

    void answerWith(JsonRpcResponse Function(JsonRpcRequest) onCall) {
      transport = _FakeTransport(onCall);
      client = PublicClient(transport: transport);
    }

    setUp(
      () =>
          answerWith((r) => throw StateError('unexpected request ${r.method}')),
    );

    group('EOA signatures', () {
      test(
        'verify locally, without an RPC call, in every accepted form',
        () async {
          final signature = sign(_hash, _privateKey);
          for (final form in <Object>[
            signature,
            signatureToHex(signature),
            hexToBytes(signatureToHex(signature)),
          ]) {
            expect(
              await client.verifyHash(
                address: _signer.address,
                hash: _hash,
                signature: form,
              ),
              isTrue,
              reason: '${form.runtimeType}',
            );
          }
          expect(
            await client.verifyHash(
              address: _signer.address.toLowerCase(),
              hash: bytesToHex(_hash),
              signature: signature,
            ),
            isTrue,
            reason: 'hex hash, lower-case address',
          );
          expect(transport.requests, isEmpty);
        },
      );

      test('accept a 0/1 recovery id as well as 27/28', () async {
        final signature = sign(_hash, _privateKey);
        final bytes = hexToBytes(signatureToHex(signature));
        bytes[64] = signature.yParity;
        expect(
          await client.verifyHash(
            address: _signer.address,
            hash: _hash,
            signature: bytes,
          ),
          isTrue,
        );
      });
    });

    group('contract signatures', () {
      Future<bool> verify({
        Object signature = '0x1234',
        BigInt? blockNumber,
        String blockTag = 'latest',
      }) => client.verifyHash(
        address: _contract,
        hash: _hash,
        signature: signature,
        blockNumber: blockNumber,
        blockTag: blockTag,
      );

      test('send isValidSignature(bytes32,bytes) to the contract', () async {
        answerWith((r) => _result(r, _magicWord));

        expect(await verify(), isTrue);

        expect(transport.requests, hasLength(1));
        final request = transport.requests.single;
        expect(request.method, 'eth_call');
        final tx = request.params[0]! as Map<String, Object?>;
        expect(tx['to'], _contract);
        // selector, the hash, the offset of `bytes`, its length, its data.
        expect(
          tx['data'],
          '0x1626ba7e${bytesToHex(_hash).substring(2)}'
          '${'40'.padLeft(64, '0')}${'2'.padLeft(64, '0')}'
          '1234${'0' * 60}',
        );
        expect(request.params[1], 'latest');
      });

      test('send a block number, and a block tag', () async {
        answerWith((r) => _result(r, _magicWord));

        await verify(blockNumber: BigInt.from(255));
        await verify(blockTag: 'safe');

        expect(transport.requests.map((r) => r.params[1]), ['0xff', 'safe']);
      });

      test(
        'a signature that fails ECDSA recovery goes to the contract',
        () async {
          answerWith((r) => _result(r, _magicWord));
          // 65 bytes, but `v` is invalid.
          final badV = Uint8List(65)..[64] = 99;

          expect(await verify(signature: badV), isTrue);
          expect(transport.requests, hasLength(1));
        },
      );

      test(
        'are false for a wrong magic value, empty or short return data',
        () async {
          for (final returned in [
            '0xdeadbeef${'0' * 56}',
            '0x',
            '0x1626ba7e',
          ]) {
            answerWith((r) => _result(r, returned));
            expect(await verify(), isFalse, reason: returned);
          }
        },
      );

      test('are false when the call reverts or halts', () async {
        for (final (code, message) in [
          (3, 'execution reverted'),
          (-32000, 'execution reverted: no 1271'),
          (-32015, 'VM execution error.'),
          (-32000, 'EVM error InvalidFEOpcode'),
          (-32000, 'out of gas'),
        ]) {
          answerWith((r) => _error(r, code, message));
          expect(await verify(), isFalse, reason: '$code $message');
        }
      });

      test('rethrow an error that is not a failed call', () async {
        for (final (code, message) in [
          (-32005, 'rate limit exceeded'),
          (-32601, 'the method eth_call does not exist'),
          (-32603, 'internal error'),
        ]) {
          answerWith((r) => _error(r, code, message));
          await expectLater(
            verify(),
            throwsA(isA<RpcError>().having((e) => e.code, 'code', code)),
            reason: '$code $message',
          );
        }
      });
    });

    group('ERC-6492 signatures', () {
      final factoryCalldata = Uint8List.fromList([0xde, 0xad]);
      final inner = Uint8List.fromList(List.generate(65, (i) => i));
      final wrapped = _wrap(factoryCalldata, inner);
      const one =
          '0x0000000000000000000000000000000000000000000000000000000000000001';
      const zero =
          '0x0000000000000000000000000000000000000000000000000000000000000000';

      Future<bool> verify({Object? signature, BigInt? blockNumber}) =>
          client.verifyHash(
            address: _contract,
            hash: _hash,
            signature: signature ?? wrapped,
            blockNumber: blockNumber,
          );

      test(
        'are verified by one deployless eth_call to the validator',
        () async {
          answerWith((r) => _result(r, one));

          expect(await verify(blockNumber: BigInt.from(16)), isTrue);

          expect(transport.requests, hasLength(1));
          final request = transport.requests.single;
          expect(request.method, 'eth_call');
          expect(request.params[1], '0x10');
          final tx = request.params[0]! as Map<String, Object?>;
          expect(tx.containsKey('to'), isFalse, reason: 'a deployless call');
          // The creation code, then the constructor arguments: the signer, the
          // hash, the factory, and the factory call and inner signature.
          final data = tx['data']! as String;
          final args = bytesToHex(
            encodeAbiParameters(
              [
                const AbiParameter(name: 'signer', type: 'address'),
                const AbiParameter(name: 'hash', type: 'bytes32'),
                ..._wrapperParams,
              ],
              [_contract, _hash, _factory, factoryCalldata, inner],
            ),
          ).substring(2);
          expect(data, startsWith('0x'));
          expect(data, endsWith(args));
          expect(data.length, greaterThan(args.length + 2));
        },
      );

      test('are false when the validator returns anything but 1', () async {
        for (final returned in [zero, '0x', '0x01']) {
          answerWith((r) => _result(r, returned));
          expect(await verify(), isFalse, reason: returned);
        }
      });

      test(
        'are false when the validator reverts, e.g. a failing factory',
        () async {
          answerWith((r) => _error(r, 3, 'execution reverted'));
          expect(await verify(), isFalse);
        },
      );

      test('rethrow an error that is not a failed call', () async {
        answerWith((r) => _error(r, -32005, 'rate limit exceeded'));
        await expectLater(verify(), throwsA(isA<RpcError>()));
      });

      test('with a malformed wrapper are false without an RPC call', () async {
        final suffix = hexToBytes(erc6492MagicSuffix);
        for (final bytes in [
          suffix,
          Uint8List.fromList([1, 2, 3, ...suffix]),
          // The offset of the factory call points far past the end.
          Uint8List.fromList([
            ...encodeAbiParameters(_wrapperParams, [
              _factory,
              factoryCalldata,
              inner,
            ]).sublist(0, 32),
            ...hexToBytes('0x${'ff' * 32}'),
            ...Uint8List(32),
            ...suffix,
          ]),
        ]) {
          expect(await verify(signature: bytes), isFalse);
        }
        expect(transport.requests, isEmpty);
      });
    });

    group('invalid arguments', () {
      test('throw an ArgumentError', () async {
        final good = signatureToHex(sign(_hash, _privateKey));
        final cases = <String, Future<bool> Function()>{
          'a hash of the wrong length': () => client.verifyHash(
            address: _signer.address,
            hash: Uint8List(31),
            signature: good,
          ),
          'a hash of the wrong type': () => client.verifyHash(
            address: _signer.address,
            hash: 42,
            signature: good,
          ),
          'a signature of the wrong type': () => client.verifyHash(
            address: _signer.address,
            hash: _hash,
            signature: 42,
          ),
          'an address that is not an address': () => client.verifyHash(
            address: 'vitalik.eth',
            hash: _hash,
            signature: good,
          ),
        };
        for (final entry in cases.entries) {
          await expectLater(
            entry.value(),
            throwsA(isA<ArgumentError>()),
            reason: entry.key,
          );
        }
        expect(transport.requests, isEmpty);
      });

      test('a malformed hex signature throws a FormatException', () async {
        await expectLater(
          client.verifyHash(
            address: _signer.address,
            hash: _hash,
            signature: '0xzz',
          ),
          throwsFormatException,
        );
      });
    });

    test('keeps no state between clients', () async {
      final signature = sign(_hash, _privateKey);
      final other = PublicClient(
        transport: _FakeTransport((r) => _result(r, '0x')),
      );
      expect(
        await client.verifyHash(
          address: _signer.address,
          hash: _hash,
          signature: signature,
        ),
        isTrue,
      );
      expect(
        await other.verifyHash(
          address: _contract,
          hash: _hash,
          signature: signature,
        ),
        isFalse,
      );
    });
  });
}
