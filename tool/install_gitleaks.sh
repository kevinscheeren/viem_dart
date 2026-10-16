#!/bin/sh
# Installs the pinned gitleaks release into the directory given as $1
# (default: .dart_tool/gitleaks) and prints the absolute path of the binary. The
# download is sha256-verified against the hashes pinned below, copied from the
# release's own `gitleaks_8.30.1_checksums.txt`; a mismatch aborts. To bump
# gitleaks, change VERSION and every hash together, from the release page.
set -eu

VERSION=8.30.1

cd "$(dirname "$0")/.."
dest="${1:-$PWD/.dart_tool/gitleaks}"
case "$dest" in /*) ;; *) dest="$PWD/$dest" ;; esac

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)  asset=linux_x64;    sha=551f6fc83ea457d62a0d98237cbad105af8d557003051f41f3e7ca7b3f2470eb ;;
  Linux-aarch64) asset=linux_arm64;  sha=e4a487ee7ccd7d3a7f7ec08657610aa3606637dab924210b3aee62570fb4b080 ;;
  Darwin-arm64)  asset=darwin_arm64; sha=b40ab0ae55c505963e365f271a8d3846efbc170aa17f2607f13df610a9aeb6a5 ;;
  Darwin-x86_64) asset=darwin_x64;   sha=dfe101a4db2255fc85120ac7f3d25e4342c3c20cf749f2c20a18081af1952709 ;;
  *) echo "install_gitleaks: unsupported platform $(uname -s)-$(uname -m)" >&2; exit 2 ;;
esac

bin="$dest/gitleaks-$VERSION/gitleaks"
if [ -x "$bin" ] && [ "$("$bin" version)" = "$VERSION" ]; then
  echo "$bin"
  exit 0
fi

mkdir -p "$dest/gitleaks-$VERSION"
tarball="$dest/gitleaks-$VERSION.tar.gz"
curl -fsSL -o "$tarball" \
  "https://github.com/gitleaks/gitleaks/releases/download/v$VERSION/gitleaks_${VERSION}_$asset.tar.gz"

if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "$tarball" | cut -d' ' -f1)"
else
  actual="$(shasum -a 256 "$tarball" | cut -d' ' -f1)"
fi
if [ "$actual" != "$sha" ]; then
  rm -f "$tarball"
  echo "install_gitleaks: sha256 mismatch for $asset (expected $sha, got $actual)" >&2
  exit 1
fi

tar -xzf "$tarball" -C "$dest/gitleaks-$VERSION" gitleaks
rm -f "$tarball"
echo "$bin"
