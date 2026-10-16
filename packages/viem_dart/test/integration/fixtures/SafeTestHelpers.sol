// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Test-only contracts for test/integration/verify_hash_safe_anvil_test.dart.
// Written here, from the Safe and ExtensibleFallbackHandler ABIs only; the
// Safe and handler bytecode itself is a published artifact (safe/README.md).
// Regenerate safe_test_helpers.dart from this file with
// `sh test/integration/fixtures/build_safe_helpers.sh` (needs Foundry's forge).

/// Delegatecalled by `Safe.setup` (its `to`/`data` pair), so it runs in the
/// new Safe's context: the call to the Safe's own address goes through its
/// fallback handler with the Safe as `msg.sender`, which is what the
/// ExtensibleFallbackHandler's `onlySelf` `setDomainVerifier` requires.
contract SafeSetupHelper {
    function setDomainVerifier(bytes32 domainSeparator, address verifier) external {
        (bool ok, bytes memory ret) =
            address(this).call(abi.encodeWithSignature("setDomainVerifier(bytes32,address)", domainSeparator, verifier));
        if (!ok) {
            assembly {
                revert(add(ret, 32), mload(ret))
            }
        }
    }
}

/// A domain verifier (`ISafeSignatureVerifier`) that accepts a payload that
/// is a 65-byte ECDSA signature by `signer` over the EIP-712 digest. It
/// stands in for ComposableCoW, which is the domain verifier a CoW-enabled
/// Safe registers for the GPv2 domain.
contract EcdsaDomainVerifier {
    address public immutable signer;

    constructor(address signer_) {
        signer = signer_;
    }

    function isValidSafeSignature(
        address, // safe
        address, // sender
        bytes32 digest,
        bytes32, // domainSeparator
        bytes32, // typeHash
        bytes calldata, // encodeData
        bytes calldata payload
    ) external view returns (bytes4) {
        if (payload.length != 65) return 0xffffffff;
        bytes32 r = bytes32(payload[0:32]);
        bytes32 s = bytes32(payload[32:64]);
        uint8 v = uint8(payload[64]);
        return ecrecover(digest, v, r, s) == signer ? bytes4(0x1626ba7e) : bytes4(0xffffffff);
    }
}
