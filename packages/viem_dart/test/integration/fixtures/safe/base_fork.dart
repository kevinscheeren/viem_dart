/// The real Base (chain 8453) deployments the Safe tests fork, and the block
/// they are pinned to. No Safe or CoW code is kept in this repository: the
/// tests run against the contracts as deployed (see README.md).
library;

import 'dart:io';

/// The keyless public Base endpoint. Override with `BASE_FORK_URL`, for
/// example with a provider endpoint when the public one rate-limits you.
const String defaultBaseForkUrl = 'https://mainnet.base.org';

/// The fork endpoint: `BASE_FORK_URL` if set, else [defaultBaseForkUrl].
String baseForkUrl() {
  final fromEnv = Platform.environment['BASE_FORK_URL'];
  return fromEnv == null || fromEnv.isEmpty ? defaultBaseForkUrl : fromEnv;
}

/// The one block every Safe test forks. Pinned so the tests do not move with
/// the chain; bump it deliberately, together with the code hashes below.
const int baseForkBlockNumber = 52000000;

/// Base's chain id, which a fork keeps (Safe's EIP-712 domain uses it).
const int baseChainId = 8453;

/// Safe v1.5.0 `Safe` (L1 singleton).
const String safeSingleton = '0xFf51A5898e281Db6DfC7855790607438dF2ca44b';

/// Safe v1.5.0 `SafeProxyFactory`.
const String safeProxyFactory = '0x14F2982D601c9458F93bd70B218933A6f8165e7b';

/// CoW's `ExtensibleFallbackHandler`, the one composable-cow lists for Base.
const String cowExtensibleFallbackHandler =
    '0x2f55e8b20D0B9FEFA187AA7d00B6Cbe563605bF5';

/// keccak256 of each contract's runtime code at [baseForkBlockNumber]. The
/// test compares them with what the fork serves, so a fork that does not hold
/// the production code fails loudly.
const Map<String, String> baseForkCodeHashes = {
  safeSingleton:
      '0xdda019cbd7c867a533a2a86e5c53434fdc50b13122b5a5ddb4a8df61b31c20f2',
  safeProxyFactory:
      '0x967dae4cda22b0c9ef7f31b010bdc1ceb0af9904b0c3dc060b5302e4c18a4529',
  cowExtensibleFallbackHandler:
      '0x9224645d719465e57e9cc0ba42a6549359a056ca40c01abeef3aff3c0ba52796',
};
