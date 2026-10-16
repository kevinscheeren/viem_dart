import 'package:freezed_annotation/freezed_annotation.dart';

import 'converters.dart';

part 'block.freezed.dart';
part 'block.g.dart';

/// A block, as returned by `eth_getBlockByNumber`/`eth_getBlockByHash`
/// (requested without full transaction objects — `transactions` is a list
/// of hashes).
@freezed
abstract class Block with _$Block {
  /// Creates a [Block] from its raw fields.
  const factory Block({
    @HexBigIntNConverter() BigInt? number,
    String? hash,
    required String parentHash,
    String? nonce,
    required String sha3Uncles,
    String? logsBloom,
    required String transactionsRoot,
    required String stateRoot,
    required String receiptsRoot,
    required String miner,
    @HexBigIntConverter() required BigInt difficulty,
    @HexBigIntNConverter() BigInt? totalDifficulty,
    required String extraData,
    @HexBigIntConverter() required BigInt size,
    @HexBigIntConverter() required BigInt gasLimit,
    @HexBigIntConverter() required BigInt gasUsed,
    @HexBigIntConverter() required BigInt timestamp,
    required List<String> transactions,
    required List<String> uncles,
    @HexBigIntNConverter() BigInt? baseFeePerGas,
    String? mixHash,
    String? withdrawalsRoot,
    @HexBigIntNConverter() BigInt? blobGasUsed,
    @HexBigIntNConverter() BigInt? excessBlobGasUsed,
  }) = _Block;

  /// Parses a `eth_getBlockBy*` JSON-RPC result.
  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
}
