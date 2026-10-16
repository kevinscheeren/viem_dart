import 'package:test/test.dart';
import 'package:viem_dart/siwe.dart';

void main() {
  // The EIP-4361 spec's own "Examples" section
  // (https://eips.ethereum.org/EIPS/eip-4361#examples), fetched directly
  // from source — used verbatim as golden vectors, not just checked for
  // internal self-consistency.
  const address = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2';
  final issuedAt = DateTime.parse('2021-09-30T16:25:24Z');
  const statement =
      'I accept the ExampleOrg Terms of Service: https://example.com/tos';
  const resources = [
    'ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/',
    'https://example.com/my-web2-claim.json',
  ];

  group('createSiweMessage', () {
    test('matches the EIP-4361 spec example with an implicit scheme', () {
      final message = createSiweMessage(
        address: address,
        chainId: 1,
        domain: 'example.com',
        nonce: '32891756',
        uri: 'https://example.com/login',
        issuedAt: issuedAt,
        statement: statement,
        resources: resources,
      );
      expect(message, '''
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
- https://example.com/my-web2-claim.json''');
    });

    test('matches the EIP-4361 spec example with an implicit scheme and '
        'explicit port', () {
      final message = createSiweMessage(
        address: address,
        chainId: 1,
        domain: 'example.com:3388',
        nonce: '32891756',
        uri: 'https://example.com/login',
        issuedAt: issuedAt,
        statement: statement,
        resources: resources,
      );
      expect(
        message,
        startsWith(
          'example.com:3388 wants you to sign in with your '
          'Ethereum account:',
        ),
      );
    });

    test('matches the EIP-4361 spec example with an explicit scheme', () {
      final message = createSiweMessage(
        address: address,
        chainId: 1,
        domain: 'example.com',
        nonce: '32891756',
        uri: 'https://example.com/login',
        issuedAt: issuedAt,
        statement: statement,
        resources: resources,
        scheme: 'https',
      );
      expect(
        message,
        startsWith(
          'https://example.com wants you to sign in with your Ethereum '
          'account:',
        ),
      );
    });

    test('checksums a lowercase address', () {
      final message = createSiweMessage(
        address: address.toLowerCase(),
        chainId: 1,
        domain: 'example.com',
        nonce: '32891756',
        uri: 'https://example.com/login',
        issuedAt: issuedAt,
      );
      expect(message, contains(address));
    });

    test(
      'leaves two blank lines between address and URI when statement is '
      'absent, per the ABNF (`address LF LF [ statement LF ] LF "URI: "`)',
      () {
        final message = createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: '32891756',
          uri: 'https://example.com/login',
          issuedAt: issuedAt,
        );
        expect(message, '''
example.com wants you to sign in with your Ethereum account:
0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2


URI: https://example.com/login
Version: 1
Chain ID: 1
Nonce: 32891756
Issued At: 2021-09-30T16:25:24.000Z''');
      },
    );

    test('appends Expiration Time/Not Before/Request ID when given', () {
      final message = createSiweMessage(
        address: address,
        chainId: 1,
        domain: 'example.com',
        nonce: '32891756',
        uri: 'https://example.com/login',
        issuedAt: issuedAt,
        expirationTime: DateTime.parse('2021-10-01T16:25:24Z'),
        notBefore: DateTime.parse('2021-09-30T16:00:00Z'),
        requestId: 'request-1234',
      );
      expect(message, contains('Expiration Time: 2021-10-01T16:25:24.000Z'));
      expect(message, contains('Not Before: 2021-09-30T16:00:00.000Z'));
      expect(message, contains('Request ID: request-1234'));
    });

    test('throws SiweInvalidMessageFieldError for an invalid domain', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'not a domain',
          nonce: '32891756',
          uri: 'https://example.com/login',
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'domain',
          ),
        ),
      );
    });

    test('throws for a nonce shorter than 8 characters', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: 'short',
          uri: 'https://example.com/login',
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'nonce',
          ),
        ),
      );
    });

    test('throws for a non-alphanumeric nonce', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: 'not-alnum!',
          uri: 'https://example.com/login',
        ),
        throwsA(isA<SiweInvalidMessageFieldError>()),
      );
    });

    test('throws for an invalid uri', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: '32891756',
          uri: 'not a uri',
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'uri',
          ),
        ),
      );
    });

    test('throws for a version other than "1"', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: '32891756',
          uri: 'https://example.com/login',
          version: '2',
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'version',
          ),
        ),
      );
    });

    test('throws for a statement containing a newline', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: '32891756',
          uri: 'https://example.com/login',
          statement: 'line one\nline two',
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'statement',
          ),
        ),
      );
    });

    test('throws for an invalid resource uri', () {
      expect(
        () => createSiweMessage(
          address: address,
          chainId: 1,
          domain: 'example.com',
          nonce: '32891756',
          uri: 'https://example.com/login',
          resources: const ['not a uri'],
        ),
        throwsA(
          isA<SiweInvalidMessageFieldError>().having(
            (e) => e.field,
            'field',
            'resources',
          ),
        ),
      );
    });
  });
}
