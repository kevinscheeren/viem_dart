// Proves verifyHash against a real Safe v1.5.0 whose fallback handler is
// CoW's ExtensibleFallbackHandler, a common Safe setup.
// The other verifyHash tests use the minimal ERC-1271 contract in
// fixtures/CapabilityProbes.sol; a Safe answers ERC-1271 differently:
//
// - The Safe forwards `isValidSignature(bytes32,bytes)` to the handler, which
//   checks the owners' signatures over the EIP-712 *SafeMessage* digest of the
//   hash, not over the hash itself.
// - If the signature is `safeSignature(bytes32,bytes32,bytes,bytes)` encoded
//   and the Safe registered a domain verifier for its domain separator, the
//   handler asks that verifier instead.
//
// The Safe singleton, the SafeProxyFactory and the handler are the real
// deployments on Base, reached through an anvil fork pinned to one block
// (fixtures/safe/README.md); no Safe or CoW code is kept in this repository.
// The setup helper and the domain verifier are ours
// (fixtures/SafeTestHelpers.sol), deployed on the fork.
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

import 'fixtures/safe/base_fork.dart';
import 'fixtures/safe_test_helpers.dart';

AbiFunction _fn(String signature) => parseAbiItem(signature) as AbiFunction;

final _setup = _fn(
  'function setup(address[] owners, uint256 threshold, address to, bytes data, '
  'address fallbackHandler, address paymentToken, uint256 payment, '
  'address paymentReceiver)',
);
final _setDomainVerifier = _fn(
  'function setDomainVerifier(bytes32 domainSeparator, address verifier)',
);
final _createProxyWithNonce = _fn(
  'function createProxyWithNonce(address singleton, bytes initializer, '
  'uint256 saltNonce) returns (address proxy)',
);
final _safeDomainSeparator = _fn(
  'function domainSeparator() view returns (bytes32)',
);
final _domainVerifiers = _fn(
  'function domainVerifiers(address safe, bytes32 domainSeparator) '
  'view returns (address)',
);
final _safeSignature = _fn(
  'function safeSignature(bytes32 domainSeparator, bytes32 typeHash, '
  'bytes encodeData, bytes payload)',
);

const _zeroAddress = '0x0000000000000000000000000000000000000000';

/// The EIP-712 digest the handler asks the Safe's owners to sign for
/// [hash]: `SafeMessage(bytes message)` where `message` is the 32 hash bytes,
/// in the Safe's own domain (`chainId`, `verifyingContract`).
Uint8List _safeMessageDigest(String safe, Uint8List hash) => hashTypedData(
  domain: Eip712Domain(
    chainId: BigInt.from(baseChainId),
    verifyingContract: safe,
  ),
  types: const {
    'SafeMessage': [TypedDataField(name: 'message', type: 'bytes')],
  },
  primaryType: 'SafeMessage',
  message: {'message': hash},
);

/// `abi.encode(factory, factoryCalldata, signature) ++ magic`, an ERC-6492
/// signature.
Uint8List _wrap6492(
  String factory,
  Uint8List factoryCalldata,
  Signature signature,
) => Uint8List.fromList([
  ...encodeAbiParameters(
    const [
      AbiParameter(name: 'factory', type: 'address'),
      AbiParameter(name: 'factoryCalldata', type: 'bytes'),
      AbiParameter(name: 'signature', type: 'bytes'),
    ],
    [factory, factoryCalldata, hexToBytes(signatureToHex(signature))],
  ),
  ...hexToBytes(erc6492MagicSuffix),
]);

/// A signature with its last bit of `s` flipped: still well-formed, but not
/// the signer's.
Signature _tamper(Signature signature) => Signature(
  r: signature.r,
  s: signature.s ^ BigInt.one,
  yParity: signature.yParity,
);

void main() {
  group(
    'verifyHash against a Safe v1.5.0 with the ExtensibleFallbackHandler',
    () {
      late AnvilHarness harness;
      late PublicClient client;
      late WalletClient deployer;

      const singleton = safeSingleton;
      const factory = safeProxyFactory;
      const handler = cowExtensibleFallbackHandler;
      late String setupHelper;
      late LocalAccount owner;
      late LocalAccount stranger;
      late LocalAccount domainSigner;

      final hash = hexToBytes(keccak256String('verifyHash against a Safe'));
      final otherHash = hexToBytes(keccak256String('some other hash'));

      // The EIP-712 domain the Safe delegates to the domain verifier.
      final domainSeparator = hexToBytes(keccak256String('test domain'));
      final typeHash = hexToBytes(keccak256String('Test(uint256 n)'));
      final encodeData = hexToBytes(padHex('0x07', size: 32));
      final domainDigest = keccak256(
        Uint8List.fromList([
          0x19,
          0x01,
          ...domainSeparator,
          ...keccak256(Uint8List.fromList([...typeHash, ...encodeData])),
        ]),
      );
      late String verifier;

      Future<String> deploy(
        String bytecode, {
        Uint8List? constructorArgs,
      }) async {
        final txHash = await deployer.sendTransaction(
          data: bytesToHex(
            Uint8List.fromList([...hexToBytes(bytecode), ...?constructorArgs]),
          ),
        );
        final receipt = await client.waitForTransactionReceipt(txHash);
        expect(receipt.status, 1, reason: 'deployment must succeed');
        return receipt.contractAddress!;
      }

      /// The initializer of a Safe owned by [owner] alone, with the handler as
      /// its fallback handler and the domain verifier registered for
      /// [domainSeparator] from inside `setup`.
      late Uint8List initializer;

      Future<String> predictSafe(int saltNonce, Uint8List initializer) async =>
          (await client.simulateContract(
                address: factory,
                abi: _createProxyWithNonce,
                args: [singleton, initializer, BigInt.from(saltNonce)],
              ))!
              as String;

      Uint8List createProxyCall(int saltNonce, Uint8List initializer) =>
          encodeFunctionData(_createProxyWithNonce, [
            singleton,
            initializer,
            BigInt.from(saltNonce),
          ]);

      Future<void> deploySafe(int saltNonce, Uint8List initializer) async {
        final receipt = await client.waitForTransactionReceipt(
          await deployer.writeContract(
            address: factory,
            abi: _createProxyWithNonce,
            args: [singleton, initializer, BigInt.from(saltNonce)],
          ),
        );
        expect(receipt.status, 1, reason: 'Safe creation must succeed');
      }

      Uint8List initializerFor(LocalAccount safeOwner, String domainVerifier) =>
          encodeFunctionData(_setup, [
            [safeOwner.address],
            BigInt.one,
            setupHelper,
            encodeFunctionData(_setDomainVerifier, [
              domainSeparator,
              domainVerifier,
            ]),
            handler,
            _zeroAddress,
            BigInt.zero,
            _zeroAddress,
          ]);

      /// A `safeSignature(...)` signature, which the handler hands to the
      /// domain verifier registered for the domain.
      Uint8List domainSignature(Signature payload) =>
          encodeFunctionData(_safeSignature, [
            domainSeparator,
            typeHash,
            encodeData,
            hexToBytes(signatureToHex(payload)),
          ]);

      setUpAll(() async {
        harness = await AnvilHarness.start(
          port: 8556,
          forkUrl: baseForkUrl(),
          forkBlockNumber: baseForkBlockNumber,
        );
        client = PublicClient(
          transport: HttpTransport(Uri.parse(harness.rpcUrl)),
          chain: base,
        );
        deployer = WalletClient(
          transport: HttpTransport(Uri.parse(harness.rpcUrl)),
          chain: base,
          account: harness.accounts[0],
        );
        owner = harness.accounts[1];
        stranger = harness.accounts[2];
        domainSigner = harness.accounts[3];

        setupHelper = await deploy(safeSetupHelperBytecode);
        verifier = await deploy(
          ecdsaDomainVerifierBytecode,
          constructorArgs: encodeAbiParameters(
            const [AbiParameter(name: 'signer', type: 'address')],
            [domainSigner.address],
          ),
        );
        initializer = initializerFor(owner, verifier);
      });

      tearDownAll(() => harness.stop());

      test(
        'the fork holds the production contracts at the pinned block',
        () async {
          expect(await client.getChainId(), BigInt.from(baseChainId));
          // The fork's head is the pinned block (the deployments of our own
          // helpers in setUpAll mine on top of it).
          expect(
            await client.getBlockNumber(),
            greaterThanOrEqualTo(BigInt.from(baseForkBlockNumber)),
          );
          for (final entry in baseForkCodeHashes.entries) {
            final code = await client.getCode(entry.key);
            expect(keccak256Hex(code!), entry.value, reason: entry.key);
          }
        },
      );

      group('a deployed Safe', () {
        late String safe;

        Future<bool> verify(Uint8List hash, Object signature) =>
            client.verifyHash(address: safe, hash: hash, signature: signature);

        setUpAll(() async {
          safe = await predictSafe(1, initializer);
          await deploySafe(1, initializer);
        });

        test('is set up with the handler and the domain verifier', () async {
          expect(await client.getCode(safe), isNotNull);
          final registered = await client.readContract(
            address: handler,
            abi: _domainVerifiers,
            args: [safe, domainSeparator],
          );
          expect((registered! as String).toLowerCase(), verifier.toLowerCase());
          // Our own SafeMessage digest is built on the Safe's domain separator.
          final onChain = await client.readContract(
            address: safe,
            abi: _safeDomainSeparator,
          );
          expect(
            bytesToHex(onChain! as Uint8List),
            bytesToHex(
              hashTypedDataDomain(
                Eip712Domain(
                  chainId: BigInt.from(baseChainId),
                  verifyingContract: safe,
                ),
              ),
            ),
          );
        });

        test(
          'verifies the owner\'s signature of the SafeMessage digest, in each '
          'accepted form',
          () async {
            final signature = sign(
              _safeMessageDigest(safe, hash),
              owner.privateKey,
            );
            expect(await verify(hash, signature), isTrue);
            expect(await verify(hash, signatureToHex(signature)), isTrue);
            expect(
              await verify(hash, hexToBytes(signatureToHex(signature))),
              isTrue,
            );
            expect(
              await verify(
                otherHash,
                sign(_safeMessageDigest(safe, otherHash), owner.privateKey),
              ),
              isTrue,
            );
          },
        );

        test(
          'fails for a wrong signer, a wrong hash and a tampered signature',
          () async {
            final signature = sign(
              _safeMessageDigest(safe, hash),
              owner.privateKey,
            );

            expect(
              await verify(
                hash,
                sign(_safeMessageDigest(safe, hash), stranger.privateKey),
              ),
              isFalse,
              reason: 'a wrong signer',
            );
            expect(
              await verify(otherHash, signature),
              isFalse,
              reason: 'a signature for another hash',
            );
            expect(
              await verify(hash, _tamper(signature)),
              isFalse,
              reason: 'a tampered signature',
            );
            expect(await verify(hash, '0x1234'), isFalse);
          },
        );

        test('fails for the owner\'s signature of the bare hash', () async {
          // What an EOA would sign, and what the minimal ERC-1271 wallet of
          // CapabilityProbes.sol accepts. A Safe wants the SafeMessage digest instead.
          expect(await verify(hash, sign(hash, owner.privateKey)), isFalse);
        });

        test('fails for a SafeMessage signed for another Safe', () async {
          final otherSafe = await predictSafe(11, initializer);
          await deploySafe(11, initializer);
          final signature = sign(
            _safeMessageDigest(otherSafe, hash),
            owner.privateKey,
          );
          expect(
            await client.verifyHash(
              address: otherSafe,
              hash: hash,
              signature: signature,
            ),
            isTrue,
          );
          expect(await verify(hash, signature), isFalse);
        });

        test('fails for an empty signature, as no hash was approved', () async {
          expect(await verify(hash, '0x'), isFalse);
        });

        group('through the domain verifier', () {
          test('verifies a safeSignature the verifier accepts', () async {
            final payload = sign(domainDigest, domainSigner.privateKey);
            expect(
              await verify(domainDigest, domainSignature(payload)),
              isTrue,
            );
          });

          test('fails when the verifier rejects the payload', () async {
            final payload = sign(domainDigest, stranger.privateKey);
            expect(
              await verify(domainDigest, domainSignature(payload)),
              isFalse,
            );
            expect(
              await verify(
                domainDigest,
                domainSignature(
                  _tamper(sign(domainDigest, domainSigner.privateKey)),
                ),
              ),
              isFalse,
            );
          });

          test(
            'fails when the hash is not the one the domain data hashes to',
            () async {
              final payload = sign(otherHash, domainSigner.privateKey);
              expect(
                await verify(otherHash, domainSignature(payload)),
                isFalse,
              );
            },
          );

          test('fails for a domain the Safe has no verifier for', () async {
            // The handler then falls back to the SafeMessage check, which a
            // signature that is not an owner signature cannot pass.
            final payload = sign(domainDigest, domainSigner.privateKey);
            final unregistered = encodeFunctionData(_safeSignature, [
              hexToBytes(keccak256String('another domain')),
              typeHash,
              encodeData,
              hexToBytes(signatureToHex(payload)),
            ]);
            expect(await verify(domainDigest, unregistered), isFalse);
          });
        });
      });

      group('a counterfactual Safe (ERC-6492)', () {
        // Each test gets its own Safe, so one test deploying it can't change
        // what another sees.
        var nextSalt = 100;
        late String safe;
        late int salt;
        late Uint8List createCall;

        Future<bool> verify(Object signature, {Uint8List? hash_, String? at}) =>
            client.verifyHash(
              address: at ?? safe,
              hash: hash_ ?? hash,
              signature: signature,
            );

        setUp(() async {
          salt = nextSalt++;
          safe = await predictSafe(salt, initializer);
          createCall = createProxyCall(salt, initializer);
        });

        test(
          'verifies the owner\'s signature without deploying the Safe',
          () async {
            expect(await client.getCode(safe), isNull);

            final signature = sign(
              _safeMessageDigest(safe, hash),
              owner.privateKey,
            );
            final wrapped = _wrap6492(factory, createCall, signature);
            expect(await verify(wrapped), isTrue);
            expect(await verify(bytesToHex(wrapped)), isTrue);

            // The deployment was only simulated.
            expect(await client.getCode(safe), isNull);
          },
        );

        test(
          'fails for a plain owner signature from the undeployed Safe',
          () async {
            final signature = sign(
              _safeMessageDigest(safe, hash),
              owner.privateKey,
            );
            expect(await verify(signature), isFalse);
          },
        );

        test(
          'fails for a wrong signer, a wrong hash and a tampered signature',
          () async {
            final digest = _safeMessageDigest(safe, hash);
            final signature = sign(digest, owner.privateKey);

            expect(
              await verify(
                _wrap6492(
                  factory,
                  createCall,
                  sign(digest, stranger.privateKey),
                ),
              ),
              isFalse,
              reason: 'a wrong signer',
            );
            expect(
              await verify(
                _wrap6492(factory, createCall, signature),
                hash_: otherHash,
              ),
              isFalse,
              reason: 'a signature for another hash',
            );
            expect(
              await verify(_wrap6492(factory, createCall, _tamper(signature))),
              isFalse,
              reason: 'a tampered signature',
            );
          },
        );

        test('fails when the factory call creates a different Safe', () async {
          // Another owner's setup gives another address, so there is still no
          // code at `safe` after the simulated deployment.
          final strangersSafe = createProxyCall(
            salt,
            initializerFor(stranger, verifier),
          );
          final signature = sign(
            _safeMessageDigest(safe, hash),
            owner.privateKey,
          );
          expect(
            await verify(_wrap6492(factory, strangersSafe, signature)),
            isFalse,
          );
        });

        test('verifies a domain verifier signature, which the counterfactual '
            'setup registers', () async {
          final payload = sign(domainDigest, domainSigner.privateKey);
          final wrapped = Uint8List.fromList([
            ...encodeAbiParameters(
              const [
                AbiParameter(name: 'factory', type: 'address'),
                AbiParameter(name: 'factoryCalldata', type: 'bytes'),
                AbiParameter(name: 'signature', type: 'bytes'),
              ],
              [factory, createCall, domainSignature(payload)],
            ),
            ...hexToBytes(erc6492MagicSuffix),
          ]);
          expect(await verify(wrapped, hash_: domainDigest), isTrue);
          expect(await client.getCode(safe), isNull);
        });

        test(
          'still verifies the wrapped signature once the Safe is deployed',
          () async {
            final signature = sign(
              _safeMessageDigest(safe, hash),
              owner.privateKey,
            );
            final wrapped = _wrap6492(factory, createCall, signature);
            expect(await verify(wrapped), isTrue);

            await deploySafe(salt, initializer);
            expect(await client.getCode(safe), isNotNull);

            expect(await verify(wrapped), isTrue);
            expect(await verify(signature), isTrue);
            expect(
              await verify(_wrap6492(factory, createCall, _tamper(signature))),
              isFalse,
            );
          },
        );
      });
    },
  );
}
