/// A from-scratch, pure-Dart port of viem — a composable transport/chain/account/client
/// model for interacting with EVM chains from server-side Dart, Flutter, and Jaspr.
library;

export 'src/actions/public/contract_actions.dart';
export 'src/actions/public/filter_actions.dart';
export 'src/actions/public/gas_actions.dart';
export 'src/actions/public/multicall_actions.dart';
export 'src/actions/public/public_actions.dart';
export 'src/actions/public/state_actions.dart';
export 'src/actions/public/verify_hash_actions.dart';
export 'src/actions/public/wait_for_transaction_receipt.dart';
export 'src/actions/public/watch_actions.dart';
export 'src/actions/state_override.dart';
export 'src/actions/wallet/batch_call_actions.dart';
export 'src/actions/wallet/wallet_actions.dart';
export 'src/chain/chain.dart';
export 'src/client/block.dart';
export 'src/client/client.dart';
export 'src/client/fee_history.dart';
export 'src/client/json_rpc.dart';
export 'src/client/log.dart';
export 'src/client/public_client.dart';
export 'src/client/rpc_client.dart';
export 'src/client/test_client.dart';
export 'src/client/transaction.dart';
export 'src/client/transaction_receipt.dart';
export 'src/client/transaction_request.dart';
export 'src/client/wallet_client.dart';
export 'src/contract/contract.dart';
export 'src/errors/abi_error.dart';
export 'src/errors/account_error.dart';
export 'src/errors/base_error.dart';
export 'src/errors/contract_error.dart';
export 'src/errors/ens_error.dart';
export 'src/errors/rpc_error.dart';
export 'src/errors/state_override_error.dart';
export 'src/errors/transaction_error.dart';
export 'src/ens/ens_actions.dart';
export 'src/ens/universal_resolver.dart';
export 'src/transactions/access_list.dart';
export 'src/transactions/authorization.dart';
export 'src/transactions/authorization_rlp.dart'
    show authorizationMagic, hashAuthorization;
export 'src/transactions/eip1559_transaction.dart';
export 'src/transactions/eip2930_transaction.dart';
export 'src/transactions/eip4844_transaction.dart';
export 'src/transactions/eip7702_transaction.dart';
export 'src/transactions/kzg.dart';
export 'src/transactions/legacy_transaction.dart';
export 'src/transactions/recover_transaction_address.dart';
export 'src/transactions/sign_authorization.dart';
export 'src/transactions/transaction_envelope.dart';
export 'src/transports/custom_transport.dart';
export 'src/transports/fallback_transport.dart';
export 'src/transports/http_transport.dart';
export 'src/transports/ipc_transport.dart';
export 'src/transports/transport.dart';
export 'src/transports/websocket_transport.dart';

/// Package version. `melos version` does not touch it: set it by hand to the
/// `version:` in this package's `pubspec.yaml` when cutting a release
/// (`docs/release.md`); `test/viem_dart_test.dart` fails if the two differ.
const String viemDartVersion = '0.2.0';
