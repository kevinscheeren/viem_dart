import '../crypto/secp256k1.dart' as secp256k1;
import '../crypto/signature.dart';
import 'eip1559_transaction.dart';
import 'eip2930_transaction.dart';
import 'eip4844_transaction.dart';
import 'eip7702_transaction.dart';
import 'legacy_transaction.dart';
import 'transaction_envelope.dart';

/// Recovers the (EIP-55 checksummed) sender address of a signed [tx] — the
/// reverse of `sign<Type>Transaction`. Throws a [StateError] if [tx] isn't
/// signed (`yParity`/`r`/`s` are `null`).
String recoverTransactionAddress(TransactionEnvelope tx) {
  final (hash, yParity, r, s) = switch (tx) {
    LegacyTransaction t => (hashLegacyTransaction(t), t.yParity, t.r, t.s),
    Eip2930Transaction t => (hashEip2930Transaction(t), t.yParity, t.r, t.s),
    Eip1559Transaction t => (hashEip1559Transaction(t), t.yParity, t.r, t.s),
    Eip7702Transaction t => (hashEip7702Transaction(t), t.yParity, t.r, t.s),
    Eip4844Transaction t => (hashEip4844Transaction(t), t.yParity, t.r, t.s),
  };
  if (yParity == null || r == null || s == null) {
    throw StateError('Cannot recover the sender of an unsigned transaction.');
  }
  return secp256k1.recoverAddress(
    hash,
    Signature(r: r, s: s, yParity: yParity),
  );
}
