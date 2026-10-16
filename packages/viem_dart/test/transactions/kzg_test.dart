import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:viem_dart/viem_dart.dart';

class _FakeKzg implements Kzg {
  @override
  Uint8List blobToKzgCommitment(Uint8List blob) =>
      Uint8List.fromList([1, ...blob]);

  @override
  Uint8List computeBlobKzgProof(Uint8List blob, Uint8List commitment) =>
      Uint8List.fromList([2, ...blob, ...commitment]);
}

void main() {
  group('Kzg', () {
    test('a custom implementation satisfies the interface', () {
      final Kzg kzg = _FakeKzg();
      final blob = Uint8List.fromList([9, 9, 9]);
      final commitment = kzg.blobToKzgCommitment(blob);
      expect(commitment, [1, 9, 9, 9]);
      expect(kzg.computeBlobKzgProof(blob, commitment), [
        2,
        9,
        9,
        9,
        1,
        9,
        9,
        9,
      ]);
    });
  });

  group('defineKzg', () {
    test('wraps loose functions into a Kzg', () {
      final blob = Uint8List.fromList([5, 6, 7]);
      final commitment = Uint8List.fromList([42]);
      var computeCalledWith = (Uint8List(0), Uint8List(0));

      final kzg = defineKzg(
        blobToKzgCommitment: (b) => commitment,
        computeBlobKzgProof: (b, c) {
          computeCalledWith = (b, c);
          return Uint8List.fromList([99]);
        },
      );

      expect(kzg.blobToKzgCommitment(blob), commitment);
      expect(kzg.computeBlobKzgProof(blob, commitment), [99]);
      expect(computeCalledWith.$1, blob);
      expect(computeCalledWith.$2, commitment);
    });
  });
}
