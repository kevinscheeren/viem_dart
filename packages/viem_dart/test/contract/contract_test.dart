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
  final abi = [
    parseAbiItem('function balanceOf(address owner) view returns (uint256)'),
    parseAbiItem(
      'function transfer(address to, uint256 amount) returns (bool)',
    ),
    parseAbiItem('function approve(address spender) view returns (uint256)'),
    parseAbiItem(
      'function approve(address spender, uint256 amount) view returns (uint256)',
    ),
    parseAbiItem(
      'event Transfer(address indexed from, address indexed to, uint256 value)',
    ),
  ];

  group('getContract / Contract.read', () {
    test('encodes the call and decodes the result', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_call');
        final callObject = (params[0] as Map)['data'] as String;
        expect(callObject, startsWith('0x70a08231')); // balanceOf selector
        return '0x000000000000000000000000000000000000000000000000000000000000002a';
      });
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: transport),
      );

      final result = await contract.read('balanceOf', [
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      ]);
      expect(result, BigInt.from(42));
    });

    test('throws ArgumentError for an unknown function name', () {
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: _FakeTransport((_, _) => null)),
      );
      expect(() => contract.read('nope'), throwsArgumentError);
    });

    test('resolves overloads by argument count', () async {
      String? sentData;
      final transport = _FakeTransport((method, params) {
        sentData = (params[0] as Map)['data'] as String;
        return '0x0000000000000000000000000000000000000000000000000000000000000001';
      });
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: transport),
      );

      await contract.read('approve', [
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
        BigInt.from(5),
      ]);
      // 2-arg approve(address,uint256) selector, not the 1-arg overload.
      expect(sentData, startsWith('0x095ea7b3'));
    });

    test('throws ArgumentError when no overload matches the arg count', () {
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: _FakeTransport((_, _) => null)),
      );
      expect(
        () => contract.read('approve', [
          '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
          BigInt.one,
          BigInt.two,
        ]),
        throwsArgumentError,
      );
    });
  });

  group('Contract.simulate', () {
    test('sends from/value and decodes the result', () async {
      final transport = _FakeTransport((method, params) {
        final callObject = params[0] as Map;
        expect(callObject['from'], '0xsender');
        expect(callObject['data'], startsWith('0xa9059cbb')); // transfer
        return '0x0000000000000000000000000000000000000000000000000000000000000001';
      });
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: transport),
      );

      final result = await contract.simulate('transfer', [
        '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        BigInt.from(1000),
      ], '0xsender');
      expect(result, true);
    });
  });

  group('Contract.getEvents', () {
    test('filters by the event signature and decodes returned logs', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_getLogs');
        final filter = params[0] as Map;
        expect(filter['address'], '0xcontract');
        final topics = filter['topics'] as List;
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
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: transport),
      );

      final events = await contract.getEvents('Transfer');
      expect(events, hasLength(1));
      expect(events.single['value'], BigInt.from(500));
    });

    test('throws ArgumentError for an unknown event name', () {
      final contract = getContract(
        address: '0xcontract',
        abi: abi,
        client: PublicClient(transport: _FakeTransport((_, _) => null)),
      );
      expect(() => contract.getEvents('Nope'), throwsArgumentError);
    });
  });

  group('getWalletContract / WalletContract.write', () {
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
        final contract = getWalletContract(
          address: contractAddress,
          abi: abi,
          client: WalletClient(transport: transport, account: account),
        );

        final hash = await contract.write('transfer', [
          '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
          BigInt.from(1000),
        ]);

        expect(hash, '0xtxhash');
        expect(sentData, startsWith('0xa9059cbb')); // transfer selector
      },
    );
  });
}
