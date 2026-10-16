import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
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

void main() {
  final balanceOf =
      parseAbiItem('function balanceOf(address owner) view returns (uint256)')
          as AbiFunction;
  final transfer =
      parseAbiItem(
            'function transfer(address to, uint256 amount) returns (bool)',
          )
          as AbiFunction;
  final multiOutput =
      parseAbiItem(
            'function stats() view returns (uint256 total, uint256 count)',
          )
          as AbiFunction;
  final transferEvent =
      parseAbiItem(
            'event Transfer(address indexed from, address indexed to, uint256 value)',
          )
          as AbiEvent;

  group('readContract', () {
    test('encodes the call data and decodes a single output', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_call');
        final callObject = (params[0] as Map)['data'] as String;
        expect(
          callObject,
          startsWith('0x70a08231'),
        ); // balanceOf(address) selector
        return '0x000000000000000000000000000000000000000000000000000000000000002a';
      });
      final client = PublicClient(transport: transport);

      final result = await client.readContract(
        address: '0xcontract',
        abi: balanceOf,
        args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
      );
      expect(result, BigInt.from(42));
    });

    test('returns a List for multi-output functions', () async {
      final transport = _FakeTransport((method, params) {
        return bytesToHex(
          encodeAbiParameters(multiOutput.outputs, [
            BigInt.from(100),
            BigInt.from(2),
          ]),
        );
      });
      final client = PublicClient(transport: transport);

      final result = await client.readContract(
        address: '0xcontract',
        abi: multiOutput,
      );
      expect(result, [BigInt.from(100), BigInt.from(2)]);
    });
  });

  group('readContract with multicallBatch', () {
    const resultsType = AbiParameter(
      name: '',
      type: 'tuple[]',
      components: [
        AbiParameter(name: 'success', type: 'bool'),
        AbiParameter(name: 'returnData', type: 'bytes'),
      ],
    );

    test(
      'combines concurrent calls sharing a block context into one multicall',
      () async {
        var ethCallCount = 0;
        final transport = _FakeTransport((method, params) {
          expect(method, 'eth_call');
          ethCallCount++;
          final callObject = params[0] as Map;
          expect(callObject['to'], MulticallActions.multicall3Address);

          final results = [
            [
              true,
              encodeAbiParameters(balanceOf.outputs, [BigInt.from(1)]),
            ],
            [
              true,
              encodeAbiParameters(balanceOf.outputs, [BigInt.from(2)]),
            ],
          ];
          return bytesToHex(encodeAbiParameters([resultsType], [results]));
        });
        final client = PublicClient(
          transport: transport,
          multicallBatch: const MulticallBatchConfig(),
        );

        final first = client.readContract(
          address: '0xab798a4d408a373b7c3ddc0ac4bdd9daac241243',
          abi: balanceOf,
          args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
        );
        final second = client.readContract(
          address: '0xf666b8d00471fdb83eb7407577b8e37ff67e366b',
          abi: balanceOf,
          args: ['0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359'],
        );

        expect(await first, BigInt.one);
        expect(await second, BigInt.two);
        expect(ethCallCount, 1);
      },
    );

    test('calls with different block contexts are not combined', () async {
      var ethCallCount = 0;
      final transport = _FakeTransport((method, params) {
        ethCallCount++;
        final callObject = params[0] as Map;
        // Neither call was worth batching alone, so both go direct to
        // the contract address, not through Multicall3.
        expect(callObject['to'], isNot(MulticallActions.multicall3Address));
        return bytesToHex(
          encodeAbiParameters(balanceOf.outputs, [BigInt.from(1)]),
        );
      });
      final client = PublicClient(
        transport: transport,
        multicallBatch: const MulticallBatchConfig(),
      );

      final atLatest = client.readContract(
        address: '0xcontract',
        abi: balanceOf,
        args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
      );
      final atBlockOne = client.readContract(
        address: '0xcontract',
        abi: balanceOf,
        args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
        blockNumber: BigInt.one,
      );

      await Future.wait([atLatest, atBlockOne]);
      expect(ethCallCount, 2);
    });

    test('a reverted call in a batch throws ContractFunctionRevertedError '
        'without affecting the others', () async {
      final transport = _FakeTransport((method, params) {
        final results = [
          [
            true,
            encodeAbiParameters(balanceOf.outputs, [BigInt.from(1)]),
          ],
          [false, Uint8List(0)],
        ];
        return bytesToHex(encodeAbiParameters([resultsType], [results]));
      });
      final client = PublicClient(
        transport: transport,
        multicallBatch: const MulticallBatchConfig(),
      );

      final ok = client.readContract(
        address: '0xab798a4d408a373b7c3ddc0ac4bdd9daac241243',
        abi: balanceOf,
        args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
      );
      final reverted = client.readContract(
        address: '0xf666b8d00471fdb83eb7407577b8e37ff67e366b',
        abi: balanceOf,
        args: ['0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359'],
      );

      expect(await ok, BigInt.one);
      await expectLater(
        reverted,
        throwsA(isA<ContractFunctionRevertedError>()),
      );
    });

    group('a reverted call in a batch carries its revert data', () {
      Future<Object> revertOf(Uint8List returnData) async {
        final transport = _FakeTransport((method, params) {
          final results = [
            [false, returnData],
            [false, returnData],
          ];
          return bytesToHex(encodeAbiParameters([resultsType], [results]));
        });
        final client = PublicClient(
          transport: transport,
          multicallBatch: const MulticallBatchConfig(),
        );
        final calls = [
          for (final address in [
            '0xab798a4d408a373b7c3ddc0ac4bdd9daac241243',
            '0xf666b8d00471fdb83eb7407577b8e37ff67e366b',
          ])
            client
                .readContract(
                  address: address,
                  abi: balanceOf,
                  args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
                )
                .then<Object>((v) => v!, onError: (Object e) => e),
        ];
        return (await Future.wait(calls)).first;
      }

      test(
        'an Error(string) revert keeps its data and decodes the reason',
        () async {
          final data = Uint8List.fromList([
            0x08, 0xc3, 0x79, 0xa0, //
            ...encodeAbiParameters(
              const [AbiParameter(name: '', type: 'string')],
              ['boom'],
            ),
          ]);

          final error = await revertOf(data) as ContractFunctionRevertedError;

          expect(error.data, data);
          expect(error.reason, 'boom');
          expect(error.functionName, 'balanceOf');
        },
      );

      test(
        'a custom-error revert keeps its data for decodeErrorResult',
        () async {
          final nope = parseAbiItem('error Nope(uint256 code)') as AbiError;
          final data = encodeErrorResult(nope, [BigInt.from(42)]);

          final error = await revertOf(data) as ContractFunctionRevertedError;

          expect(error.reason, isNull);
          expect(decodeErrorResult(nope, error.data!), [BigInt.from(42)]);
        },
      );

      test('a bare revert has empty data and no reason', () async {
        final error =
            await revertOf(Uint8List(0)) as ContractFunctionRevertedError;

        expect(error.data, isEmpty);
        expect(error.reason, isNull);
      });

      test(
        'malformed Error(string) data keeps the data and drops the reason',
        () async {
          final data = Uint8List.fromList([0x08, 0xc3, 0x79, 0xa0, 0x01]);

          final error = await revertOf(data) as ContractFunctionRevertedError;

          expect(error.data, data);
          expect(error.reason, isNull);
        },
      );
    });

    test('flushes early once batchSize is reached, without waiting', () async {
      var ethCallCount = 0;
      final transport = _FakeTransport((method, params) {
        ethCallCount++;
        final results = [
          [
            true,
            encodeAbiParameters(balanceOf.outputs, [BigInt.one]),
          ],
          [
            true,
            encodeAbiParameters(balanceOf.outputs, [BigInt.two]),
          ],
        ];
        return bytesToHex(encodeAbiParameters([resultsType], [results]));
      });
      final client = PublicClient(
        transport: transport,
        multicallBatch: const MulticallBatchConfig(
          batchSize: 2,
          wait: Duration(seconds: 30),
        ),
      );

      final results = await Future.wait([
        client.readContract(
          address: '0xab798a4d408a373b7c3ddc0ac4bdd9daac241243',
          abi: balanceOf,
          args: ['0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed'],
        ),
        client.readContract(
          address: '0xf666b8d00471fdb83eb7407577b8e37ff67e366b',
          abi: balanceOf,
          args: ['0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359'],
        ),
      ]);

      expect(results, [BigInt.one, BigInt.two]);
      expect(ethCallCount, 1);
    });
  });

  group('simulateContract', () {
    test('sends from/value and decodes the result', () async {
      final transport = _FakeTransport((method, params) {
        final callObject = params[0] as Map;
        expect(callObject['from'], '0xsender');
        expect(
          callObject['data'],
          startsWith('0xa9059cbb'),
        ); // transfer selector
        return '0x0000000000000000000000000000000000000000000000000000000000000001';
      });
      final client = PublicClient(transport: transport);

      final result = await client.simulateContract(
        address: '0xcontract',
        abi: transfer,
        args: ['0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359', BigInt.from(1000)],
        from: '0xsender',
      );
      expect(result, true);
    });
  });

  group('writeContract', () {
    Map<String, Object?> blockWithBaseFee() => {
      'parentHash': '0x0',
      'sha3Uncles': '0x0',
      'transactionsRoot': '0x0',
      'stateRoot': '0x0',
      'receiptsRoot': '0x0',
      'miner': '0x0',
      'difficulty': '0x0',
      'extraData': '0x',
      'size': '0x0',
      'gasLimit': '0x1c9c380',
      'gasUsed': '0x0',
      'timestamp': '0x0',
      'transactions': <String>[],
      'uncles': <String>[],
      'baseFeePerGas': '0x3b9aca00',
    };

    test(
      'encodes the call, sends it as a transaction, returns the hash',
      () async {
        final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
        const contractAddress = '0x70997970c51812dc3a010c7d01b50e0d17dc79c8';
        String? sentData;

        final transport = _FakeTransport((method, params) {
          switch (method) {
            case 'eth_getBlockByNumber':
              return blockWithBaseFee();
            case 'eth_maxPriorityFeePerGas':
              return '0x59682f00';
            case 'eth_getTransactionCount':
              return '0x0';
            case 'eth_estimateGas':
              sentData = (params[0] as Map)['data'] as String;
              return '0x5208';
            case 'eth_chainId':
              return '0x1';
            case 'eth_sendRawTransaction':
              return '0xtxhash';
            default:
              throw StateError('unexpected method $method');
          }
        });
        final client = WalletClient(transport: transport, account: account);

        final hash = await client.writeContract(
          address: contractAddress,
          abi: transfer,
          args: [
            '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
            BigInt.from(1000),
          ],
        );

        expect(hash, '0xtxhash');
        expect(sentData, startsWith('0xa9059cbb')); // transfer selector
      },
    );
  });

  group('deployContract', () {
    Map<String, Object?> blockWithBaseFee() => {
      'parentHash': '0x0',
      'sha3Uncles': '0x0',
      'transactionsRoot': '0x0',
      'stateRoot': '0x0',
      'receiptsRoot': '0x0',
      'miner': '0x0',
      'difficulty': '0x0',
      'extraData': '0x',
      'size': '0x0',
      'gasLimit': '0x1c9c380',
      'gasUsed': '0x0',
      'timestamp': '0x0',
      'transactions': <String>[],
      'uncles': <String>[],
      'baseFeePerGas': '0x3b9aca00',
    };

    test('deploys raw bytecode with no constructor args', () async {
      final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
      final bytecode = hexToBytes('0x60806040');
      String? sentTo;
      String? sentData;

      final transport = _FakeTransport((method, params) {
        switch (method) {
          case 'eth_getBlockByNumber':
            return blockWithBaseFee();
          case 'eth_maxPriorityFeePerGas':
            return '0x59682f00';
          case 'eth_getTransactionCount':
            return '0x0';
          case 'eth_estimateGas':
            final callObject = params[0] as Map;
            sentTo = callObject['to'] as String?;
            sentData = callObject['data'] as String;
            return '0x5208';
          case 'eth_chainId':
            return '0x1';
          case 'eth_sendRawTransaction':
            return '0xtxhash';
          default:
            throw StateError('unexpected method $method');
        }
      });
      final client = WalletClient(transport: transport, account: account);

      final hash = await client.deployContract(bytecode: bytecode);

      expect(hash, '0xtxhash');
      expect(sentTo, isNull); // contract creation: no `to`
      expect(sentData, bytesToHex(bytecode));
    });

    test('appends ABI-encoded constructor args to the bytecode', () async {
      final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
      final bytecode = hexToBytes('0x60806040');
      final constructor =
          parseAbiItem('constructor(address owner, uint256 supply)')
              as AbiConstructor;
      String? sentData;

      final transport = _FakeTransport((method, params) {
        switch (method) {
          case 'eth_getBlockByNumber':
            return blockWithBaseFee();
          case 'eth_maxPriorityFeePerGas':
            return '0x59682f00';
          case 'eth_getTransactionCount':
            return '0x0';
          case 'eth_estimateGas':
            sentData = (params[0] as Map)['data'] as String;
            return '0x5208';
          case 'eth_chainId':
            return '0x1';
          case 'eth_sendRawTransaction':
            return '0xtxhash';
          default:
            throw StateError('unexpected method $method');
        }
      });
      final client = WalletClient(transport: transport, account: account);

      await client.deployContract(
        bytecode: bytecode,
        abi: constructor,
        args: ['0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359', BigInt.from(1000)],
      );

      final expectedArgs = encodeAbiParameters(constructor.inputs, [
        '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        BigInt.from(1000),
      ]);
      expect(
        sentData,
        bytesToHex(bytecode) + bytesToHex(expectedArgs).substring(2),
      );
    });
  });

  group('getContractEvents', () {
    test('filters by the event signature and decodes returned logs', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getLogs');
        final filter = params[0] as Map;
        expect(filter['address'], '0xcontract');
        final topics = filter['topics'] as List;
        expect(topics[0], isNotNull); // signature hash always present

        return [
          {
            'address': '0xcontract',
            'topics': [topics[0], padHex('0xabc'), padHex('0xdef')],
            'data': bytesToHex(
              encodeAbiParameters(
                [const AbiParameter(name: 'value', type: 'uint256')],
                [BigInt.from(500)],
              ),
            ),
          },
        ];
      });
      final client = PublicClient(transport: transport);

      final events = await client.getContractEvents(
        address: '0xcontract',
        event: transferEvent,
      );
      expect(events, hasLength(1));
      expect(events.single['value'], BigInt.from(500));
    });
  });
}
