// Proves SIWE verification for contract accounts on a real anvil: a
// message signed by an ERC-1271 contract account, and by an account that
// isn't deployed yet (ERC-6492). The contracts are in
// fixtures/CapabilityProbes.sol.
@Tags(['integration'])
library;

import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/chains.dart';
import 'package:viem_dart/siwe.dart';
import 'package:viem_dart/utils.dart';
import 'package:viem_dart/viem_dart.dart';
import 'package:viem_dart_test_harness/anvil_harness.dart';

import 'fixtures/capability_probes.dart';

final _walletConstructor =
    parseAbiItem('constructor(address owner)') as AbiConstructor;
final _deploy =
    parseAbiItem('function deploy(address owner, bytes32 salt)') as AbiFunction;
final _walletAddress =
    parseAbiItem(
          'function walletAddress(address owner, bytes32 salt) view returns (address)',
        )
        as AbiFunction;

void main() {
  group('verifySiweMessage with a contract account on anvil', () {
    late AnvilHarness harness;
    late PublicClient client;
    late WalletClient deployer;
    late LocalAccount owner;
    late LocalAccount stranger;

    String messageFor(String address, {String domain = 'example.com'}) =>
        createSiweMessage(
          address: address,
          chainId: 31337,
          domain: domain,
          nonce: 'abcd12345678',
          uri: 'https://example.com/login',
          issuedAt: DateTime.utc(2024),
        );

    final time = DateTime.utc(2024, 1, 2);

    Future<String> deploy(String bytecode, [List<Object?>? args]) async {
      final hash = await deployer.deployContract(
        bytecode: hexToBytes(bytecode),
        abi: args == null ? null : _walletConstructor,
        args: args ?? const [],
      );
      final receipt = await client.waitForTransactionReceipt(hash);
      expect(receipt.status, 1, reason: 'deployment must succeed');
      return getAddress(receipt.contractAddress!);
    }

    setUpAll(() async {
      harness = await AnvilHarness.start(port: 8555);
      client = PublicClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
      );
      deployer = WalletClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
        account: harness.accounts[0],
      );
      owner = harness.accounts[1];
      stranger = harness.accounts[2];
    });

    tearDownAll(() => harness.stop());

    test(
      'an EOA message verifies through the client, and without one',
      () async {
        final message = messageFor(owner.address);
        final signature = signMessage(owner, message: message);

        expect(
          await client.verifySiweMessage(
            message,
            signature: signature,
            time: time,
          ),
          isTrue,
        );
        expect(
          verifySiweMessage(message, signature: signature, time: time),
          isTrue,
        );
        // The sync function has no node to ask about a contract account.
        final walletMessage = messageFor(
          await deploy(erc1271WalletBytecode, [owner.address]),
        );
        expect(
          verifySiweMessage(
            walletMessage,
            signature: signMessage(owner, message: walletMessage),
            time: time,
          ),
          isFalse,
        );
      },
    );

    group('a deployed contract account', () {
      late String wallet;

      setUpAll(() async {
        wallet = await deploy(erc1271WalletBytecode, [owner.address]);
      });

      test('verifies a message signed by its owner', () async {
        final message = messageFor(wallet);
        final signature = signMessage(owner, message: message);

        expect(
          await client.verifySiweMessage(
            message,
            signature: signature,
            time: time,
            domain: 'example.com',
          ),
          isTrue,
        );
        expect(
          await client.verifySiweMessage(
            message,
            signature: signatureToHex(signature),
            time: time,
          ),
          isTrue,
        );
      });

      test(
        'fails for a tampered message, a wrong signer and a wrong domain',
        () async {
          final message = messageFor(wallet);
          final signature = signMessage(owner, message: message);

          final tampered = message.replaceFirst('example.com', 'evil.com');
          expect(
            await client.verifySiweMessage(
              tampered,
              signature: signature,
              time: time,
            ),
            isFalse,
          );
          expect(
            await client.verifySiweMessage(
              message,
              signature: signMessage(stranger, message: message),
              time: time,
            ),
            isFalse,
          );
          expect(
            await client.verifySiweMessage(
              message,
              signature: signature,
              time: time,
              domain: 'other.com',
            ),
            isFalse,
          );
        },
      );
    });

    test(
      'verifies a message signed by an account that is not deployed yet',
      () async {
        final factory = await deploy(erc1271WalletFactoryBytecode);
        final salt = hexToBytes(padHex('0x07', size: 32));
        final wallet =
            (await client.readContract(
                  address: factory,
                  abi: _walletAddress,
                  args: [owner.address, salt],
                ))!
                as String;
        final message = messageFor(getAddress(wallet));
        final inner = signMessage(owner, message: message);
        final wrapped = Uint8List.fromList([
          ...encodeAbiParameters(
            const [
              AbiParameter(name: 'factory', type: 'address'),
              AbiParameter(name: 'factoryCalldata', type: 'bytes'),
              AbiParameter(name: 'signature', type: 'bytes'),
            ],
            [
              factory,
              encodeFunctionData(_deploy, [owner.address, salt]),
              hexToBytes(signatureToHex(inner)),
            ],
          ),
          ...hexToBytes(erc6492MagicSuffix),
        ]);

        expect(await client.getCode(wallet), isNull);
        expect(
          await client.verifySiweMessage(
            message,
            signature: wrapped,
            time: time,
          ),
          isTrue,
        );
        expect(
          await client.verifySiweMessage(
            message.replaceFirst('example.com', 'evil.com'),
            signature: wrapped,
            time: time,
          ),
          isFalse,
        );
        // An unwrapped signature from an undeployed account doesn't verify.
        expect(
          await client.verifySiweMessage(message, signature: inner, time: time),
          isFalse,
        );
      },
    );
  });
}
