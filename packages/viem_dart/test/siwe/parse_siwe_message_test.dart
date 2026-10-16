import 'package:test/test.dart';
import 'package:viem_dart/siwe.dart';

void main() {
  // Same EIP-4361 spec example used in create_siwe_message_test.dart.
  const specMessage = '''
example.com wants you to sign in with your Ethereum account:
0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2

I accept the ExampleOrg Terms of Service: https://example.com/tos

URI: https://example.com/login
Version: 1
Chain ID: 1
Nonce: 32891756
Issued At: 2021-09-30T16:25:24.000Z
Resources:
- ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/
- https://example.com/my-web2-claim.json''';

  group('parseSiweMessage', () {
    test('extracts every field from the EIP-4361 spec example', () {
      final parsed = parseSiweMessage(specMessage);
      expect(parsed.address, '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2');
      expect(parsed.domain, 'example.com');
      expect(parsed.scheme, isNull);
      expect(
        parsed.statement,
        'I accept the ExampleOrg Terms of Service: https://example.com/tos',
      );
      expect(parsed.uri, 'https://example.com/login');
      expect(parsed.version, '1');
      expect(parsed.chainId, 1);
      expect(parsed.nonce, '32891756');
      expect(parsed.issuedAt, DateTime.parse('2021-09-30T16:25:24Z'));
      expect(parsed.expirationTime, isNull);
      expect(parsed.notBefore, isNull);
      expect(parsed.requestId, isNull);
      expect(parsed.resources, [
        'ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/',
        'https://example.com/my-web2-claim.json',
      ]);
    });

    test('extracts an explicit scheme', () {
      final parsed = parseSiweMessage('https://$specMessage');
      expect(parsed.scheme, 'https');
      expect(parsed.domain, 'example.com');
    });

    test('extracts optional Expiration Time/Not Before/Request ID', () {
      const message = '''
example.com wants you to sign in with your Ethereum account:
0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2

URI: https://example.com/login
Version: 1
Chain ID: 1
Nonce: 32891756
Issued At: 2021-09-30T16:25:24.000Z
Expiration Time: 2021-10-01T16:25:24.000Z
Not Before: 2021-09-30T16:00:00.000Z
Request ID: request-1234''';
      final parsed = parseSiweMessage(message);
      expect(parsed.expirationTime, DateTime.parse('2021-10-01T16:25:24Z'));
      expect(parsed.notBefore, DateTime.parse('2021-09-30T16:00:00Z'));
      expect(parsed.requestId, 'request-1234');
    });

    test('is lenient: garbage input yields an all-null SiweMessage '
        'instead of throwing', () {
      final parsed = parseSiweMessage('not a siwe message at all');
      expect(parsed.address, isNull);
      expect(parsed.domain, isNull);
      expect(parsed.uri, isNull);
      expect(parsed.nonce, isNull);
    });

    test('round-trips through createSiweMessage', () {
      final created = createSiweMessage(
        address: '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        chainId: 42161,
        domain: 'app.example',
        nonce: 'abcd1234efgh',
        uri: 'https://app.example/session',
        issuedAt: DateTime.utc(2024, 6, 1, 12),
        statement: 'Sign in to Example App.',
      );
      final parsed = parseSiweMessage(created);
      expect(parsed.address, '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359');
      expect(parsed.chainId, 42161);
      expect(parsed.domain, 'app.example');
      expect(parsed.nonce, 'abcd1234efgh');
      expect(parsed.uri, 'https://app.example/session');
      expect(parsed.statement, 'Sign in to Example App.');
      expect(parsed.issuedAt, DateTime.utc(2024, 6, 1, 12));
    });
  });
}
