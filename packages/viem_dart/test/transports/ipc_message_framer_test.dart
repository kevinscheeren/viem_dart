import 'package:test/test.dart';
import 'package:viem_dart/src/transports/ipc_message_framer.dart';

void main() {
  group('IpcMessageFramer', () {
    test('frames a single complete message delivered in one chunk', () {
      final framer = IpcMessageFramer();
      final messages = framer.feed('{"id":1,"result":"0x1"}');
      expect(messages, ['{"id":1,"result":"0x1"}']);
    });

    test('frames back-to-back messages with no delimiter', () {
      final framer = IpcMessageFramer();
      final messages = framer.feed('{"id":1}{"id":2}');
      expect(messages, ['{"id":1}', '{"id":2}']);
    });

    test('frames a message split across multiple chunks', () {
      final framer = IpcMessageFramer();
      expect(framer.feed('{"id":1,"resu'), isEmpty);
      expect(framer.feed('lt":"0x1"}'), ['{"id":1,"result":"0x1"}']);
    });

    test('ignores braces inside JSON string values', () {
      final framer = IpcMessageFramer();
      final messages = framer.feed(
        r'{"id":1,"result":"{not a nested object}"}',
      );
      expect(messages, [r'{"id":1,"result":"{not a nested object}"}']);
    });

    test('handles escaped quotes inside strings without miscounting', () {
      final framer = IpcMessageFramer();
      final messages = framer.feed(r'{"id":1,"result":"a \" b { c"}');
      expect(messages, [r'{"id":1,"result":"a \" b { c"}']);
    });

    test('frames nested objects correctly', () {
      final framer = IpcMessageFramer();
      final messages = framer.feed('{"id":1,"result":{"a":1,"b":{"c":2}}}');
      expect(messages, ['{"id":1,"result":{"a":1,"b":{"c":2}}}']);
    });
  });
}
