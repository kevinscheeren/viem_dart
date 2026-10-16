import 'dart:typed_data';

import '../../abi/abi_item.dart';
import '../../abi/abi_parameter.dart';
import '../../abi/decode_parameters.dart';
import '../../abi/encode_parameters.dart';
import '../../abi/function_data.dart';
import '../../abi/human_readable/parse_abi.dart';
import '../../client/client.dart';
import '../../crypto/secp256k1.dart' as secp256k1;
import '../../crypto/signature.dart';
import '../../errors/rpc_error.dart';
import '../../utils/address.dart';
import '../../utils/hex.dart';
import '../block_param.dart';
import 'erc6492_validator_bytecode.dart';
import 'state_actions.dart'; // for PublicClient.call()

/// The ERC-1271 magic value, `bytes4(keccak256("isValidSignature(bytes32,bytes)"))`.
const String erc1271MagicValue = '0x1626ba7e';

/// The suffix of an ERC-6492 signature.
const String erc6492MagicSuffix =
    '0x6492649264926492649264926492649264926492649264926492649264926492';

final AbiFunction _isValidSignature =
    parseAbiItem(
          'function isValidSignature(bytes32 hash, bytes signature) '
          'view returns (bytes4)',
        )
        as AbiFunction;

/// The ERC-6492 wrapper: `abi.encode(factory, factoryCalldata, signature)`.
const List<AbiParameter> _wrapperParams = [
  AbiParameter(name: 'factory', type: 'address'),
  AbiParameter(name: 'factoryCalldata', type: 'bytes'),
  AbiParameter(name: 'signature', type: 'bytes'),
];

/// The constructor of the validator in `erc6492_validator_bytecode.dart`.
const List<AbiParameter> _validatorParams = [
  AbiParameter(name: 'signer', type: 'address'),
  AbiParameter(name: 'hash', type: 'bytes32'),
  ..._wrapperParams,
];

/// Signature verification for any kind of account, available on every
/// [PublicClient]. Mirrors viem's `verifyHash`.
extension VerifyHashActions on PublicClient {
  /// Whether [signature] is a valid signature of [hash] by [address].
  ///
  /// - An externally owned account: [signature] must be a 65-byte ECDSA
  ///   signature (`r || s || v`, `v` being 0/1 or 27/28) whose recovered
  ///   address is [address]. This needs no RPC call.
  /// - A contract account (ERC-1271): the contract at [address] is asked via
  ///   `isValidSignature(bytes32,bytes)` (an `eth_call` at
  ///   [blockNumber]/[blockTag]), and the signature is valid when it returns
  ///   the magic value [erc1271MagicValue]. [signature] can be any bytes the
  ///   contract understands, such as a multi-signature blob.
  ///
  /// - A contract account that isn't deployed yet (ERC-6492): a [signature]
  ///   wrapped as `abi.encode(factory, factoryCalldata, signature) ++
  ///   [erc6492MagicSuffix]` is verified by simulating the deployment, in one
  ///   `eth_call` that runs a validator contract's constructor (no contract is
  ///   deployed and nothing is committed): if [address] has no code, `factory`
  ///   is called with `factoryCalldata`, then `isValidSignature` is called as
  ///   above with the unwrapped signature. If [address] already has code the
  ///   factory isn't called. An unwrapped signature from an undeployed
  ///   account is `false`. The factory call is chosen by the signer, so only
  ///   verify a wrapped signature through a node you are willing to let run
  ///   it (it is bounded by the node's `eth_call` gas cap).
  ///
  /// Returns `false` (never throws) for a signature that doesn't verify: a
  /// wrong hash or signer, a tampered or malformed signature, an address
  /// with no code, a malformed ERC-6492 wrapper, a factory call that fails,
  /// and a contract that reverts, halts or returns anything other than the
  /// magic value. Transport and node errors that are not a
  /// call failure (rate limits, an unreachable node, an unsupported method)
  /// are rethrown, so that a flaky node can't be mistaken for an invalid
  /// signature.
  ///
  /// [hash] is the 32-byte digest that was signed, as a hex `String` or
  /// [Uint8List]. [signature] is a hex `String`, [Uint8List] or a
  /// [Signature]. Anything else, a [hash] that isn't 32 bytes or an [address]
  /// that isn't an address throws an [ArgumentError], and malformed hex a
  /// [FormatException].
  ///
  /// Not covered: the legacy `isValidSignature(bytes,bytes)` overload.
  ///
  /// See https://eips.ethereum.org/EIPS/eip-1271 and
  /// https://eips.ethereum.org/EIPS/eip-6492
  Future<bool> verifyHash({
    required String address,
    required Object hash,
    required Object signature,
    BigInt? blockNumber,
    String blockTag = 'latest',
  }) async {
    if (!isAddress(address)) {
      throw ArgumentError.value(address, 'address', 'is not an address');
    }
    final hashBytes = _toBytes(hash, 'hash');
    if (hashBytes.length != 32) {
      throw ArgumentError.value(
        hash,
        'hash',
        'must be 32 bytes, got ${hashBytes.length}',
      );
    }
    final signatureBytes = _signatureToBytes(signature);

    // An EOA signature, checked locally. A match can't be a contract's
    // forgery (nobody holds a contract address's key), so it also holds for
    // an address that has code, such as an EIP-7702 delegated account.
    if (_isSignedBy(address, hashBytes, signatureBytes)) return true;

    try {
      if (!_hasErc6492Suffix(signatureBytes)) {
        final result = await call(
          to: address,
          data: bytesToHex(
            encodeFunctionData(_isValidSignature, [hashBytes, signatureBytes]),
          ),
          blockNumber: blockNumber,
          blockTag: blockTag,
        );
        // `bytes4` is returned left-aligned in a 32-byte word. An address
        // with no code answers `0x`, which is `false` here.
        final returned = hexToBytes(result);
        return returned.length >= 32 &&
            bytesToHex(Uint8List.sublistView(returned, 0, 4)) ==
                erc1271MagicValue;
      }

      final wrapper = _decodeErc6492Wrapper(signatureBytes);
      if (wrapper == null) return false;
      // A deployless call: no `to`, the validator's creation code followed by
      // its constructor arguments is the call data.
      final result = await rpc.request('eth_call', [
        {
          'data': bytesToHex(
            Uint8List.fromList([
              ...hexToBytes(erc6492ValidatorBytecode),
              ...encodeAbiParameters(_validatorParams, [
                address,
                hashBytes,
                wrapper.factory,
                wrapper.factoryCalldata,
                wrapper.signature,
              ]),
            ]),
          ),
        },
        resolveBlockParam(blockNumber: blockNumber, blockTag: blockTag),
      ]);
      // The validator returns one word: 1 for a valid signature.
      final returned = hexToBytes(result! as String);
      return returned.length == 32 &&
          hexToBigInt(bytesToHex(returned)) == BigInt.one;
    } on RpcError catch (error) {
      if (_isCallFailure(error)) return false;
      rethrow;
    }
  }
}

typedef _Erc6492Wrapper = ({
  String factory,
  Uint8List factoryCalldata,
  Uint8List signature,
});

bool _hasErc6492Suffix(Uint8List signature) =>
    signature.length >= 32 &&
    bytesToHex(Uint8List.sublistView(signature, signature.length - 32)) ==
        erc6492MagicSuffix;

/// The parts of an ERC-6492 signature, or `null` if the bytes before the
/// magic suffix aren't `abi.encode(factory, factoryCalldata, signature)`.
_Erc6492Wrapper? _decodeErc6492Wrapper(Uint8List signature) {
  try {
    final decoded = decodeAbiParameters(
      _wrapperParams,
      Uint8List.sublistView(signature, 0, signature.length - 32),
    );
    return (
      factory: decoded[0]! as String,
      factoryCalldata: decoded[1]! as Uint8List,
      signature: decoded[2]! as Uint8List,
    );
  } on Object {
    // The bytes are the caller's input, and the decoder reports a bad offset
    // or length in several ways (a `RangeError`, an `AbiError`, ...).
    return null;
  }
}

Uint8List _toBytes(Object value, String name) {
  if (value is Uint8List) return value;
  if (value is String) return hexToBytes(value);
  throw ArgumentError.value(value, name, 'must be a hex String or a Uint8List');
}

Uint8List _signatureToBytes(Object signature) {
  if (signature is Signature) return hexToBytes(signatureToHex(signature));
  return _toBytes(signature, 'signature');
}

bool _isSignedBy(String address, Uint8List hash, Uint8List signature) {
  if (signature.length != 65) return false;
  try {
    final recovered = secp256k1.recoverAddress(
      hash,
      hexToSignature(bytesToHex(signature)),
    );
    return recovered.toLowerCase() == address.toLowerCase();
  } on FormatException {
    // An invalid `v`, or no public key for these `r`/`s`.
    return false;
  }
}

/// Whether [error] is the node reporting that the called contract reverted
/// or halted, rather than a failure of the request itself. Nodes disagree on
/// the code (anvil and geth use `3`, geth also `-32015`) and word it
/// differently, so the message is checked too.
bool _isCallFailure(RpcError error) =>
    error.code == 3 ||
    error.code == -32015 ||
    RegExp(
      r'revert|vm execution error|evm error|out of gas|invalid opcode',
      caseSensitive: false,
    ).hasMatch(error.shortMessage);
