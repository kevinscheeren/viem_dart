// Proves, on a real anvil, each capability an SDK built on viem_dart
// typically needs. The capability to API to test table is
// docs/viem-mapping.md; the numbering below follows that table.
//
// Capability 2's state overrides are tested in
// state_override_anvil_test.dart.
@Tags(['integration'])
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/test_actions.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

import 'fixtures/capability_probes.dart';

/// Forwards to [inner] and records every request, so a test can count
/// round trips and see which methods were called.
class _CountingTransport extends Transport {
  _CountingTransport(this.inner) : super(inner.config);
  final Transport inner;
  final List<String> methods = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) {
    methods.add(request.method);
    return inner.request(request);
  }
}

AbiFunction _fn(String signature) => parseAbiItem(signature) as AbiFunction;

final _ping = _fn('function ping(uint256 v)');
final _getStored = _fn('function getStored() view returns (uint256)');
final _failWithReason = _fn('function failWithReason() pure');
final _failWithCustom = _fn('function failWithCustom() pure');
final _nope = parseAbiItem('error Nope(uint256 code)') as AbiError;
final _pinged =
    parseAbiItem('event Pinged(address indexed who, uint256 value)')
        as AbiEvent;
final _aggregate3 = _fn(
  'function aggregate3((address target, bool allowFailure, bytes callData)[] calls) '
  'payable returns ((bool success, bytes returnData)[] returnData)',
);

const _orderTuple =
    '(address sellToken, address buyToken, address receiver, uint256 sellAmount, '
    'uint256 buyAmount, uint32 validTo, bytes32 appData, uint256 feeAmount, '
    'string kind, bool partiallyFillable, string sellTokenBalance, '
    'string buyTokenBalance)';
final _gpv2Digest = _fn(
  'function gpv2Digest($_orderTuple o, uint256 chainId, address settlement) pure returns (bytes32)',
);
const _safeTxTuple =
    '(address to, uint256 value, bytes data, uint8 operation, uint256 safeTxGas, '
    'uint256 baseGas, uint256 gasPrice, address gasToken, address refundReceiver, '
    'uint256 nonce)';
final _safeTxDigest = _fn(
  'function safeTxDigest($_safeTxTuple t, uint256 chainId, address safe) pure returns (bytes32)',
);

void main() {
  group('SDK capabilities on anvil', () {
    late AnvilHarness harness;
    late _CountingTransport transport;
    late PublicClient client;
    late TestClient testClient;
    late WalletClient deployer;

    Future<TransactionReceipt> send({String? to, String? data}) async {
      final hash = await deployer.sendTransaction(to: to, data: data);
      return client.waitForTransactionReceipt(hash);
    }

    Future<String> deploy(String bytecode) async {
      final receipt = await send(data: bytecode);
      expect(receipt.status, 1, reason: 'deployment must succeed');
      return receipt.contractAddress!;
    }

    setUpAll(() async {
      harness = await AnvilHarness.start(port: 8553);
      transport = _CountingTransport(HttpTransport(Uri.parse(harness.rpcUrl)));
      client = PublicClient(transport: transport, chain: anvil);
      testClient = TestClient(transport: transport, chain: anvil);
      deployer = WalletClient(
        transport: transport,
        chain: anvil,
        account: harness.accounts[0],
      );
    });

    tearDownAll(() => harness.stop());

    group('1. getCode', () {
      test('returns the code of a contract, null for an EOA, and null before '
          'the deployment block', () async {
        final receipt = await send(data: probeBytecode);
        final address = receipt.contractAddress!;

        final code = await client.getCode(address);
        expect(code, isNotNull);
        expect(code, startsWith('0x'));
        expect(code, isNot('0x'));
        expect(await client.getCode(harness.accounts[1].address), isNull);
        expect(
          await client.getCode(
            address,
            blockNumber: receipt.blockNumber - BigInt.one,
          ),
          isNull,
        );
        expect(
          await client.getCode(address, blockNumber: receipt.blockNumber),
          code,
        );
      });
    });

    group('2. call and readContract at a block', () {
      test('read the value as of the requested block number or tag', () async {
        final probe = await deploy(probeBytecode);

        final first = await deployer.writeContract(
          address: probe,
          abi: _ping,
          args: [BigInt.from(1)],
        );
        final firstBlock = (await client.waitForTransactionReceipt(
          first,
        )).blockNumber;
        final second = await deployer.writeContract(
          address: probe,
          abi: _ping,
          args: [BigInt.from(2)],
        );
        await client.waitForTransactionReceipt(second);

        expect(
          await client.readContract(address: probe, abi: _getStored),
          BigInt.two,
        );
        expect(
          await client.readContract(
            address: probe,
            abi: _getStored,
            blockNumber: firstBlock,
          ),
          BigInt.one,
        );
        expect(
          await client.readContract(
            address: probe,
            abi: _getStored,
            blockTag: 'latest',
          ),
          BigInt.two,
        );
        // call() is the same read without the ABI layer.
        final raw = await client.call(
          to: probe,
          data: bytesToHex(encodeFunctionData(_getStored, [])),
          blockNumber: firstBlock,
        );
        expect(hexToBigInt(raw), BigInt.one);
        // State overrides: see state_override_anvil_test.dart.
      });
    });

    group('3. CREATE2 getContractAddress', () {
      // Nick's deterministic deployment proxy; anvil ships it.
      const create2Deployer = '0x4e59b44847b379578588920ca78fbf26c0b4956c';

      test('predicts the address a CREATE2 deployment lands on', () async {
        final salt = padHex('0x5afe', size: 32);
        final initCode = probeBytecode;
        final predicted = getContractAddress(
          from: create2Deployer,
          salt: salt,
          bytecode: initCode,
        );
        expect(await client.getCode(predicted), isNull);

        final receipt = await send(
          to: create2Deployer,
          data: concatHex([salt, initCode]),
        );

        expect(receipt.status, 1);
        expect(await client.getCode(predicted), isNotNull);
        // A different salt predicts a different address.
        expect(
          getContractAddress(
            from: create2Deployer,
            salt: padHex('0x5afd', size: 32),
            bytecode: initCode,
          ),
          isNot(predicted),
        );
      });

      test('predicts the CREATE address from the sender nonce', () async {
        final nonce = await client.getTransactionCount(
          harness.accounts[0].address,
        );
        final predicted = getContractAddress(
          from: harness.accounts[0].address,
          nonce: BigInt.from(nonce),
        );

        final receipt = await send(data: probeBytecode);

        expect(isAddressEqual(receipt.contractAddress!, predicted), isTrue);
      });
    });

    group('4. ABI encode and decode', () {
      test(
        'round-trips arguments, returns, events and custom errors',
        () async {
          final probe = await deploy(probeBytecode);
          final hash = await deployer.writeContract(
            address: probe,
            abi: _ping,
            args: [BigInt.from(77)],
          );
          final receipt = await client.waitForTransactionReceipt(hash);

          // Event: decoded from the log of the receipt.
          final decoded = decodeEventLog(
            _pinged,
            topics: receipt.logs.single.topics,
            data: hexToBytes(receipt.logs.single.data),
          );
          expect(
            isAddressEqual(decoded['who']! as String, deployer.account.address),
            isTrue,
          );
          expect(decoded['value'], BigInt.from(77));

          // Custom error: decoded from the revert data of a real revert.
          final error = await _revertOf(
            () => client.readContract(address: probe, abi: _failWithCustom),
          );
          expect(decodeErrorResult(_nope, hexToBytes(error.data! as String)), [
            BigInt.from(42),
          ]);
        },
      );

      // Typed-contract codegen is covered by viem_dart_builders' own tests
      // (golden-file harness), by its anvil-backed
      // generated_contract_anvil_test.dart and by
      // examples/cli_example; see docs/viem-mapping.md.
    });

    group('5. EIP-712 hashTypedData', () {
      test('known anchors: the CoW mainnet domain separator and the Safe '
          'typehash', () {
        // GPv2Settlement on mainnet: the value CoW publishes.
        expect(
          bytesToHex(
            hashTypedDataDomain(
              Eip712Domain(
                name: 'Gnosis Protocol',
                version: 'v2',
                chainId: BigInt.one,
                verifyingContract: '0x9008D19f58AAbD9eD0D60971565AA8510560ab41',
              ),
            ),
          ),
          '0xc078f884a2676e1345748b1feace7b0abee5d00ecadb6e574dcdd109a63e8943',
        );
        // SAFE_TX_TYPEHASH of Safe v1.3.0 / v1.4.1.
        expect(
          keccak256String(
            'SafeTx(address to,uint256 value,bytes data,uint8 operation,'
            'uint256 safeTxGas,uint256 baseGas,uint256 gasPrice,'
            'address gasToken,address refundReceiver,uint256 nonce)',
          ),
          '0xbb8310d486368db6bd6f849402fdd73ad53d316b5a4b2644ad6efe0f941286d8',
        );
      });

      test(
        'GPv2 order digest matches an independent Solidity implementation',
        () async {
          final oracle = await deploy(eip712OracleBytecode);
          const settlement = '0x9008D19f58AAbD9eD0D60971565AA8510560ab41';
          final order = <String, Object?>{
            'sellToken': '0x4200000000000000000000000000000000000006',
            'buyToken': '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
            'receiver': '0x1111111111111111111111111111111111111111',
            'sellAmount': BigInt.parse('1000000000000000000'),
            'buyAmount': BigInt.from(2500000000),
            'validTo': 1893456000,
            // bytes32 and bytes values are Uint8List in viem_dart, not hex strings.
            'appData': hexToBytes(padHex('0xabcd', size: 32)),
            'feeAmount': BigInt.zero,
            'kind': 'sell',
            'partiallyFillable': false,
            'sellTokenBalance': 'erc20',
            'buyTokenBalance': 'erc20',
          };

          final dart = hashTypedData(
            domain: Eip712Domain(
              name: 'Gnosis Protocol',
              version: 'v2',
              chainId: BigInt.from(8453),
              verifyingContract: settlement,
            ),
            types: {
              'Order': const [
                TypedDataField(name: 'sellToken', type: 'address'),
                TypedDataField(name: 'buyToken', type: 'address'),
                TypedDataField(name: 'receiver', type: 'address'),
                TypedDataField(name: 'sellAmount', type: 'uint256'),
                TypedDataField(name: 'buyAmount', type: 'uint256'),
                TypedDataField(name: 'validTo', type: 'uint32'),
                TypedDataField(name: 'appData', type: 'bytes32'),
                TypedDataField(name: 'feeAmount', type: 'uint256'),
                TypedDataField(name: 'kind', type: 'string'),
                TypedDataField(name: 'partiallyFillable', type: 'bool'),
                TypedDataField(name: 'sellTokenBalance', type: 'string'),
                TypedDataField(name: 'buyTokenBalance', type: 'string'),
              ],
            },
            primaryType: 'Order',
            message: order,
          );

          final onChain = await client.readContract(
            address: oracle,
            abi: _gpv2Digest,
            args: [
              [
                order['sellToken'],
                order['buyToken'],
                order['receiver'],
                order['sellAmount'],
                order['buyAmount'],
                order['validTo'],
                order['appData'],
                order['feeAmount'],
                order['kind'],
                order['partiallyFillable'],
                order['sellTokenBalance'],
                order['buyTokenBalance'],
              ],
              BigInt.from(8453),
              settlement,
            ],
          );
          expect(bytesToHex(dart), bytesToHex(onChain! as Uint8List));
        },
      );

      test('Safe transaction digest matches an independent Solidity '
          'implementation', () async {
        final oracle = await deploy(eip712OracleBytecode);
        const safe = '0x2222222222222222222222222222222222222222';
        final tx = <String, Object?>{
          'to': '0x3333333333333333333333333333333333333333',
          'value': BigInt.from(5),
          'data': hexToBytes('0xdeadbeef'),
          'operation': 1,
          'safeTxGas': BigInt.from(100000),
          'baseGas': BigInt.from(21000),
          'gasPrice': BigInt.zero,
          'gasToken': '0x0000000000000000000000000000000000000000',
          'refundReceiver': '0x0000000000000000000000000000000000000000',
          'nonce': BigInt.from(3),
        };

        final dart = hashTypedData(
          domain: Eip712Domain(
            chainId: BigInt.from(8453),
            verifyingContract: safe,
          ),
          types: {
            'SafeTx': const [
              TypedDataField(name: 'to', type: 'address'),
              TypedDataField(name: 'value', type: 'uint256'),
              TypedDataField(name: 'data', type: 'bytes'),
              TypedDataField(name: 'operation', type: 'uint8'),
              TypedDataField(name: 'safeTxGas', type: 'uint256'),
              TypedDataField(name: 'baseGas', type: 'uint256'),
              TypedDataField(name: 'gasPrice', type: 'uint256'),
              TypedDataField(name: 'gasToken', type: 'address'),
              TypedDataField(name: 'refundReceiver', type: 'address'),
              TypedDataField(name: 'nonce', type: 'uint256'),
            ],
          },
          primaryType: 'SafeTx',
          message: tx,
        );

        final onChain = await client.readContract(
          address: oracle,
          abi: _safeTxDigest,
          args: [
            [
              tx['to'],
              tx['value'],
              tx['data'],
              tx['operation'],
              tx['safeTxGas'],
              tx['baseGas'],
              tx['gasPrice'],
              tx['gasToken'],
              tx['refundReceiver'],
              tx['nonce'],
            ],
            BigInt.from(8453),
            safe,
          ],
        );
        expect(bytesToHex(dart), bytesToHex(onChain! as Uint8List));
      });
    });

    group(
      '6. keccak256, address checksum and normalisation, hex and BigInt',
      () {
        test('agree with what the node returns', () async {
          final probe = await deploy(probeBytecode);
          final hash = await deployer.writeContract(
            address: probe,
            abi: _ping,
            args: [BigInt.from(5)],
          );
          final receipt = await client.waitForTransactionReceipt(hash);
          final log = receipt.logs.single;

          // keccak256: topic0 is the hash of the event signature.
          expect(log.topics[0], keccak256String('Pinged(address,uint256)'));
          // keccak256 over bytes: the function selector of a contract call.
          expect(
            bytesToHex(
              keccak256(Uint8List.fromList('ping(uint256)'.codeUnits)),
            ).substring(0, 10),
            bytesToHex(
              encodeFunctionData(_ping, [BigInt.one]),
            ).substring(0, 10),
          );

          // Address: the node returns lowercase; checksum and 20-byte
          // normalisation give the same address the account derives.
          final fromTopic = '0x${log.topics[1].substring(26)}';
          expect(fromTopic, fromTopic.toLowerCase());
          expect(isAddress(fromTopic), isTrue);
          expect(getAddress(fromTopic), deployer.account.address);
          expect(
            isAddressEqual(
              fromTopic,
              deployer.account.address.toUpperCase().replaceFirst('0X', '0x'),
            ),
            isTrue,
          );

          // Hex and BigInt: a balance round-trips through the node's hex.
          const target = '0x4444444444444444444444444444444444444444';
          final wei = BigInt.parse('123456789012345678901234567890');
          await testClient.setBalance(address: target, value: wei);
          final raw = await client.rpc.request('eth_getBalance', [
            target,
            'latest',
          ]);
          expect(raw, bigIntToHex(wei));
          expect(hexToBigInt(raw! as String), wei);
          expect(await client.getBalance(target), wei);
        });
      },
    );

    group('7. getLogs with a block range', () {
      test(
        'returns only the logs inside the range and the topic filter',
        () async {
          final probe = await deploy(probeBytecode);
          final blocks = <BigInt>[];
          for (final value in [1, 2, 3]) {
            final hash = await deployer.writeContract(
              address: probe,
              abi: _ping,
              args: [BigInt.from(value)],
            );
            blocks.add(
              (await client.waitForTransactionReceipt(hash)).blockNumber,
            );
          }
          final topic0 = keccak256String('Pinged(address,uint256)');

          final all = await client.getLogs(
            address: probe,
            topics: [topic0],
            fromBlockNumber: blocks.first,
            toBlockNumber: blocks.last,
          );
          final middle = await client.getLogs(
            address: probe,
            topics: [topic0],
            fromBlockNumber: blocks[1],
            toBlockNumber: blocks[1],
          );
          final decoded = await client.getContractEvents(
            address: probe,
            event: _pinged,
            args: {'who': deployer.account.address},
            fromBlockNumber: blocks[1],
            toBlockNumber: blocks.last,
          );
          final otherSender = await client.getContractEvents(
            address: probe,
            event: _pinged,
            args: {'who': harness.accounts[5].address},
            fromBlockNumber: blocks.first,
          );

          expect(all, hasLength(3));
          expect(middle, hasLength(1));
          expect(middle.single.blockNumber, blocks[1]);
          expect(decoded.map((e) => e['value']), [BigInt.two, BigInt.from(3)]);
          expect(otherSender, isEmpty);
        },
      );
    });

    group('8. multicall aggregation', () {
      test('aggregates calls, reports a failed call as data and propagates a '
          'required one', () async {
        final probe = await deploy(probeBytecode);
        final multicall = await deploy(aggregate3Bytecode);
        final hash = await deployer.writeContract(
          address: probe,
          abi: _ping,
          args: [BigInt.from(9)],
        );
        await client.waitForTransactionReceipt(hash);

        final results = await client.multicall(
          multicallAddress: multicall,
          calls: [
            (
              address: probe,
              abi: _getStored,
              args: const [],
              allowFailure: false,
            ),
            (
              address: probe,
              abi: _getStored,
              args: const [],
              allowFailure: false,
            ),
            (
              address: probe,
              abi: _failWithReason,
              args: const [],
              allowFailure: true,
            ),
          ],
        );

        expect(results, hasLength(3));
        expect(results[0].result, BigInt.from(9));
        expect(results[1].result, BigInt.from(9));
        expect(results[2].success, isFalse);
        // The failed call's revert data is kept: Error(string) "boom".
        expect(bytesToHex(results[2].returnData), startsWith('0x08c379a0'));

        await expectLater(
          client.multicall(
            multicallAddress: multicall,
            calls: [
              (
                address: probe,
                abi: _failWithReason,
                args: const [],
                allowFailure: false,
              ),
            ],
          ),
          throwsA(isA<RpcError>()),
        );
        // Sanity: the raw aggregate3 ABI is the one Multicall3 uses.
        expect(
          bytesToHex(abiSelector(_aggregate3.name, _aggregate3.inputs)),
          '0x82ad56cb',
        );
      });

      test('a client-level multicallBatch folds concurrent readContract '
          'calls into one eth_call', () async {
        final probe = await deploy(probeBytecode);
        final multicall = await deploy(aggregate3Bytecode);
        final batching = PublicClient(
          transport: transport,
          chain: anvil,
          multicallBatch: MulticallBatchConfig(multicallAddress: multicall),
        );
        transport.methods.clear();

        final values = await Future.wait([
          batching.readContract(address: probe, abi: _getStored),
          batching.readContract(address: probe, abi: _getStored),
          batching.readContract(address: probe, abi: _getStored),
        ]);

        expect(values, everyElement(isA<BigInt>()));
        expect(transport.methods.where((m) => m == 'eth_call'), hasLength(1));
      });
    });

    group('9. getBlockNumber and block-tagged reads', () {
      test('getBlockNumber follows mined blocks; reads by tag and number '
          'agree', () async {
        final before = await client.getBlockNumber();
        await testClient.mine(blocks: 2);
        final after = await client.getBlockNumber();
        expect(after - before, BigInt.two);

        final latest = await client.getBlock();
        expect(latest!.number, after);
        final atNumber = await client.getBlock(blockNumber: before);
        expect(atNumber!.number, before);

        // A balance read at an earlier block sees the earlier balance.
        const target = '0x5555555555555555555555555555555555555555';
        final fund = await deployer.sendTransaction(
          to: target,
          value: BigInt.one,
        );
        final mark = (await client.waitForTransactionReceipt(fund)).blockNumber;
        final more = await deployer.sendTransaction(
          to: target,
          value: BigInt.one,
        );
        await client.waitForTransactionReceipt(more);
        expect(await client.getBalance(target, blockNumber: mark), BigInt.one);
        expect(await client.getBalance(target), BigInt.two);
        expect(
          await client.getBalance(target, blockNumber: mark - BigInt.one),
          BigInt.zero,
        );
      });
    });

    group('10. HTTP transport', () {
      test(
        'takes the caller\'s URL: requests go there and nowhere else',
        () async {
          final seen = <Uri>[];
          final mock = MockClient((request) async {
            seen.add(request.url);
            return http.Response(
              '{"jsonrpc":"2.0","id":1,"result":"0x2a"}',
              200,
            );
          });
          final url = Uri.parse('https://rpc.integrator.example/v1/key');
          final spy = PublicClient(transport: HttpTransport(url, client: mock));

          expect(await spy.getBlockNumber(), BigInt.from(42));
          expect(seen, [url]);
        },
      );

      test('makes no call at construction', () {
        var calls = 0;
        final mock = MockClient((request) async {
          calls++;
          return http.Response('{}', 200);
        });
        final httpTransport = HttpTransport(
          Uri.parse('https://rpc.integrator.example'),
          client: mock,
        );
        PublicClient(transport: httpTransport, chain: anvil);
        WalletClient(
          transport: httpTransport,
          chain: anvil,
          account: harness.accounts[0],
        );
        expect(calls, 0);

        final counting = _CountingTransport(
          HttpTransport(Uri.parse(harness.rpcUrl)),
        );
        PublicClient(transport: counting, chain: anvil);
        expect(counting.methods, isEmpty);
      });

      test(
        'keeps no global state: two clients both start at request id 1',
        () async {
          final ids = <int>[];
          Transport recording() => CustomTransport((request) async {
            ids.add(request.id);
            return JsonRpcResponse(id: request.id, result: '0x1');
          });
          await PublicClient(transport: recording()).getChainId();
          await PublicClient(transport: recording()).getChainId();
          expect(ids, [1, 1]);
        },
      );
    });

    group('failure path', () {
      test(
        'a revert surfaces as an RpcError that carries the revert data',
        () async {
          final probe = await deploy(probeBytecode);

          final reason = await _revertOf(
            () => client.readContract(address: probe, abi: _failWithReason),
          );
          final custom = await _revertOf(
            () => client.readContract(address: probe, abi: _failWithCustom),
          );

          // Error(string): selector 0x08c379a0 and the string "boom".
          final reasonData = hexToBytes(reason.data! as String);
          expect(
            bytesToHex(Uint8List.sublistView(reasonData, 0, 4)),
            '0x08c379a0',
          );
          expect(
            decodeAbiParameters(const [
              AbiParameter(name: '', type: 'string'),
            ], Uint8List.sublistView(reasonData, 4)),
            ['boom'],
          );
          expect(reason.code, 3);
          expect(decodeErrorResult(_nope, hexToBytes(custom.data! as String)), [
            BigInt.from(42),
          ]);
        },
      );
    });
  });
}

/// Runs [action], which must revert, and returns the [RpcError] it threw.
Future<RpcError> _revertOf(Future<Object?> Function() action) async {
  try {
    await action();
  } on RpcError catch (error) {
    return error;
  }
  fail('expected the call to revert');
}
