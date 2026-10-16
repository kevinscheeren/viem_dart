import '../utils/hex.dart';

/// Resolves the JSON-RPC block parameter: a specific [blockNumber] if given,
/// otherwise the [blockTag] (`"latest"`, `"earliest"`, `"pending"`,
/// `"safe"`, or `"finalized"`).
String resolveBlockParam({BigInt? blockNumber, String blockTag = 'latest'}) =>
    blockNumber != null ? bigIntToHex(blockNumber) : blockTag;
