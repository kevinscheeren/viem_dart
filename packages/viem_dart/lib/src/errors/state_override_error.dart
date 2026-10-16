import 'base_error.dart';

/// Thrown when one account's state override sets both `state` and
/// `stateDiff` — they are mutually exclusive: `state` replaces the
/// account's whole storage, `stateDiff` patches individual slots (mirrors
/// viem's `StateAssignmentConflictError`).
class StateAssignmentConflictError extends ViemError {
  /// Creates a [StateAssignmentConflictError].
  const StateAssignmentConflictError()
    : super(
        'State assignment conflict.',
        metaMessages: const [
          'You cannot set both `state` and `stateDiff` on one account '
              'override: `state` replaces the account\'s whole storage, '
              '`stateDiff` patches individual slots.',
        ],
      );
}

/// Thrown when a state override list names the same [address] more than
/// once (mirrors viem's `AccountStateConflictError`).
class AccountStateConflictError extends ViemError {
  /// Creates an [AccountStateConflictError] for the duplicated [address].
  AccountStateConflictError({required this.address})
    : super(
        'State for account "$address" is set multiple times.',
        metaMessages: const [
          'Merge the overrides for this address into a single entry.',
        ],
      );

  /// The address that appears more than once (compared case-insensitively).
  final String address;
}
