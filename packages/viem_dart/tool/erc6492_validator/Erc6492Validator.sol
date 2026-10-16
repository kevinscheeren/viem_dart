// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Deployless validator for ERC-6492 signatures, written from the ERC-6492
// specification (https://eips.ethereum.org/EIPS/eip-6492). It is never
// deployed: verifyHash sends its creation code in an `eth_call` without a
// `to`, the constructor does the work and returns a single word, and
// nothing is committed.
//
// Regenerate lib/src/actions/public/erc6492_validator_bytecode.dart with
// `sh tool/erc6492_validator/build.sh` (needs Foundry's forge).

interface IERC1271 {
    function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4);
}

contract Erc6492Validator {
    /// The factory call that should have deployed `signer` failed.
    error FactoryCallFailed();

    /// Returns 1 if `signature` is a valid ERC-1271 signature of `hash` by
    /// `signer`, once `signer` has been deployed by calling `factory` with
    /// `factoryCalldata` if it has no code yet. Returns 0 otherwise.
    constructor(address signer, bytes32 hash, address factory, bytes memory factoryCalldata, bytes memory signature) {
        if (signer.code.length == 0) {
            (bool deployed,) = factory.call(factoryCalldata);
            if (!deployed) revert FactoryCallFailed();
        }

        bool valid;
        if (signer.code.length > 0) {
            try IERC1271(signer).isValidSignature(hash, signature) returns (bytes4 magic) {
                valid = magic == 0x1626ba7e;
            } catch {}
        }

        assembly {
            mstore(0, valid)
            return(0, 32)
        }
    }
}
