# viem to viem_dart mapping

The viem capabilities an SDK built on viem_dart typically relies on, the
viem_dart API that provides each, and the test that proves it on a real anvil.
This is the surface to treat as stable (see `docs/release.md`, "Versioning").

- Tests live in `packages/viem_dart/test/integration/`. Run them with
  `melos run test:integration` (needs Foundry's `anvil` on `PATH`).
- Test contracts are in `test/integration/fixtures/CapabilityProbes.sol`;
  `fixtures/build_probes.sh` regenerates `capability_probes.dart` from it.
- Import paths: `package:viem_dart/viem_dart.dart` (clients, transports,
  actions, errors), `.../abi.dart`, `.../accounts.dart`, `.../utils.dart`.

## Capabilities

| # | Capability | viem | viem_dart | Proof (test group in `sdk_capabilities_test.dart` unless noted) |
| --- | --- | --- | --- | --- |
| 1 | Read contract code | `getCode` | `PublicClient.getCode(address, {blockNumber, blockTag})`; `null` when there is no code | `1. getCode` |
| 2 | Call and read at a block | `call`, `readContract` with `blockNumber` / `blockTag` | `PublicClient.call`, `readContract`, `simulateContract`, each with `blockNumber` and `blockTag` | `2. call and readContract at a block` |
| 2b | Call with state overrides | `call({ stateOverride })` | `stateOverride: List<AccountStateOverride>` on `call`, `readContract`, `simulateContract` | `state_override_anvil_test.dart`, `state_override_test.dart` |
| 3 | CREATE2 / CREATE address | `getContractAddress` | `getContractAddress({from, salt, bytecode})` and `({from, nonce})` | `3. CREATE2 getContractAddress` |
| 4 | ABI encode, decode, typed codegen | `encodeFunctionData`, `decodeFunctionResult`, `decodeEventLog`, `decodeErrorResult`, `parseAbi`; typed bindings via abitype | same names in `abi.dart`; `viem_dart_builders` `@GenerateAbi` for typed `<Name>Contract` / `<Name>WalletContract` | `4. ABI encode and decode`; codegen: `packages/viem_dart_builders/test/generate_abi_generator_golden_test.dart`, `examples/cli_example/lib/weth.g.dart` (see gap below) |
| 5 | EIP-712 digest | `hashTypedData` | `hashTypedData({domain, types, primaryType, message})` in `accounts.dart`, plus `hashTypedDataDomain`, `hashTypedDataStruct` | `5. EIP-712 hashTypedData` (CoW order and Safe transaction, each compared with an independent Solidity implementation); `test/accounts/sign_typed_data_test.dart` (EIP-712 reference vectors) |
| 6 | keccak256, address, hex, BigInt | `keccak256`, `getAddress`, `isAddress`, `isAddressEqual`, `bytesToHex`, `hexToBytes`, `numberToHex`, `hexToBigInt` | `keccak256`, `keccak256String`, `getAddress`, `isAddress`, `isAddressEqual`, `bytesToHex`, `hexToBytes`, `bigIntToHex`, `hexToBigInt`, `padHex` in `utils.dart` | `6. keccak256, address checksum and normalisation, hex and BigInt` |
| 7 | Logs over a block range | `getLogs`, `getContractEvents` | `PublicClient.getLogs({address, topics, fromBlockNumber, toBlockNumber})`, `getContractEvents` | `7. getLogs with a block range` |
| 8 | Multicall | `multicall`, `batch.multicall` | `PublicClient.multicall({calls, multicallAddress})`; client option `multicallBatch: MulticallBatchConfig` folds concurrent `readContract` calls | `8. multicall aggregation` |
| 9 | Block number and block-tagged reads | `getBlockNumber`, `getBlock`, `getBalance` with `blockNumber` | `getBlockNumber`, `getBlock`, `getBalance` | `9. getBlockNumber and block-tagged reads` |
| 10 | HTTP transport on the caller's URL | `http(url)` | `HttpTransport(Uri url, {client, batch})`; `url` is required | `10. HTTP transport` |
| F | Revert surfaced with its data | `ContractFunctionRevertedError` | direct call: `RpcError.data` holds the revert data; auto-batched `readContract`: `ContractFunctionRevertedError.data`; decode with `decodeErrorResult` | `failure path` |

### Transport rules

- `HttpTransport` has no default URL: `url` is a required positional
  parameter. The same holds for `WebSocketTransport` and `IpcTransport`.
- Constructing a transport or a client makes no call (test `makes no call at
  construction`).
- No global state between clients: the request id counter is per `RpcClient`
  (test `keeps no global state`). The one module-level object is an
  `Expando` keyed by client instance, which holds a client's own multicall
  queue.
- viem_dart reads no environment variable and no file in `lib/` (apart from
  the Unix socket of `IpcTransport`, which an SDK on HTTP does not use).
- Two things in viem_dart carry hostnames that an SDK with its own endpoints must not reach for:
  the `rpcUrls` of the chain definitions in `chains.dart` (data only; no
  transport reads them) and the default IPFS and Arweave gateways of
  `getEnsAvatar`. Neither is called unless the integrator calls it.

## Types

| viem / TypeScript | viem_dart | Note |
| --- | --- | --- |
| `Address` | `String` (`0x` + 40 hex digits) | `getAddress` applies the EIP-55 checksum; `isAddressEqual` compares ignoring case and throws `FormatException` on a malformed address. `isAddress` checks the shape only, like viem's `isAddress(x, { strict: false })` |
| `Hex` | `String` (`0x…`) | for hashes, calldata and return data of `call` |
| `bigint` | `BigInt` | |
| `number` (small ints, `uint8` … `uint32`) | `int` or `BigInt` as an argument; always `BigInt` as a decoded result | every `uintN` / `intN` decodes to `BigInt`; call `.toInt()` for a small value |
| `bytes`, `bytesN` as ABI arguments and results | `Uint8List` | `bytes32` values passed to `hashTypedData` and `encodeFunctionData` must be `Uint8List`, not hex strings |
| a 32-byte hash returned by a util (`hashTypedData`, `keccak256`) | `Uint8List` | `bytesToHex` for the hex form; `keccak256String` and `keccak256Hex` return hex |
| `readContract({ abi, functionName, args })` | `readContract(abi: AbiFunction, args: [...])` | the function is passed as an `AbiFunction` (`parseAbiItem`), or use `getContract(...).read('name', args)` |
| `publicClient.action(...)` | `publicClient.action(...)` | actions are extension methods on `PublicClient` |
| `Promise<T>` | `Future<T>` | |

## Name differences

| viem | viem_dart |
| --- | --- |
| `createPublicClient({ transport: http(url) })` | `createPublicClient(transport: HttpTransport(Uri.parse(url)))` |
| `numberToHex`, `toHex` | `bigIntToHex`, `intToHex`, `stringToHex`, `boolToHex` |
| `hexToNumber`, `hexToBigInt` | `hexToInt`, `hexToBigInt` |
| `fromBlock`, `toBlock` (bigint or tag) | `fromBlockNumber` / `fromBlockTag`, `toBlockNumber` / `toBlockTag` |
| `blockNumber`, `blockTag` | `blockNumber`, `blockTag` |
| `stateOverride: [{ address, balance, nonce, code, state, stateDiff }]` | `stateOverride: [AccountStateOverride(address:, balance:, nonce:, code:, state:, stateDiff:)]` with `state` / `stateDiff` as `Map<String, String>` |
| `StateAssignmentConflictError`, `AccountStateConflictError` | same names |

## Gaps

| Gap | Status |
| --- | --- |
| `verifyHash` with ERC-1271 | implemented: `PublicClient.verifyHash({address, hash, signature, blockNumber, blockTag})`; tests in `verify_hash_anvil_test.dart`, `verify_hash_actions_test.dart` |
| ERC-6492 for undeployed accounts | implemented: `verifyHash` accepts a wrapped signature (`abi.encode(factory, factoryCalldata, signature) ++ erc6492MagicSuffix`); tests in `verify_hash_anvil_test.dart` |
| `verifyHash` against a real Safe v1.5.0 with CoW's ExtensibleFallbackHandler | proven, deployed and counterfactual (ERC-6492), including a domain verifier; needs no change to `verifyHash`. A Safe's owners sign the EIP-712 `SafeMessage` digest of the hash (not the hash), and a domain-verifier signature is `safeSignature(bytes32,bytes32,bytes,bytes)`-encoded; both go in as the `signature` bytes. The test runs against the real Safe, factory and handler deployments on Base through an anvil fork pinned to one block (`test/integration/fixtures/safe/README.md`; no Safe or CoW code is kept in the repository); test in `verify_hash_safe_anvil_test.dart` |
| `verifySiweMessage` with contract signatures | implemented: `PublicClient.verifySiweMessage(message, {signature, ...})` (siwe.dart); the top-level `verifySiweMessage` stays EOA-only and needs no node; tests in `siwe_contract_account_anvil_test.dart` |
| State overrides | implemented |
| Generated typed contracts are not run against a node | fixed: `viem_dart_builders/test/integration/generated_contract_anvil_test.dart` generates `ProbeContract`/`ProbeWalletContract` from the Probe ABI with the real generator and runs a typed read, write, event getter and revert against anvil |
| A revert inside an auto-batched `readContract` (`multicallBatch`) threw `ContractFunctionRevertedError` without the revert data (a direct call keeps it in `RpcError.data`, `multicall` with `allowFailure: true` in `returnData`) | fixed: the error now has `data` and the `Error(string)` `reason` |
