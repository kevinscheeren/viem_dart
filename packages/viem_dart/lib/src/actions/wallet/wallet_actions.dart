import 'dart:typed_data';

import '../../client/transaction_request.dart';
import '../../client/wallet_client.dart';
import '../../transactions/eip1559_transaction.dart';
import '../../transactions/eip2930_transaction.dart';
import '../../transactions/eip4844_transaction.dart';
import '../../transactions/eip7702_transaction.dart';
import '../../transactions/legacy_transaction.dart';
import '../../transactions/transaction_envelope.dart';
import '../../utils/hex.dart';
import '../public/gas_actions.dart'; // for PublicClient.estimateGas()/estimateFeesPerGas()
import '../public/public_actions.dart'; // for PublicClient.getChainId()/getTransactionCount()

/// Transaction-sending actions available on every [WalletClient].
extension WalletActions on WalletClient {
  /// Signs [tx] with the client's own [WalletClient.account], dispatching to
  /// the type-specific serializer/signer pair for whichever
  /// [TransactionEnvelope] variant [tx] is, and returns the raw signed
  /// transaction as hex — ready for [sendRawTransaction].
  String signTransaction(TransactionEnvelope tx) {
    final signed = switch (tx) {
      LegacyTransaction() => signLegacyTransaction(tx, account),
      Eip2930Transaction() => signEip2930Transaction(tx, account),
      Eip1559Transaction() => signEip1559Transaction(tx, account),
      Eip7702Transaction() => signEip7702Transaction(tx, account),
      Eip4844Transaction() => signEip4844Transaction(tx, account),
    };
    final serialized = switch (signed) {
      LegacyTransaction s => serializeLegacyTransaction(s),
      Eip2930Transaction s => serializeEip2930Transaction(s),
      Eip1559Transaction s => serializeEip1559Transaction(s),
      Eip7702Transaction s => serializeEip7702Transaction(s),
      Eip4844Transaction s => serializeEip4844Transaction(s),
    };
    return bytesToHex(serialized);
  }

  /// Fills in [from] (defaulting to the client's own [WalletClient.account]),
  /// [nonce], [gas], and EIP-1559 fee fields for a transaction, ready to be
  /// signed and sent. Doesn't sign or submit anything itself.
  Future<TransactionRequest> prepareTransactionRequest({
    String? from,
    String? to,
    BigInt? value,
    String? data,
    int? nonce,
    BigInt? gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
  }) async {
    final sender = from ?? account.address;

    final resolvedNonce =
        nonce ?? await getTransactionCount(sender, blockTag: 'pending');

    var resolvedMaxFeePerGas = maxFeePerGas;
    var resolvedMaxPriorityFeePerGas = maxPriorityFeePerGas;
    if (resolvedMaxFeePerGas == null || resolvedMaxPriorityFeePerGas == null) {
      final fees = await estimateFeesPerGas();
      resolvedMaxFeePerGas ??= fees.maxFeePerGas;
      resolvedMaxPriorityFeePerGas ??= fees.maxPriorityFeePerGas;
    }

    final resolvedGas =
        gas ??
        await estimateGas(from: sender, to: to, data: data, value: value);
    final chainId = await getChainId();

    return TransactionRequest(
      from: sender,
      to: to,
      value: value,
      data: data,
      nonce: resolvedNonce,
      gas: resolvedGas,
      maxFeePerGas: resolvedMaxFeePerGas,
      maxPriorityFeePerGas: resolvedMaxPriorityFeePerGas,
      chainId: chainId,
    );
  }

  /// Fills in nonce/gas/EIP-1559 fees via [prepareTransactionRequest],
  /// signs the resulting transaction with the client's own
  /// [WalletClient.account] via [signTransaction], and submits it via
  /// [sendRawTransaction] — returning its hash.
  Future<String> sendTransaction({
    String? from,
    String? to,
    BigInt? value,
    String? data,
    int? nonce,
    BigInt? gas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
  }) async {
    final request = await prepareTransactionRequest(
      from: from,
      to: to,
      value: value,
      data: data,
      nonce: nonce,
      gas: gas,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
    );
    final tx = Eip1559Transaction(
      chainId: request.chainId,
      nonce: BigInt.from(request.nonce),
      maxPriorityFeePerGas: request.maxPriorityFeePerGas!,
      maxFeePerGas: request.maxFeePerGas!,
      gasLimit: request.gas,
      to: request.to,
      value: request.value ?? BigInt.zero,
      data: request.data == null ? Uint8List(0) : hexToBytes(request.data!),
      accessList: const [],
    );
    return sendRawTransaction(signTransaction(tx));
  }

  /// Submits an already-signed raw transaction (`eth_sendRawTransaction`),
  /// returning its hash.
  Future<String> sendRawTransaction(String signedTransaction) async {
    final result = await rpc.request('eth_sendRawTransaction', [
      signedTransaction,
    ]);
    return result as String;
  }
}
