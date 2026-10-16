#!/bin/sh
# Secrets scan: gitleaks with `.gitleaks.toml` over
# the git history reachable from HEAD (merge commits included) and over the
# committed working tree. Exits non-zero on any finding. Reads only the
# repository; the one network call is the pinned gitleaks download
# (`install_gitleaks.sh`).
#
# Only HEAD's ancestry is read, not every fetched branch: a value on an unmerged
# branch must not fail the scan of another one (each branch is scanned in full
# by its own run, and a merge brings its history into the target's ancestry).
#
# Usage: tool/secrets_scan.sh [--base <ref>] [path-to-gitleaks]
#   --base <ref>  scan only <ref>..HEAD of the history (the tree is always scanned)
#   The binary defaults to the pinned one `install_gitleaks.sh` installs.
# Exit codes: 0 clean, 1 a finding, 2 the scan could not run (shallow clone,
# a <ref> that does not resolve, ...).
#
# Findings are printed redacted; never paste a secret value into an issue.
set -eu

base=""
if [ "${1:-}" = "--base" ]; then
  [ -n "${2:-}" ] || { echo "secrets_scan: --base needs a ref" >&2; exit 2; }
  base="$2"
  shift 2
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
gitleaks="${1:-$("$root/tool/install_gitleaks.sh")}"
case "$gitleaks" in /*) ;; *) gitleaks="$(pwd)/$gitleaks" ;; esac
config="$root/.gitleaks.toml"
repo="${SECRETS_SCAN_REPO:-$root}"

cd "$repo"
if [ "$(git rev-parse --is-shallow-repository)" = true ]; then
  echo "secrets_scan: shallow clone: the history scan would be partial; fetch full history." >&2
  exit 2
fi

# gitleaks scans nothing and passes when `<base>..HEAD` does not resolve.
if [ -n "$base" ] && ! git rev-parse --verify --quiet "$base^{commit}" >/dev/null; then
  echo "secrets_scan: $base does not resolve to a commit (fetch the base branch first)." >&2
  exit 2
fi
range="HEAD"
[ -n "$base" ] && range="$base..HEAD"

echo "secrets_scan: git history ($range)"
"$gitleaks" git --no-banner --redact --ignore-gitleaks-allow \
  --config "$config" --log-opts="-m $range" .

# The committed tree, without ignored build output (.dart_tool and friends).
tree="$(mktemp -d)"
trap 'rm -rf "$tree"' EXIT
git archive HEAD | tar -x -C "$tree"
echo "secrets_scan: committed working tree"
(cd "$tree" && "$gitleaks" dir --no-banner --redact --ignore-gitleaks-allow \
  --config "$config" .)

echo "secrets_scan: clean."
