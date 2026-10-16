# Safe v1.5.0 and CoW ExtensibleFallbackHandler: a Base fork

Fixtures for `../../verify_hash_safe_anvil_test.dart`. The Safe
contracts are LGPL-3.0, so **no Safe or CoW bytecode or source is kept in this
repository**. The tests run against the real deployments on Base (chain 8453)
through an anvil fork, and deploy only our own helper contracts on top.

| Contract | Address on Base |
| --- | --- |
| Safe v1.5.0 `Safe` (L1 singleton) | `0xFf51A5898e281Db6DfC7855790607438dF2ca44b` |
| Safe v1.5.0 `SafeProxyFactory` | `0x14F2982D601c9458F93bd70B218933A6f8165e7b` |
| CoW `ExtensibleFallbackHandler` (the one composable-cow lists for Base) | `0x2f55e8b20D0B9FEFA187AA7d00B6Cbe563605bF5` |

`base_fork.dart` holds the addresses, the pinned fork block and the keccak256
of each contract's runtime code at that block. The test forks
`anvil --fork-url <url> --fork-block-number 52000000` (the test harness's
`AnvilHarness.start(forkUrl:, forkBlockNumber:)`) and first checks that the
fork serves exactly those code hashes, so "the same code as production" is
checked, not asserted.

- **Endpoint.** `https://mainnet.base.org`, a keyless public endpoint, by
  default; set `BASE_FORK_URL` to use another one. CI sets it in the anvil
  job. The public endpoint rate-limits, so the harness starts anvil with a low
  request budget and retries; anvil caches what it fetched, so a rerun at the
  same block is quick.
- **Moving the pin.** Change `baseForkBlockNumber` and the three code hashes
  together; the first test fails if they disagree. The endpoint must serve
  state at that block.
- **Our own contracts.** `SafeSetupHelper` and `EcdsaDomainVerifier` are
  original code in `../SafeTestHelpers.sol`, built by `../build_safe_helpers.sh`
  into `../safe_test_helpers.dart`.
