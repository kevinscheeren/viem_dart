#!/bin/sh
# Docs guard: SECURITY.md and docs/vulnerability-policy.md state the reporting
# route (GitHub private vulnerability reporting), the acknowledgement time,
# coordinated disclosure, consent-based credit (Art. 6(1)(a) GDPR), advisories
# and no bounty, and name no e-mail address. Wired into `melos run check:docs`.

cd "$(dirname "$0")/.." || exit 2

failed=0
fail() { echo "✖ check:security-docs: $1" >&2; failed=1; }

for f in SECURITY.md docs/vulnerability-policy.md; do
  [ -f "$f" ] || { fail "$f is missing"; continue; }
  # The reporting route is GitHub's private channel, so no address may appear.
  others="$(grep -o -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$f" | sort -u)"
  [ -z "$others" ] || fail "$f names an e-mail address: $others"
  grep -q "72 hours" "$f" || fail "$f does not state the 72-hour acknowledgement time"
  grep -q 'Art. 6(1)(a) GDPR' "$f" || fail "$f does not tie credit to consent (Art. 6(1)(a) GDPR)"
  grep -q -i 'no bounty' "$f" || fail "$f does not state there is no bounty"
done

[ -f SECURITY.md ] && {
  grep -q -i 'private vulnerability reporting' SECURITY.md || fail "SECURITY.md does not name GitHub private vulnerability reporting"
  grep -q -i 'good-faith' SECURITY.md || fail "SECURITY.md has no good-faith testing clause"
  grep -q 'docs/vulnerability-policy.md' SECURITY.md || fail "SECURITY.md does not link the vulnerability policy"
  grep -q -i 'supported versions' SECURITY.md || fail "SECURITY.md has no supported-versions section"
}
[ -f docs/vulnerability-policy.md ] && {
  grep -q -i 'coordinated disclosure' docs/vulnerability-policy.md || fail "the policy does not state coordinated disclosure"
  grep -q -i 'security advisory' docs/vulnerability-policy.md || fail "the policy does not state GitHub security advisories"
}

[ "$failed" = 0 ] && echo "check:security-docs: SECURITY.md and the vulnerability policy are consistent."
exit "$failed"
