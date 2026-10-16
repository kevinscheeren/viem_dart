@Tags(['integration'])
library;

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

// Hand-assembled runtime bytecode, so the test needs no compiler:
//   returns 42:           PUSH1 2a PUSH1 0 MSTORE PUSH1 20 PUSH1 0 RETURN
//   returns own balance:  SELFBALANCE PUSH1 0 MSTORE PUSH1 20 PUSH1 0 RETURN
//   returns storage[0]:   PUSH1 0 SLOAD PUSH1 0 MSTORE PUSH1 20 PUSH1 0 RETURN
const _returns42 = '0x602a60005260206000f3';
const _returnsSelfBalance = '0x4760005260206000f3';
const _returnsSlot0 = '0x60005460005260206000f3';

const _slot0 =
    '0x0000000000000000000000000000000000000000000000000000000000000000';

String _word(int value) => '0x${value.toRadixString(16).padLeft(64, '0')}';

final _getValue =
    parseAbiItem('function getValue() view returns (uint256)') as AbiFunction;

void main() {
  group('state overrides on anvil', () {
    late AnvilHarness harness;
    late PublicClient client;
    // An address nobody deployed anything to.
    const target = '0x7777777777777777777777777777777777777777';

    setUpAll(() async {
      harness = await AnvilHarness.start(port: 8552);
      client = PublicClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
      );
    });

    tearDownAll(() => harness.stop());

    test('a code override makes an empty address answer the call', () async {
      expect(await client.getCode(target), isNull);

      final value = await client.readContract(
        address: target,
        abi: _getValue,
        stateOverride: const [
          AccountStateOverride(address: target, code: _returns42),
        ],
      );

      expect(value, BigInt.from(42));
      // The override was for that call only.
      expect(await client.getCode(target), isNull);
    });

    test('a balance override is visible to the call', () async {
      final balance = BigInt.parse('123456789000000000000');
      final value = await client.readContract(
        address: target,
        abi: _getValue,
        stateOverride: [
          AccountStateOverride(
            address: target,
            code: _returnsSelfBalance,
            balance: balance,
          ),
        ],
      );

      expect(value, balance);
      expect(await client.getBalance(target), BigInt.zero);
    });

    test(
      'a state override replaces storage; stateDiff patches a slot',
      () async {
        final viaState = await client.readContract(
          address: target,
          abi: _getValue,
          stateOverride: [
            AccountStateOverride(
              address: target,
              code: _returnsSlot0,
              state: {_slot0: _word(7)},
            ),
          ],
        );
        final viaDiff = await client.simulateContract(
          address: target,
          abi: _getValue,
          stateOverride: [
            AccountStateOverride(
              address: target,
              code: _returnsSlot0,
              stateDiff: {_slot0: _word(9)},
            ),
          ],
        );

        expect(viaState, BigInt.from(7));
        expect(viaDiff, BigInt.from(9));
      },
    );

    test('call returns the raw data with an override', () async {
      final raw = await client.call(
        to: target,
        stateOverride: const [
          AccountStateOverride(address: target, code: _returns42),
        ],
      );
      expect(hexToBigInt(raw), BigInt.from(42));
    });
  });
}
