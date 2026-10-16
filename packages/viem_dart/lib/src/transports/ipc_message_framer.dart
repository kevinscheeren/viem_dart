/// Splits a stream of raw text chunks from a delimiter-less JSON-RPC IPC
/// socket (geth/anvil's IPC endpoint writes back-to-back JSON objects with
/// no separator) into complete JSON message strings, by tracking brace
/// nesting depth outside of JSON string literals.
class IpcMessageFramer {
  final StringBuffer _buffer = StringBuffer();
  int _depth = 0;
  bool _inString = false;
  bool _escaped = false;

  /// Feeds [chunk] in and returns zero or more complete JSON message strings
  /// found within it (a chunk may contain none, one, or several messages).
  List<String> feed(String chunk) {
    final messages = <String>[];
    for (var i = 0; i < chunk.length; i++) {
      final char = chunk[i];
      _buffer.write(char);

      if (_escaped) {
        _escaped = false;
        continue;
      }
      if (_inString) {
        if (char == r'\') {
          _escaped = true;
        } else if (char == '"') {
          _inString = false;
        }
        continue;
      }
      if (char == '"') {
        _inString = true;
      } else if (char == '{') {
        _depth++;
      } else if (char == '}') {
        _depth--;
        if (_depth == 0) {
          messages.add(_buffer.toString());
          _buffer.clear();
        }
      }
    }
    return messages;
  }
}
