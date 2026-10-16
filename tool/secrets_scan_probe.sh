#!/bin/sh
# Deliberate-break proof for the secrets scan: a gate that has only
# ever printed "clean" is not known to work. This builds throwaway repositories
# and checks that the scan, with this repo's `.gitleaks.toml`:
#   1. passes a clean repository;
#   2. fails a planted 64-hex key in the committed tree;
#   3. fails a key that was committed and then deleted (history only);
#   4. fails a planted BIP-39 mnemonic;
#   5. fails a planted RPC URL with the key in its path;
#   6. fails a key committed on a branch HEAD has merged (it is in HEAD's ancestry);
#   7. passes a key that sits only on a side branch that is not an ancestor of HEAD,
#      and fails the same key as soon as that branch is checked out;
#   8. with --base, scans only <base>..HEAD, and refuses a base that does not resolve.
# The planted values are made up and never valid for anything.
#
# Usage: tool/secrets_scan_probe.sh [path-to-gitleaks]
set -eu

root="$(cd "$(dirname "$0")/.." && pwd)"
gitleaks="${1:-$("$root/tool/install_gitleaks.sh")}"
case "$gitleaks" in /*) ;; *) gitleaks="$(pwd)/$gitleaks" ;; esac
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# A made-up key: 64 hex digits that are not any known test key.
key="$(printf '%064x' 1311768467294899695)"

new_repo() {
  dir="$work/$1"
  git init -q "$dir"
  git -C "$dir" config user.email probe@example.invalid
  git -C "$dir" config user.name probe
  echo "void main() {}" >"$dir/main.dart"
  git -C "$dir" add -A
  git -C "$dir" commit -q -m "chore: base"
  echo "$dir"
}

# scan <repo> [--base <ref>]
scan() {
  repo_arg="$1"
  shift
  SECRETS_SCAN_REPO="$repo_arg" "$root/tool/secrets_scan.sh" "$@" "$gitleaks" >/dev/null 2>&1
}

scan_code() { scan "$@" && echo 0 || echo $?; }

# expect_pass <repo> <label> [scan args]; expect_fail likewise.
expect_pass() {
  repo_arg="$1"; label="$2"; shift 2
  if scan "$repo_arg" "$@"; then echo "ok    $label"; else echo "FAIL  $label (the scan rejected it)"; failed=1; fi
}
expect_fail() {
  repo_arg="$1"; label="$2"; shift 2
  if scan "$repo_arg" "$@"; then echo "FAIL  $label (the scan let it through)"; failed=1; else echo "ok    $label"; fi
}

failed=0

repo="$(new_repo clean)"
expect_pass "$repo" "a clean repository passes"

repo="$(new_repo planted)"
echo "const privateKey = '0x$key';" >"$repo/key.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add key"
expect_fail "$repo" "a planted 64-hex key fails"

repo="$(new_repo deleted)"
echo "const privateKey = '$key';" >"$repo/key.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add key"
git -C "$repo" rm -q key.dart && git -C "$repo" commit -q -m "fix: remove key"
expect_fail "$repo" "a key deleted from the tree but still in history fails"

repo="$(new_repo mnemonic)"
# Assembled at run time, so this script holds no mnemonic-shaped literal itself.
words="legal winner thank year wave sausage worth useful legal winner thank"
echo "const seed = '$words yellow';" >"$repo/seed.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add seed"
expect_fail "$repo" "a planted BIP-39 mnemonic fails"

repo="$(new_repo rpcurl)"
head="aB3dE5gH7jK9"
tail="mN1pQ3sT5vW7yZ1b"
echo "const rpc = 'https://eth-mainnet.example.com/v2/$head$tail';" >"$repo/rpc.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add rpc"
expect_fail "$repo" "an RPC URL with the key in its path fails"

repo="$(new_repo merged)"
git -C "$repo" checkout -q -b side
echo "const privateKey = '0x$key';" >"$repo/key.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add key"
git -C "$repo" checkout -q -
git -C "$repo" merge -q --no-ff side -m "Merge side"
git -C "$repo" rm -q key.dart && git -C "$repo" commit -q -m "fix: remove key"
expect_fail "$repo" "a key from a merged branch, deleted since, is in HEAD's ancestry and fails"

repo="$(new_repo sidebranch)"
trunk="$(git -C "$repo" rev-parse --abbrev-ref HEAD)"
git -C "$repo" checkout -q -b side
echo "const privateKey = '0x$key';" >"$repo/key.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add key"
git -C "$repo" checkout -q "$trunk"
echo "// more" >>"$repo/main.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "chore: more"
expect_pass "$repo" "a key only on a side branch, not an ancestor of HEAD, passes"
git -C "$repo" checkout -q side
expect_fail "$repo" "the same key fails once that branch is HEAD"

repo="$(new_repo base)"
git -C "$repo" tag before
echo "const privateKey = '0x$key';" >"$repo/key.dart"
git -C "$repo" add -A && git -C "$repo" commit -q -m "feat: add key"
git -C "$repo" tag after
git -C "$repo" rm -q key.dart && git -C "$repo" commit -q -m "fix: remove key"
expect_fail "$repo" "--base before the key's commit fails" --base before
expect_pass "$repo" "--base after the key's commit passes" --base after
if [ "$(scan_code "$repo" --base no-such-ref)" = 2 ]; then
  echo "ok    --base that does not resolve exits 2"
else
  echo "FAIL  --base that does not resolve must exit 2, not pass"; failed=1
fi

exit "$failed"
