import 'package:test/test.dart';
import 'package:viem_dart/ens.dart';

void main() {
  // Ported directly from viem's own resolveAvatarUri test suite (MIT) —
  // src/utils/ens/avatar/utils.test.ts.
  group('resolveAvatarUri', () {
    final ipfsCases = {
      'ipfs://ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
      'ipfs://ipns/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipns/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
      'bafybeiasb5vpmaounyilfuxbd3lryvosl4yefqrfahsb2esg46q6tu6y5q':
          'https://ipfs.io/ipfs/bafybeiasb5vpmaounyilfuxbd3lryvosl4yefqrfahsb2esg46q6tu6y5q',
      'zdj7WWeQ43G6JJvLWQWZpyHuAMq6uYWRjkBXFad11vE2LHhQ7':
          'https://ipfs.io/ipfs/zdj7WWeQ43G6JJvLWQWZpyHuAMq6uYWRjkBXFad11vE2LHhQ7',
      'zdj7WWeQ43G6JJvLWQWZpyHuAMq6uYWRjkBXFad11vE2LHhQ7/test.json':
          'https://ipfs.io/ipfs/zdj7WWeQ43G6JJvLWQWZpyHuAMq6uYWRjkBXFad11vE2LHhQ7/test.json',
      'ipfs://QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB/1.json':
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB/1.json',
      'ipns://QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipns/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
      '/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB/1.json':
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB/1.json',
      '/ipns/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipns/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
      'ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
      'ipns/ipns.com/1.json': 'https://ipfs.io/ipns/ipns.com/1.json',
      '/ipns/github.com': 'https://ipfs.io/ipns/github.com',
      'https://rainbow.pinata.cloud/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB':
          'https://ipfs.io/ipfs/QmZHKZDavkvNfA9gSAg7HALv8jF7BJaKjUc9U2LSuvUySB',
    };

    ipfsCases.forEach((input, expected) {
      test('resolves IPFS/IPNS uri "$input"', () {
        expect(resolveAvatarUri(input).uri, expected);
      });
    });

    final arweaveCases = {
      'ar://rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI':
          'https://arweave.net/rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI',
      'ar://rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI/1':
          'https://arweave.net/rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI/1',
      'ar://rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI/1.json':
          'https://arweave.net/rgW4h3ffQQzOD8ynnwdl3_YlHxtssqV3aXOregPr7yI/1.json',
      'ar://tnLgkAg70wsn9fSr1sxJKG_qcka1gJtmUwXm_3_lDaI/1.png':
          'https://arweave.net/tnLgkAg70wsn9fSr1sxJKG_qcka1gJtmUwXm_3_lDaI/1.png',
    };

    arweaveCases.forEach((input, expected) {
      test('resolves Arweave uri "$input"', () {
        expect(resolveAvatarUri(input).uri, expected);
      });
    });

    test('passes an https:// uri through unchanged', () {
      final result = resolveAvatarUri('https://i.imgur.com/yed5Zfk.gif');
      expect(result.uri, 'https://i.imgur.com/yed5Zfk.gif');
      expect(result.isOnChain, isFalse);
      expect(result.isEncoded, isFalse);
    });

    test('passes an http:// uri through unchanged', () {
      final result = resolveAvatarUri('http://i.imgur.com/yed5Zfk.gif');
      expect(result.uri, 'http://i.imgur.com/yed5Zfk.gif');
      expect(result.isOnChain, isFalse);
      expect(result.isEncoded, isFalse);
    });

    test('recognizes an already-base64-encoded data uri', () {
      const uri =
          'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==';
      final result = resolveAvatarUri(uri);
      expect(result.uri, uri);
      expect(result.isOnChain, isTrue);
      expect(result.isEncoded, isTrue);
    });

    test('base64-encodes inline SVG content', () {
      final result = resolveAvatarUri('data:image/svg+xml;utf8,<svg></svg>');
      expect(result.uri, 'data:image/svg+xml;base64,PHN2Zz48L3N2Zz4=');
      expect(result.isOnChain, isTrue);
      expect(result.isEncoded, isFalse);
    });
  });
}
