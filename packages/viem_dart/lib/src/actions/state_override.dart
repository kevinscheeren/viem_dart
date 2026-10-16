import '../errors/state_override_error.dart';
import '../utils/hex.dart';

/// A temporary override of one account's state for the duration of a single
/// `eth_call` — viem's `stateOverride` entry. The override never touches
/// the chain; it only changes what the call sees.
///
/// Set [state] to replace the account's whole storage, or [stateDiff] to
/// patch individual slots (not both). Slots and values are 32-byte hex
/// strings.
class AccountStateOverride {
  /// Creates an override for the account at [address].
  const AccountStateOverride({
    required this.address,
    this.balance,
    this.nonce,
    this.code,
    this.state,
    this.stateDiff,
  });

  /// The account to override.
  final String address;

  /// Replaces the account's balance, in wei.
  final BigInt? balance;

  /// Replaces the account's nonce.
  final int? nonce;

  /// Replaces the account's bytecode (hex).
  final String? code;

  /// Replaces the account's entire storage: slot to value, both 32-byte hex.
  final Map<String, String>? state;

  /// Patches individual storage slots, leaving the rest untouched: slot to
  /// value, both 32-byte hex.
  final Map<String, String>? stateDiff;
}

/// Serialises [overrides] into the JSON-RPC shape of the third `eth_call`
/// parameter: `{ address: { balance, nonce, code, state, stateDiff } }`.
///
/// Throws [AccountStateConflictError] if an address appears twice,
/// [StateAssignmentConflictError] if an entry sets both `state` and
/// `stateDiff`, and [ArgumentError] for a slot or value that is not
/// 32-byte hex.
Map<String, Object?> serializeStateOverride(
  List<AccountStateOverride> overrides,
) {
  final result = <String, Object?>{};
  final seen = <String>{};
  for (final override in overrides) {
    if (!seen.add(override.address.toLowerCase())) {
      throw AccountStateConflictError(address: override.address);
    }
    if (override.state != null && override.stateDiff != null) {
      throw const StateAssignmentConflictError();
    }
    result[override.address] = <String, Object?>{
      if (override.balance != null) 'balance': bigIntToHex(override.balance!),
      if (override.nonce != null) 'nonce': intToHex(override.nonce!),
      if (override.code != null) 'code': override.code,
      if (override.state != null) 'state': _serializeSlots(override.state!),
      if (override.stateDiff != null)
        'stateDiff': _serializeSlots(override.stateDiff!),
    };
  }
  return result;
}

Map<String, String> _serializeSlots(Map<String, String> slots) => {
  for (final entry in slots.entries)
    _word(entry.key, 'slot'): _word(entry.value, 'value'),
};

String _word(String hex, String what) {
  if (!isHex(hex) || hexSize(hex) != 32) {
    throw ArgumentError.value(hex, what, 'must be 32-byte hex');
  }
  return hex;
}
