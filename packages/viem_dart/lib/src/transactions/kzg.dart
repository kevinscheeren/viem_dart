import 'dart:typed_data';

/// A pluggable KZG commitment/proof backend for EIP-4844 blob transactions
/// — mirrors viem's `Kzg` interface. viem_dart bundles no KZG math of its
/// own (no cross-platform, pure-Dart/wasm-compilable implementation exists
/// yet); a caller who wants
/// to build the blob "network wrapper" (commitments/proofs alongside the
/// actual blob data, for `eth_sendRawTransaction`-style mempool gossip —
/// distinct from the consensus encoding [serializeEip4844Transaction]
/// already produces) supplies their own backend through this interface,
/// e.g. an FFI binding to `c-kzg-4844` on `dart:io` platforms.
abstract class Kzg {
  /// Converts [blob] to its KZG commitment.
  Uint8List blobToKzgCommitment(Uint8List blob);

  /// Computes the KZG proof used to verify [blob] against its
  /// [commitment].
  Uint8List computeBlobKzgProof(Uint8List blob, Uint8List commitment);
}

/// Builds a [Kzg] from loose [blobToKzgCommitment]/[computeBlobKzgProof]
/// functions — mirrors viem's `defineKzg`, a typed passthrough for wiring
/// up an existing KZG library (e.g. a `c-kzg-4844` FFI binding) without
/// writing a dedicated class to implement [Kzg].
Kzg defineKzg({
  required Uint8List Function(Uint8List blob) blobToKzgCommitment,
  required Uint8List Function(Uint8List blob, Uint8List commitment)
  computeBlobKzgProof,
}) => _FunctionKzg(blobToKzgCommitment, computeBlobKzgProof);

class _FunctionKzg implements Kzg {
  _FunctionKzg(this._blobToKzgCommitment, this._computeBlobKzgProof);

  final Uint8List Function(Uint8List blob) _blobToKzgCommitment;
  final Uint8List Function(Uint8List blob, Uint8List commitment)
  _computeBlobKzgProof;

  @override
  Uint8List blobToKzgCommitment(Uint8List blob) => _blobToKzgCommitment(blob);

  @override
  Uint8List computeBlobKzgProof(Uint8List blob, Uint8List commitment) =>
      _computeBlobKzgProof(blob, commitment);
}
