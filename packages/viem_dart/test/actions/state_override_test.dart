import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/viem_dart.dart';

class _RecordingTransport extends Transport {
  _RecordingTransport(this.result) : super(const TransportConfig());
  final String result;
  final List<JsonRpcRequest> requests = [];

  @override
  Future<JsonRpcResponse> request(JsonRpcRequest request) async {
    requests.add(request);
    return JsonRpcResponse(id: request.id, result: result);
  }
}

const _slot0 =
    '0x0000000000000000000000000000000000000000000000000000000000000000';
const _word42 =
    '0x000000000000000000000000000000000000000000000000000000000000002a';
const _target = '0x1111111111111111111111111111111111111111';

final _getValue =
    parseAbiItem('function getValue() view returns (uint256)') as AbiFunction;

void main() {
  group('serializeStateOverride', () {
    test('serialises every field into the eth_call shape', () {
      final json = serializeStateOverride([
        AccountStateOverride(
          address: _target,
          balance: BigInt.from(255),
          nonce: 7,
          code: '0x6001',
          stateDiff: {_slot0: _word42},
        ),
      ]);
      expect(json, {
        _target: {
          'balance': '0xff',
          'nonce': '0x7',
          'code': '0x6001',
          'stateDiff': {_slot0: _word42},
        },
      });
    });

    test('state replaces storage and is serialised as `state`', () {
      final json = serializeStateOverride([
        const AccountStateOverride(address: _target, state: {_slot0: _word42}),
      ]);
      expect(json, {
        _target: {
          'state': {_slot0: _word42},
        },
      });
    });

    test('an empty list serialises to an empty object', () {
      expect(serializeStateOverride(const []), isEmpty);
    });

    test('rejects state and stateDiff on the same account', () {
      expect(
        () => serializeStateOverride([
          const AccountStateOverride(
            address: _target,
            state: {_slot0: _word42},
            stateDiff: {_slot0: _word42},
          ),
        ]),
        throwsA(isA<StateAssignmentConflictError>()),
      );
    });

    test('rejects a repeated address, ignoring case', () {
      expect(
        () => serializeStateOverride([
          const AccountStateOverride(
            address: '0xAAAAaaaaAAAAaaaaAAAAaaaaAAAAaaaaAAAAaaaa',
          ),
          const AccountStateOverride(
            address: '0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          ),
        ]),
        throwsA(isA<AccountStateConflictError>()),
      );
    });

    test('rejects a slot or value that is not 32-byte hex', () {
      expect(
        () => serializeStateOverride([
          const AccountStateOverride(
            address: _target,
            stateDiff: {'0x0': '0x1'},
          ),
        ]),
        throwsArgumentError,
      );
      expect(
        () => serializeStateOverride([
          const AccountStateOverride(
            address: _target,
            stateDiff: {_slot0: '0x2a'},
          ),
        ]),
        throwsArgumentError,
      );
    });
  });

  group('call-level wiring', () {
    final overrides = [
      AccountStateOverride(address: _target, balance: BigInt.one),
    ];
    final expectedParam = {
      _target: {'balance': '0x1'},
    };

    test('call sends the override as the third eth_call parameter', () async {
      final transport = _RecordingTransport(_word42);
      await PublicClient(
        transport: transport,
      ).call(to: _target, data: '0x', stateOverride: overrides);
      expect(transport.requests.single.params, [
        {'to': _target, 'data': '0x'},
        'latest',
        expectedParam,
      ]);
    });

    test('call without an override sends exactly two parameters', () async {
      final transport = _RecordingTransport(_word42);
      await PublicClient(transport: transport).call(to: _target);
      expect(transport.requests.single.params, hasLength(2));
    });

    test('readContract forwards the override', () async {
      final transport = _RecordingTransport(_word42);
      final value = await PublicClient(transport: transport).readContract(
        address: _target,
        abi: _getValue,
        stateOverride: overrides,
      );
      expect(value, BigInt.from(42));
      expect(transport.requests.single.params[2], expectedParam);
    });

    test('readContract with an override bypasses multicall batching', () async {
      final transport = _RecordingTransport(_word42);
      final client = PublicClient(
        transport: transport,
        multicallBatch: const MulticallBatchConfig(),
      );
      final results = await Future.wait([
        client.readContract(
          address: _target,
          abi: _getValue,
          stateOverride: overrides,
        ),
        client.readContract(
          address: _target,
          abi: _getValue,
          stateOverride: overrides,
        ),
      ]);
      expect(results, [BigInt.from(42), BigInt.from(42)]);
      // Neither call went to Multicall3; each carries its own override.
      for (final request in transport.requests) {
        expect((request.params[0] as Map)['to'], _target);
        expect(request.params[2], expectedParam);
      }
    });

    test('simulateContract forwards the override', () async {
      final transport = _RecordingTransport(_word42);
      await PublicClient(transport: transport).simulateContract(
        address: _target,
        abi: _getValue,
        stateOverride: overrides,
      );
      expect(transport.requests.single.params[2], expectedParam);
    });
  });
}
