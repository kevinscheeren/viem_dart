// Proves verifyHash on a real anvil: EOA signatures by recovery, ERC-1271
// signatures from a deployed contract account and ERC-6492 signatures
// from one that isn't deployed yet. The contracts are in
// fixtures/CapabilityProbes.sol.
@Tags(['integration'])
library;

import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/abi.dart';
import 'package:viem_dart/accounts.dart';
import 'package:viem_dart/chains.dart';
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

Uint8List _signatureBytes(Object signature) => switch (signature) {
  Signature() => hexToBytes(signatureToHex(signature)),
  final String hex => hexToBytes(hex),
  _ => signature as Uint8List,
};

/// `abi.encode(factory, factoryCalldata, signature) ++ magic`, an ERC-6492
/// signature.
Uint8List _wrap(String factory, Uint8List factoryCalldata, Object signature) =>
    Uint8List.fromList([
      ...encodeAbiParameters(
        const [
          AbiParameter(name: 'factory', type: 'address'),
          AbiParameter(name: 'factoryCalldata', type: 'bytes'),
          AbiParameter(name: 'signature', type: 'bytes'),
        ],
        [factory, factoryCalldata, _signatureBytes(signature)],
      ),
      ...hexToBytes(erc6492MagicSuffix),
    ]);

/// A signature with its last bit of `s` flipped: still well-formed, but not
/// the signer's.
String _tamper(Signature signature) => signatureToHex(
  Signature(
    r: signature.r,
    s: signature.s ^ BigInt.one,
    yParity: signature.yParity,
  ),
);

void main() {
  group('verifyHash on anvil', () {
    late AnvilHarness harness;
    late PublicClient client;
    late WalletClient deployer;

    final hash = hexToBytes(keccak256String('verifyHash on anvil'));
    final otherHash = hexToBytes(keccak256String('some other hash'));

    Future<String> deploy(
      String bytecode, {
      List<Object?> args = const [],
      bool withOwner = false,
    }) async {
      final txHash = withOwner
          ? await deployer.deployContract(
              bytecode: hexToBytes(bytecode),
              abi: _walletConstructor,
              args: args,
            )
          : await deployer.deployContract(bytecode: hexToBytes(bytecode));
      final receipt = await client.waitForTransactionReceipt(txHash);
      expect(receipt.status, 1, reason: 'deployment must succeed');
      return receipt.contractAddress!;
    }

    setUpAll(() async {
      harness = await AnvilHarness.start(port: 8554);
      client = PublicClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
      );
      deployer = WalletClient(
        transport: HttpTransport(Uri.parse(harness.rpcUrl)),
        chain: anvil,
        account: harness.accounts[0],
      );
    });

    tearDownAll(() => harness.stop());

    group('an EOA', () {
      late LocalAccount owner;
      late LocalAccount stranger;

      setUpAll(() {
        owner = harness.accounts[1];
        stranger = harness.accounts[2];
      });

      test('verifies a valid signature', () async {
        final signature = sign(hash, owner.privateKey);
        expect(
          await client.verifyHash(
            address: owner.address,
            hash: hash,
            signature: signature,
          ),
          isTrue,
        );
      });

      test(
        'fails for a wrong hash, a wrong signer and a tampered signature',
        () async {
          final signature = sign(hash, owner.privateKey);
          Future<bool> verify({
            required Uint8List hash,
            required Object signature,
            String? address,
          }) => client.verifyHash(
            address: address ?? owner.address,
            hash: hash,
            signature: signature,
          );

          expect(await verify(hash: otherHash, signature: signature), isFalse);
          expect(
            await verify(
              hash: hash,
              signature: sign(hash, stranger.privateKey),
            ),
            isFalse,
          );
          expect(
            await verify(hash: hash, signature: _tamper(signature)),
            isFalse,
          );
          expect(await verify(hash: hash, signature: '0x1234'), isFalse);
          expect(
            await verify(
              hash: hash,
              signature: signature,
              address: stranger.address,
            ),
            isFalse,
          );
        },
      );
    });

    group('a contract account (ERC-1271)', () {
      late String wallet;
      late LocalAccount owner;
      late LocalAccount stranger;

      setUpAll(() async {
        owner = harness.accounts[3];
        stranger = harness.accounts[4];
        wallet = await deploy(
          erc1271WalletBytecode,
          args: [owner.address],
          withOwner: true,
        );
      });

      Future<bool> verify(Uint8List hash, Object signature) =>
          client.verifyHash(address: wallet, hash: hash, signature: signature);

      test('verifies the owner\'s signature, in each accepted form', () async {
        final signature = sign(hash, owner.privateKey);
        expect(await verify(hash, signature), isTrue);
        expect(await verify(hash, signatureToHex(signature)), isTrue);
        expect(
          await verify(hash, hexToBytes(signatureToHex(signature))),
          isTrue,
        );
        expect(
          await verify(otherHash, sign(otherHash, owner.privateKey)),
          isTrue,
        );
      });

      test(
        'fails for a wrong hash, a wrong signer and a tampered signature',
        () async {
          final signature = sign(hash, owner.privateKey);

          expect(await verify(otherHash, signature), isFalse);
          expect(await verify(hash, sign(hash, stranger.privateKey)), isFalse);
          expect(await verify(hash, _tamper(signature)), isFalse);
          expect(await verify(hash, '0x1234'), isFalse);
          expect(await verify(hash, '0x'), isFalse);
        },
      );

      test('verifies against the state at the given block', () async {
        final later = await deploy(
          erc1271WalletBytecode,
          args: [owner.address],
          withOwner: true,
        );
        final signature = sign(hash, owner.privateKey);
        final laterBlock = await client.getBlockNumber();

        // No code at `later` a block before it was deployed.
        expect(
          await client.verifyHash(
            address: later,
            hash: hash,
            signature: signature,
            blockNumber: laterBlock - BigInt.one,
          ),
          isFalse,
        );
        expect(
          await client.verifyHash(
            address: later,
            hash: hash,
            signature: signature,
            blockNumber: laterBlock,
          ),
          isTrue,
        );
      });

      test('fails for a contract that returns a wrong magic value', () async {
        final wrongMagic = await deploy(erc1271WrongMagicBytecode);
        expect(
          await client.verifyHash(
            address: wrongMagic,
            hash: hash,
            signature: sign(hash, owner.privateKey),
          ),
          isFalse,
        );
      });

      test('fails for a contract that reverts', () async {
        final reverting = await deploy(erc1271RevertingBytecode);
        expect(
          await client.verifyHash(
            address: reverting,
            hash: hash,
            signature: sign(hash, owner.privateKey),
          ),
          isFalse,
        );
      });

      test('fails, without throwing, for an address with no code', () async {
        expect(
          await client.verifyHash(
            address: '0x7777777777777777777777777777777777777777',
            hash: hash,
            signature: sign(hash, owner.privateKey),
          ),
          isFalse,
        );
      });
    });

    group('an undeployed contract account (ERC-6492)', () {
      late String factory;
      late String reverting;
      late LocalAccount owner;
      late LocalAccount stranger;
      late Uint8List salt;
      late String wallet;
      late Uint8List deployCalldata;

      Future<String> counterfactual(LocalAccount owner, Uint8List salt) async =>
          (await client.readContract(
                address: factory,
                abi: _walletAddress,
                args: [owner.address, salt],
              ))!
              as String;

      Future<bool> verify(
        Object signature, {
        Uint8List? hash_,
        String? address,
      }) => client.verifyHash(
        address: address ?? wallet,
        hash: hash_ ?? hash,
        signature: signature,
      );

      setUpAll(() async {
        factory = await deploy(erc1271WalletFactoryBytecode);
        reverting = await deploy(erc1271RevertingBytecode);
        owner = harness.accounts[5];
        stranger = harness.accounts[6];
        salt = hexToBytes(padHex('0x01', size: 32));
        wallet = await counterfactual(owner, salt);
        deployCalldata = encodeFunctionData(_deploy, [owner.address, salt]);
      });

      test('verifies a wrapped signature without deploying anything', () async {
        expect(await client.getCode(wallet), isNull);

        final inner = sign(hash, owner.privateKey);
        final wrapped = _wrap(factory, deployCalldata, inner);
        expect(await verify(wrapped), isTrue);
        expect(await verify(bytesToHex(wrapped)), isTrue);

        // The deployment was only simulated.
        expect(await client.getCode(wallet), isNull);
      });

      test('fails for a plain signature from the undeployed account', () async {
        expect(await verify(sign(hash, owner.privateKey)), isFalse);
      });

      test(
        'fails for a wrong hash, a wrong signer and a tampered signature',
        () async {
          final inner = sign(hash, owner.privateKey);

          expect(
            await verify(
              _wrap(factory, deployCalldata, inner),
              hash_: otherHash,
            ),
            isFalse,
          );
          expect(
            await verify(
              _wrap(factory, deployCalldata, sign(hash, stranger.privateKey)),
            ),
            isFalse,
          );
          expect(
            await verify(_wrap(factory, deployCalldata, _tamper(inner))),
            isFalse,
          );
        },
      );

      test('fails when the factory call deploys a different account', () async {
        final otherOwner = encodeFunctionData(_deploy, [
          stranger.address,
          salt,
        ]);
        expect(
          await verify(
            _wrap(factory, otherOwner, sign(hash, owner.privateKey)),
          ),
          isFalse,
        );
      });

      test('fails when the factory call reverts, or deploys nothing', () async {
        final inner = sign(hash, owner.privateKey);

        expect(
          await verify(_wrap(reverting, deployCalldata, inner)),
          isFalse,
          reason: 'a factory that reverts',
        );
        expect(
          await verify(
            _wrap(harness.accounts[7].address, deployCalldata, inner),
          ),
          isFalse,
          reason: 'a factory that is not a contract',
        );
      });

      test('fails for a malformed wrapper', () async {
        final suffix = hexToBytes(erc6492MagicSuffix);
        for (final bytes in [
          suffix,
          Uint8List.fromList([1, 2, 3, ...suffix]),
          Uint8List.fromList([...Uint8List(96), ...suffix]),
        ]) {
          expect(await verify(bytes), isFalse, reason: bytesToHex(bytes));
        }
      });

      test('does not call the factory once the account is deployed', () async {
        final salt = hexToBytes(padHex('0x02', size: 32));
        final deployedWallet = await counterfactual(owner, salt);
        final inner = sign(hash, owner.privateKey);
        // The factory reverts, so only a skipped factory call verifies.
        final wrapped = _wrap(reverting, deployCalldata, inner);

        expect(
          await verify(wrapped, address: deployedWallet),
          isFalse,
          reason: 'not deployed yet, and the factory reverts',
        );

        final receipt = await client.waitForTransactionReceipt(
          await deployer.writeContract(
            address: factory,
            abi: _deploy,
            args: [owner.address, salt],
          ),
        );
        expect(receipt.status, 1);
        expect(await client.getCode(deployedWallet), isNotNull);

        expect(await verify(wrapped, address: deployedWallet), isTrue);
        expect(
          await verify(
            _wrap(reverting, deployCalldata, sign(otherHash, owner.privateKey)),
            address: deployedWallet,
          ),
          isFalse,
        );
      });
    });
  });
}
