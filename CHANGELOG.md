# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## Unreleased

## 2026-10-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`viem_dart` - `v0.1.0`](#viem_dart---v010)

---

#### `viem_dart` - `v0.1.0`

 - **REFACTOR**(client): migrate public action extensions to PublicClient.
 - **REFACTOR**(examples): replace a retired dependency in flutter_example with plain Flutter.
 - **REFACTOR**(client): migrate anvil actions to TestClient, remove transitional Client alias.
 - **FIX**(client): keep the revert data on a batched readContract revert.
 - **FEAT**(test-actions): expand anvil test-client action coverage.
 - **FEAT**(transport): implement Transport interface, JSON-RPC layer, HttpTransport.
 - **FEAT**(crypto): implement keccak256, RLP, and EIP-55 address checksum.
 - **FEAT**(siwe): verify SIWE messages from contract accounts.
 - **FEAT**(client): verify ERC-6492 signatures from undeployed accounts in verifyHash.
 - **FEAT**(client): add a verifyHash action with ERC-1271 support.
 - **FEAT**(release): prepare release 1.0: SBOM, licence bundle, changelog and pub score.
 - **FEAT**(client): add stateOverride to call, readContract and simulateContract.
 - **FEAT**(crypto): implement secp256k1 sign/verify/recover and BaseError skeleton.
 - **FEAT**(transport): implement WebSocket, Fallback, Custom, and IPC transports.
 - **FEAT**(codegen): golden-file test harness + cli_example end-to-end proof.
 - **FEAT**(codegen): add GenerateAbi annotation + ABI JSON asset loading.
 - **FEAT**(accounts): add SIWE (Sign-In with Ethereum) utilities.
 - **FEAT**(client): add EIP-5792 batch calls (wallet_sendCalls).
 - **FEAT**(transactions): add a pluggable Kzg interface for EIP-4844.
 - **FEAT**(client): add a dedicated deployContract wallet action.
 - **FEAT**(accounts): add signature verify/recover utilities.
 - **FEAT**(utils): add getContractAddress (CREATE/CREATE2 address computation).
 - **FEAT**(contract): add getContract() runtime contract-instance wrapper.
 - **FEAT**(chain): implement Chain model, built-in chains, base Client.
 - **FEAT**(chain): port viem's ~700 built-in chain definitions.
 - **FEAT**(client): auto-batch readContract calls into multicall.
 - **FEAT**(client): dedupe identical in-flight RPC requests.
 - **FEAT**(transport): add JSON-RPC request batching to HttpTransport.
 - **FEAT**(transport): use eth_subscribe push notifications for watch* actions on WebSocketTransport.
 - **FEAT**(release): generate the SBOM and licence bundle and record the pub score.
 - **FEAT**(tooling): gate dependency licences and ship third-party notices.
 - **FEAT**(client): introduce PublicClient/WalletClient/TestClient hierarchy.
 - **FEAT**(client): implement Block/Transaction/TransactionReceipt/Log models and createPublicClient.
 - **FEAT**(errors): build typed error hierarchy for abi, rpc, transaction, account, ens, and contract domains.
 - **FEAT**(test-actions): implement snapshot/time-control actions.
 - **FEAT**(test-actions): implement impersonation actions.
 - **FEAT**(test-actions): implement anvil state-mutation actions.
 - **FEAT**(client): implement createTestClient.
 - **FEAT**(ens): implement getEnsResolver.
 - **FEAT**(ens): implement getEnsAvatar, getEnsText.
 - **FEAT**(ens): implement getEnsAddress, getEnsName.
 - **FEAT**(ens): implement Universal Resolver client.
 - **FEAT**(ens): implement normalize, wrapping a vendored ens_normalize.
 - **FEAT**(ens): implement namehash.
 - **FEAT**(actions): implement writeContract.
 - **FEAT**(actions): implement sendTransaction.
 - **FEAT**(actions): implement signTransaction.
 - **FEAT**(utils): implement hex/bytes conversion and unit conversion utils.
 - **FEAT**(transactions): implement EIP-7702 transaction serialize/sign/parse.
 - **FEAT**(transactions): implement EIP-1559 transaction serialize/sign/parse.
 - **FEAT**(transactions): implement EIP-2930 transaction serialize/sign/parse.
 - **FEAT**(transactions): implement legacy transaction serialize/sign/parse.
 - **FEAT**(transactions): define TransactionEnvelope model.
 - **FEAT**(client): implement createWalletClient, prepareTransactionRequest, sendRawTransaction.
 - **FEAT**(accounts): implement BIP-39 mnemonic support and BIP-32/44 HD derivation.
 - **FEAT**(accounts): implement EIP-712 signTypedData.
 - **FEAT**(accounts): implement Account model, privateKeyToAccount, signMessage.
 - **FEAT**(actions): implement multicall via Multicall3.
 - **FEAT**(actions): implement readContract/simulateContract and contract event actions.
 - **FEAT**(abi): implement human-readable ABI parser (parseAbi).
 - **FEAT**(abi): implement encodeEventTopics/decodeEventLog.
 - **FEAT**(abi): implement encodeFunctionData/decodeFunctionResult and error codecs.
 - **FEAT**(abi): implement encodeAbiParameters/decodeAbiParameters.
 - **FEAT**(abi): define AbiParameter and AbiItem models.
 - **FEAT**(actions): implement filters, waitForTransactionReceipt, and watchers.
 - **FEAT**(actions): implement gas-estimation and low-level state actions.
 - **FEAT**(actions): implement core public read actions.
 - **FEAT**(transactions): implement EIP-4844 blob transaction structure/serialization.
 - **DOCS**(viem_dart): dartdoc pass across all public subpath entrypoints.
