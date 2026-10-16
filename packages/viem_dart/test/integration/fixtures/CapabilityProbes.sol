// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Test-only contracts for test/integration/sdk_capabilities_test.dart.
// Regenerate capability_probes.dart from this file with
// `sh test/integration/fixtures/build_probes.sh` (needs Foundry's forge).

/// Reads, events, reverts and block-tagged state.
contract Probe {
    event Pinged(address indexed who, uint256 value);
    error Nope(uint256 code);

    uint256 public stored;

    function ping(uint256 v) external {
        stored = v;
        emit Pinged(msg.sender, v);
    }

    function getStored() external view returns (uint256) {
        return stored;
    }

    function failWithReason() external pure {
        revert("boom");
    }

    function failWithCustom() external pure {
        revert Nope(42);
    }
}

/// The aggregate3 of Multicall3 (same ABI and semantics), because a plain
/// anvil has no Multicall3 deployed.
contract Aggregate3 {
    struct Call3 {
        address target;
        bool allowFailure;
        bytes callData;
    }

    struct Result {
        bool success;
        bytes returnData;
    }

    function aggregate3(Call3[] calldata calls) external payable returns (Result[] memory returnData) {
        returnData = new Result[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory ret) = calls[i].target.call(calls[i].callData);
            if (!success && !calls[i].allowFailure) {
                assembly {
                    revert(add(ret, 0x20), mload(ret))
                }
            }
            returnData[i] = Result(success, ret);
        }
    }
}

/// An independent Solidity implementation of the two EIP-712 digests the
/// SDK signs or compares, for differential tests against hashTypedData.
contract Eip712Oracle {
    struct Order {
        address sellToken;
        address buyToken;
        address receiver;
        uint256 sellAmount;
        uint256 buyAmount;
        uint32 validTo;
        bytes32 appData;
        uint256 feeAmount;
        string kind;
        bool partiallyFillable;
        string sellTokenBalance;
        string buyTokenBalance;
    }

    struct SafeTx {
        address to;
        uint256 value;
        bytes data;
        uint8 operation;
        uint256 safeTxGas;
        uint256 baseGas;
        uint256 gasPrice;
        address gasToken;
        address refundReceiver;
        uint256 nonce;
    }

    bytes32 constant ORDER_TYPEHASH = keccak256(
        "Order(address sellToken,address buyToken,address receiver,uint256 sellAmount,uint256 buyAmount,uint32 validTo,bytes32 appData,uint256 feeAmount,string kind,bool partiallyFillable,string sellTokenBalance,string buyTokenBalance)"
    );
    bytes32 constant SAFE_TX_TYPEHASH = keccak256(
        "SafeTx(address to,uint256 value,bytes data,uint8 operation,uint256 safeTxGas,uint256 baseGas,uint256 gasPrice,address gasToken,address refundReceiver,uint256 nonce)"
    );

    function gpv2Digest(Order calldata o, uint256 chainId, address settlement) external pure returns (bytes32) {
        bytes32 domain = keccak256(
            abi.encode(
                keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                keccak256("Gnosis Protocol"),
                keccak256("v2"),
                chainId,
                settlement
            )
        );
        bytes32 structHash = keccak256(
            abi.encode(
                ORDER_TYPEHASH,
                o.sellToken,
                o.buyToken,
                o.receiver,
                o.sellAmount,
                o.buyAmount,
                o.validTo,
                o.appData,
                o.feeAmount,
                keccak256(bytes(o.kind)),
                o.partiallyFillable,
                keccak256(bytes(o.sellTokenBalance)),
                keccak256(bytes(o.buyTokenBalance))
            )
        );
        return keccak256(abi.encodePacked(bytes1(0x19), bytes1(0x01), domain, structHash));
    }

    function safeTxDigest(SafeTx calldata t, uint256 chainId, address safe) external pure returns (bytes32) {
        bytes32 domain = keccak256(
            abi.encode(keccak256("EIP712Domain(uint256 chainId,address verifyingContract)"), chainId, safe)
        );
        bytes32 structHash = keccak256(
            abi.encode(
                SAFE_TX_TYPEHASH,
                t.to,
                t.value,
                keccak256(t.data),
                t.operation,
                t.safeTxGas,
                t.baseGas,
                t.gasPrice,
                t.gasToken,
                t.refundReceiver,
                t.nonce
            )
        );
        return keccak256(abi.encodePacked(bytes1(0x19), bytes1(0x01), domain, structHash));
    }
}

/// A minimal ERC-1271 contract account: a signature is valid when it is a
/// 65-byte ECDSA signature (r || s || v) over the hash by `owner`.
contract Erc1271Wallet {
    address public immutable owner;

    constructor(address owner_) {
        owner = owner_;
    }

    function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4) {
        if (signature.length != 65) return 0xffffffff;
        address signer = ecrecover(hash, uint8(signature[64]), bytes32(signature[0:32]), bytes32(signature[32:64]));
        return signer != address(0) && signer == owner ? bytes4(0x1626ba7e) : bytes4(0xffffffff);
    }
}

/// An ERC-1271 contract that answers every signature with a wrong magic value.
contract Erc1271WrongMagic {
    function isValidSignature(bytes32, bytes calldata) external pure returns (bytes4) {
        return 0xdeadbeef;
    }
}

/// A contract that reverts on any call, such as one without ERC-1271 support.
contract Erc1271Reverting {
    function isValidSignature(bytes32, bytes calldata) external pure returns (bytes4) {
        revert("no 1271");
    }
}

/// Deploys an Erc1271Wallet with CREATE2, so the wallet's address is known
/// before it exists (a counterfactual account, ERC-6492).
contract Erc1271WalletFactory {
    function deploy(address owner, bytes32 salt) external returns (address) {
        return address(new Erc1271Wallet{salt: salt}(owner));
    }

    function walletAddress(address owner, bytes32 salt) external view returns (address) {
        bytes32 initCodeHash = keccak256(abi.encodePacked(type(Erc1271Wallet).creationCode, abi.encode(owner)));
        return address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xff), address(this), salt, initCodeHash)))));
    }
}
