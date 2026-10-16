import 'base_error.dart';

/// Mirrors viem's `AccountNotFoundError` for API-taxonomy completeness.
/// Not thrown by this library's own wallet actions — `WalletClient.account`
/// is required at construction, so the scenario this describes (an action
/// requiring an account with neither an explicit `from` argument nor a
/// client created with one) is a compile error here, not a runtime one.
class AccountNotFoundError extends ViemError {
  /// Creates an [AccountNotFoundError].
  const AccountNotFoundError()
    : super(
        'Could not find an Account to execute with this action.',
        metaMessages: const [
          'Please provide an Account with the relevant argument, or by '
              'creating the WalletClient with an `account`.',
        ],
      );
}

/// Thrown when an account of an unsupported [type] is used where a
/// specific type is required (e.g. a `JsonRpcAccount` where local signing
/// is needed).
class AccountTypeNotSupportedError extends ViemError {
  /// Creates an [AccountTypeNotSupportedError] for the unsupported
  /// [type].
  AccountTypeNotSupportedError({required this.type})
    : super('Account type "$type" is not supported.');

  final String type;
}
