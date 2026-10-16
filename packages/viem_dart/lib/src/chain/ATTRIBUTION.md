# Attribution

The chain definitions in `chains.dart` (715 chains, generated 2026-08-04) were
mechanically ported from [viem](https://github.com/wevm/viem)'s own chain
definitions, licensed under the MIT License:

- Source: `src/chains/definitions/` in the `wevm/viem` repository
  (https://github.com/wevm/viem/tree/main/src/chains/definitions), including
  the `skale/` subdirectory.
- viem is Copyright (c) the viem contributors, MIT License:
  https://github.com/wevm/viem/blob/main/LICENSE. The full licence text is in
  `THIRD_PARTY_NOTICES.md` at the repository root.

## What was ported

For each `export const <name> = defineChain({ ... })` in viem's source, the
following fields were mechanically extracted:

- `id` -> `Chain.id`
- the exported identifier -> the Dart variable name
- `name` -> `Chain.name`
- `nativeCurrency` -> `Chain.nativeCurrency`
- `rpcUrls.default.http` -> `Chain.rpcUrls` (only the `default` entry's HTTP
  URLs; `webSocket` URLs and any non-`default` keys such as `alchemy` or
  `infura` were ignored, since this package's `Chain` model has a single flat
  list)
- `blockExplorers.default` -> `Chain.blockExplorer` (only `name` and `url`;
  `apiUrl` and any non-`default` explorers were ignored)
- `contracts` entries matching the simple `{ address: '0x...', blockCreated:
  N }` shape (or the `blockDeployed` alt key) -> `Chain.contracts`, keyed by
  their original name (e.g. `multicall3`, `ensUniversalResolver`,
  `erc6492Verifier`, `universalSignatureVerifier`, etc.)

## What was intentionally not ported

This package's `Chain`/`NativeCurrency`/`BlockExplorer`/`ChainContract`
models don't have fields for viem's richer per-chain data, so the following
were dropped entirely during extraction: `blockTime`, `testnet`,
`formatters`, `serializers`, `fees`, `sourceId`, `custom`.

Additionally, some `contracts` entries in viem's source don't fit the simple
`{ address, blockCreated }` shape — most commonly OP Stack chains'
`disputeGameFactory`, `l2OutputOracle`, `portal`, and `l1StandardBridge`
entries, which are keyed by a per-chain source id
(`{ [sourceId]: { address: ... } }`) rather than a direct address. These were
skipped rather than guessed at (171 such entries across all chains). Spread
expressions that pull in shared contract sets from another module (e.g.
`...chainConfig.contracts` for OP Stack chains) were also not resolved or
inlined, since doing so would require pulling in viem's op-stack config
module rather than mechanically reading a single chain-definition file.

Three chain-definition files each contain a second export that derives a
variant chain by spreading an already-defined chain object rather than
declaring its own `id`/`name`/`nativeCurrency` (`basePreconf`,
`baseSepoliaPreconf`, `giwaSepoliaPreconf`) — these were skipped since they
don't carry the required fields directly.

## Regenerating

To refresh this file against a newer viem release, re-fetch
`src/chains/definitions/*.ts` (and `src/chains/definitions/skale/*.ts`) from
`https://raw.githubusercontent.com/wevm/viem/main/src/chains/definitions/`,
re-run the same field extraction described above, and re-run `dart format`.
