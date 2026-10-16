import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.handler) : super(const TransportConfig());
  final Object? Function(String method, List<Object?> params) handler;
  final List<String> methods = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    methods.add(request.method);
    return JsonRpcResponse(
      id: request.id,
      result: handler(request.method, request.params),
    );
  }
}

Map<String, Object?> _blockWithBaseFee() => {
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

void main() {
  final account = privateKeyToAccount(hexToBytes(padHex('0x1')));
  const to = '0x70997970c51812dc3a010c7d01b50e0d17dc79c8';

  Object? handler(String method, List<Object?> params) {
    switch (method) {
      case 'eth_getBlockByNumber':
        return _blockWithBaseFee();
      case 'eth_maxPriorityFeePerGas':
        return '0x59682f00';
      case 'eth_getTransactionCount':
        return '0x5';
      case 'eth_estimateGas':
        return '0x5208';
      case 'eth_chainId':
        return '0x1';
      case 'eth_sendRawTransaction':
        return '0xtxhash';
      default:
        throw StateError('unexpected method $method');
    }
  }

  group('prepareTransactionRequest', () {
    test('fills nonce/gas/fees/chainId using the client\'s account', () async {
      final client = WalletClient(
        transport: _FakeTransport(handler),
        account: account,
      );
      final request = await client.prepareTransactionRequest(
        to: to,
        value: BigInt.from(1000),
      );

      expect(request.from, account.address);
      expect(request.to, to);
      expect(request.nonce, 5);
      expect(request.gas, BigInt.from(21000));
      expect(request.maxPriorityFeePerGas, BigInt.parse('59682f00', radix: 16));
      expect(request.chainId, BigInt.one);
    });

    test('an explicit from overrides the client account', () async {
      final client = WalletClient(
        transport: _FakeTransport(handler),
        account: account,
      );
      final request = await client.prepareTransactionRequest(from: to, to: to);
      expect(request.from, to);
    });

    test(
      'explicit nonce/gas/fees are used as-is without extra RPC calls',
      () async {
        final transport = _FakeTransport((method, params) {
          if (method == 'eth_chainId') return '0x1';
          throw StateError(
            'unexpected method $method for fully-specified request',
          );
        });
        final client = WalletClient(transport: transport, account: account);
        final request = await client.prepareTransactionRequest(
          to: to,
          nonce: 7,
          gas: BigInt.from(30000),
          maxFeePerGas: BigInt.from(100),
          maxPriorityFeePerGas: BigInt.from(10),
        );
        expect(request.nonce, 7);
        expect(request.gas, BigInt.from(30000));
      },
    );
  });

  group('signTransaction', () {
    test('dispatches a legacy transaction to signLegacyTransaction', () {
      final client = WalletClient(
        transport: _FakeTransport(handler),
        account: account,
      );
      final tx = LegacyTransaction(
        nonce: BigInt.zero,
        gasPrice: BigInt.one,
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        chainId: BigInt.one,
      );
      final expected = bytesToHex(
        serializeLegacyTransaction(signLegacyTransaction(tx, account)),
      );
      expect(client.signTransaction(tx), expected);
    });

    test('dispatches an EIP-1559 transaction to signEip1559Transaction', () {
      final client = WalletClient(
        transport: _FakeTransport(handler),
        account: account,
      );
      final tx = Eip1559Transaction(
        chainId: BigInt.one,
        nonce: BigInt.zero,
        maxPriorityFeePerGas: BigInt.one,
        maxFeePerGas: BigInt.from(2),
        gasLimit: BigInt.from(21000),
        to: to,
        value: BigInt.zero,
        data: Uint8List(0),
        accessList: const [],
      );
      final expected = bytesToHex(
        serializeEip1559Transaction(signEip1559Transaction(tx, account)),
      );
      expect(client.signTransaction(tx), expected);
    });
  });

  group('sendTransaction', () {
    test('prepares, signs, and submits an EIP-1559 transaction', () async {
      String? capturedRawTx;
      final transport = _FakeTransport((method, params) {
        if (method == 'eth_sendRawTransaction') {
          capturedRawTx = params.single as String;
        }
        return handler(method, params);
      });
      final client = WalletClient(transport: transport, account: account);

      final hash = await client.sendTransaction(
        to: to,
        value: BigInt.from(1000),
      );

      expect(hash, '0xtxhash');
      expect(capturedRawTx, isNotNull);
      final parsed = parseEip1559Transaction(hexToBytes(capturedRawTx!));
      expect(parsed.to, to);
      expect(parsed.value, BigInt.from(1000));
      expect(parsed.nonce, BigInt.from(5));
      expect(parsed.gasLimit, BigInt.from(21000));
      expect(parsed.chainId, BigInt.one);
    });
  });

  group('sendRawTransaction', () {
    test('submits the signed transaction and returns its hash', () async {
      final transport = _FakeTransport((method, params) {
        expect(method, 'eth_sendRawTransaction');
        expect(params, ['0xsigned']);
        return '0xtxhash';
      });
      final client = WalletClient(transport: transport, account: account);
      expect(await client.sendRawTransaction('0xsigned'), '0xtxhash');
    });
  });
}
