import 'dart:convert';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/siwe.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeTransport extends Transport {
  _FakeTransport(this.result) : super(const TransportConfig());
  final String result;
  final List<JsonRpcRequest> requests = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    requests.add(request);
    return JsonRpcResponse(id: request.id, result: result);
  }
}

const _magicWord =
    '0x1626ba7e00000000000000000000000000000000000000000000000000000000';

void main() {
  final account = privateKeyToAccount(
    hexToBytes(
      '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
    ),
  );
  const contract = '0x5555555555555555555555555555555555555555';

  String buildMessage({String? address, String domain = 'example.com'}) =>
      createSiweMessage(
        address: address ?? account.address,
        chainId: 1,
        domain: domain,
        nonce: 'abcd12345678',
        uri: 'https://example.com/login',
        issuedAt: DateTime.utc(2024),
      );

  group('PublicClient.verifySiweMessage', () {
    late _FakeTransport transport;
    late PublicClient client;

    void answerWith(String result) {
      transport = _FakeTransport(result);
      client = PublicClient(transport: transport);
    }

    setUp(() => answerWith('0x'));

    test('verifies an EOA signature without an RPC call', () async {
      final message = buildMessage();
      final signature = signMessage(account, message: message);

      expect(
        await client.verifySiweMessage(
          message,
          signature: signature,
          time: DateTime.utc(2024),
        ),
        isTrue,
      );
      expect(transport.requests, isEmpty);
    });

    test(
      'asks the contract named in the message for a contract signature',
      () async {
        answerWith(_magicWord);
        final message = buildMessage(address: contract);

        expect(
          await client.verifySiweMessage(message, signature: '0x1234'),
          isTrue,
        );

        expect(transport.requests, hasLength(1));
        final tx = transport.requests.single.params[0]! as Map<String, Object?>;
        expect(tx['to'], contract);
        // isValidSignature(bytes32,bytes) with the EIP-191 hash of the message.
        expect(tx['data'], startsWith('0x1626ba7e'));
        expect(
          (tx['data']! as String).substring(10, 74),
          bytesToHex(
            hashEip191Message(Uint8List.fromList(utf8.encode(message))),
          ).substring(2),
        );
      },
    );

    test('is false when the contract does not accept the signature', () async {
      final message = buildMessage(address: contract);
      expect(
        await client.verifySiweMessage(message, signature: '0x1234'),
        isFalse,
      );
    });

    test('checks the message fields before asking the chain', () async {
      answerWith(_magicWord);
      final message = buildMessage(address: contract);

      expect(
        await client.verifySiweMessage(
          message,
          signature: '0x1234',
          domain: 'other.com',
        ),
        isFalse,
      );
      expect(
        await client.verifySiweMessage(
          message,
          signature: '0x1234',
          address: account.address,
        ),
        isFalse,
      );
      expect(
        await client.verifySiweMessage(
          buildMessage(address: contract),
          signature: '0x1234',
          nonce: 'another-nonce',
        ),
        isFalse,
      );
      expect(transport.requests, isEmpty);
    });
  });
}
