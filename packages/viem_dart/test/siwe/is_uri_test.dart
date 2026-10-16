import 'package:test/test.dart';
import 'package:viem_dart/siwe.dart';

void main() {
  group('isUri', () {
    test('accepts valid RFC 3986 URIs', () {
      expect(isUri('https://example.com/path'), isTrue);
      expect(isUri('https://example.com'), isTrue);
      expect(
        isUri('ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3'),
        isTrue,
      );
      expect(isUri('urn:isbn:0451450523'), isTrue);
      expect(isUri('mailto:foo@example.com'), isTrue);
    });

    test('rejects strings with no scheme', () {
      expect(isUri('not a uri'), isFalse);
      expect(isUri('example.com/path'), isFalse);
    });

    test('rejects a scheme not starting with a letter', () {
      expect(isUri('1http://example.com'), isFalse);
    });

    test('rejects illegal characters', () {
      expect(isUri('https://example.com/path with spaces'), isFalse);
    });

    test('rejects a percent-escape not followed by hex digits', () {
      expect(isUri('https://example.com/%zz'), isFalse);
      expect(isUri('https://example.com/%z'), isFalse);
    });

    test('accepts a scheme+opaque-path URI with no authority', () {
      expect(isUri('mailto:foo@example.com'), isTrue);
    });
  });
}
