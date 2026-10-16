/// Action extension methods usable without a full `viem_dart.dart` barrel
/// import. Mirrors viem's `viem/actions` subpath — viem's actions are plain
/// functions taking a client; the Dart-idiomatic equivalent is an extension
/// method on `Client` (see `client.dart`'s composition-model doc comment).
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
export 'src/actions/wallet/wallet_actions.dart';
