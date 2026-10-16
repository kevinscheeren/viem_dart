import 'package:test/test.dart';
import 'package:viem_dart/ens.dart';

void main() {
  group('namehash', () {
    test('the empty name is 32 zero bytes', () {
      expect(
        namehash(''),
        '0x0000000000000000000000000000000000000000000000000000000000000000',
      );
    });

    // Cross-checked against ENS's own docs (docs.ens.domains/resolution/names)
    // and independently recomputed with a from-scratch Python
    // implementation of ERC-137's pseudocode + a separate keccak256
    // library (pycryptodome) — both matched exactly.
    test('matches the ENS docs vector for "eth"', () {
      expect(
        namehash('eth'),
        '0x93cdeb708b7545dc668eb9280176169d1c33cfd8ed6f04690a0bcc88a93fc4ae',
      );
    });

    test('matches the ENS docs vector for "ens.eth"', () {
      expect(
        namehash('ens.eth'),
        '0x4e34d3a81dc3a20f71bbdf2160492ddaa17ee7e5523757d47153379c13cb46df',
      );
    });

    // ERC-137's own worked example.
    test('matches ERC-137\'s worked example for "mysite.swarm"', () {
      expect(
        namehash('mysite.swarm'),
        '0x24a132ab795918f67b0350388713ab923109ccace1419ec27164d783952fc6f6',
      );
    });

    test('is order-sensitive across labels', () {
      expect(namehash('a.b'), isNot(namehash('b.a')));
    });
  });
}
