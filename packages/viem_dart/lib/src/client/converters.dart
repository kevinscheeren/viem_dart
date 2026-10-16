import 'package:json_annotation/json_annotation.dart';

import '../utils/hex.dart';

/// Converts a hex-quantity JSON-RPC field (e.g. `"0x1a2b"`) to/from [BigInt].
class HexBigIntConverter implements JsonConverter<BigInt, String> {
  const HexBigIntConverter();

  @override
  BigInt fromJson(String json) => hexToBigInt(json);

  @override
  String toJson(BigInt object) => bigIntToHex(object);
}

/// Nullable variant of [HexBigIntConverter].
class HexBigIntNConverter implements JsonConverter<BigInt?, String?> {
  const HexBigIntNConverter();

  @override
  BigInt? fromJson(String? json) => json == null ? null : hexToBigInt(json);

  @override
  String? toJson(BigInt? object) => object == null ? null : bigIntToHex(object);
}

/// Converts a hex-quantity JSON-RPC field to/from [int].
class HexIntConverter implements JsonConverter<int, String> {
  const HexIntConverter();

  @override
  int fromJson(String json) => hexToInt(json);

  @override
  String toJson(int object) => intToHex(object);
}

/// Nullable variant of [HexIntConverter].
class HexIntNConverter implements JsonConverter<int?, String?> {
  const HexIntNConverter();

  @override
  int? fromJson(String? json) => json == null ? null : hexToInt(json);

  @override
  String? toJson(int? object) => object == null ? null : intToHex(object);
}

/// Converts a JSON array of hex-quantity strings to/from `List<BigInt>`
/// (e.g. `eth_feeHistory`'s `baseFeePerGas`).
class HexBigIntListConverter
    implements JsonConverter<List<BigInt>, List<Object?>> {
  const HexBigIntListConverter();

  @override
  List<BigInt> fromJson(List<Object?> json) =>
      json.map((e) => hexToBigInt(e as String)).toList();

  @override
  List<Object?> toJson(List<BigInt> object) => object.map(bigIntToHex).toList();
}
