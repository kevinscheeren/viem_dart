# Security Policy

This policy covers `viem_dart`: the Dart package in `packages/viem_dart/` (signing, hashing,
encoding and decoding for EVM wallets and clients) and the code generator in
`packages/viem_dart_builders/`. It is a personal open-source library under the MIT licence,
maintained by [@kevinscheeren](https://github.com/kevinscheeren).

## Supported versions

A vulnerability is fixed in the versions below and in nothing older.

| What | Which versions get a fix |
| --- | --- |
| `viem_dart` (tag `viem_dart-vX.Y.Z`) | the latest release, and the latest release of the previous minor version |
| `viem_dart_builders` | the same release train as `viem_dart` |

The first release is `0.1.0` (see [`CHANGELOG.md`](packages/viem_dart/CHANGELOG.md)). Until a
second one exists, only that release and the latest commit on `development` are fixed.

## Report a vulnerability privately

**Use GitHub private vulnerability reporting.** On the repository's **Security** tab, choose
**Report a vulnerability** (<https://github.com/kevinscheeren/viem_dart/security/advisories/new>).
The report is visible only to the maintainer, and a fix can be prepared in a private fork before
it is disclosed.

Do not disclose a suspected vulnerability in a public issue, pull request, discussion or comment
before a fix is available and a disclosure date is agreed.

Include as much of the following as you can:

- the affected function, file or workflow, and the version or commit;
- a description of the impact and who could be affected, for example a wrong signature, a wrong
  hash, a wrongly decoded value, or a private key or seed reaching a log or an error message;
- clear reproduction steps or a minimal proof of concept;
- any conditions required to exploit the issue;
- a suggested mitigation, if you have one.

Leave secrets, private keys, seed phrases, credentials and other people's personal data out of the
report. Use throwaway test keys.

## What to expect

- **Acknowledgement within 72 hours** of your report being submitted.
- Then validation, scoping, a fix and a disclosure date agreed with you. What happens after your
  report, and how a fix and an advisory reach people, is in
  [`docs/vulnerability-policy.md`](docs/vulnerability-policy.md).
- Credit in the advisory and the release notes **only if you agree** (Art. 6(1)(a) GDPR). You can
  withdraw that consent at any time by writing on the advisory; what was published until then remains lawful.
- **No bounty.** There is no bug bounty or other payment for a report.

## Good-faith research

The maintainer will not treat research that stays within these limits as hostile:

- test against your own keys, a local node such as `anvil`, a fork or a testnet, never against
  funds or accounts that belong to someone else;
- do not run an exploit against a live network or a service you do not own;
- do not read, change or delete data that is not yours, or disrupt anyone's use of a service;
- stop at the first proof that the issue exists, and do not keep or pass on any data you reached.

If a test could affect other people or systems, stop and send a private report first.

A flaw in [viem](https://github.com/wevm/viem) itself, which this library follows, belongs to
viem's own [security policy](https://github.com/wevm/viem/security/policy); tell the maintainer as well if
`viem_dart` is affected.
