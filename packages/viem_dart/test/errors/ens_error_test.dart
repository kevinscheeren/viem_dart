import 'package:test/test.dart';
import 'package:viem_dart/ens.dart';

void main() {
  group('EnsAvatarInvalidMetadataError', () {
    test('includes the provided data in meta messages', () {
      final error = EnsAvatarInvalidMetadataError(data: {'foo': 'bar'});
      expect(error.metaMessages.join('\n'), contains('{foo: bar}'));
    });
  });

  group('EnsAvatarInvalidNftUriError', () {
    test('includes the reason', () {
      final error = EnsAvatarInvalidNftUriError(reason: 'missing chainId');
      expect(error.shortMessage, contains('missing chainId'));
    });
  });

  group('EnsAvatarUriResolutionError', () {
    test('includes the uri', () {
      final error = EnsAvatarUriResolutionError(uri: 'ipfs://bad');
      expect(error.shortMessage, contains('ipfs://bad'));
    });

    test('is thrown by resolveAvatarUri on an unrecognized uri', () {
      expect(
        () => resolveAvatarUri('not-a-real-uri'),
        throwsA(isA<EnsAvatarUriResolutionError>()),
      );
    });
  });

  group('EnsAvatarUnsupportedNamespaceError', () {
    test('includes the namespace', () {
      final error = EnsAvatarUnsupportedNamespaceError(namespace: 'erc20');
      expect(error.shortMessage, contains('"erc20"'));
    });
  });

  group('EnsInvalidChainIdError', () {
    test('includes the chainId', () {
      final error = EnsInvalidChainIdError(chainId: -1);
      expect(error.shortMessage, contains('-1'));
    });
  });
}
