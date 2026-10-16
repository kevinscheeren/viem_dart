/// Base class for viem_dart's typed error hierarchy (mirrors viem's
/// `BaseError`). Domain-specific errors (ABI, RPC, transaction, account,
/// ENS, contract-call) extend this rather than throwing bare
/// [Exception]s, so callers can catch a specific failure mode or fall back
/// to catching [ViemError] generally.
class ViemError implements Exception {
  /// Creates a [ViemError] with the given [shortMessage] and optional
  /// [metaMessages]/[cause].
  const ViemError(
    this.shortMessage, {
    this.metaMessages = const [],
    this.cause,
  });

  /// A concise, human-readable summary of what went wrong.
  final String shortMessage;

  /// Additional context lines shown below [shortMessage] (e.g. the
  /// arguments that were passed, or a suggested fix).
  final List<String> metaMessages;

  /// The lower-level error that triggered this one, if any.
  final Object? cause;

  @override
  String toString() {
    final buffer = StringBuffer(shortMessage);
    for (final line in metaMessages) {
      buffer.write('\n$line');
    }
    if (cause != null) {
      buffer.write('\n\nCaused by: $cause');
    }
    return buffer.toString();
  }
}
