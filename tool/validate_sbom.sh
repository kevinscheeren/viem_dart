#!/bin/sh
# Validates a CycloneDX 1.6 SBOM against the official JSON Schema.
#
# Usage: tool/validate_sbom.sh <sbom.cdx.json>
#
# The schemas are fetched from CycloneDX/specification at a pinned commit and
# sha256-verified; jsonschema is pinned and installed into a throwaway venv.
# Needs python3 and network access. Exits non-zero if the file is not valid.
set -eu

commit=55343ba19dee1785acf1ce9191540d5fd7b590db
bom_sha=3e92dddbc30cf7f6a02b80f0942b1a4cfd4fb1c26f1dfc4310afa9d613cafb93
spdx_sha=baa9d3bd1ed57b6751b0887edead6b5063ff53ff7429cf85d476c6c94af0166e
jsf_sha=8bae002c25e723db7ee1f26afde680ae1a2b1a8f6b4b4b0fd65dc3becb090aae

sbom="${1:?usage: validate_sbom.sh <sbom.cdx.json>}"
sbom="$(cd "$(dirname "$sbom")" && pwd)/$(basename "$sbom")"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

sha256() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | cut -d' ' -f1
  else shasum -a 256 "$1" | cut -d' ' -f1; fi
}

fetch() { # file expected-sha
  curl -fsSL -o "$work/$1" \
    "https://raw.githubusercontent.com/CycloneDX/specification/$commit/schema/$1"
  actual="$(sha256 "$work/$1")"
  if [ "$actual" != "$2" ]; then
    echo "validate_sbom: sha256 mismatch for $1 (expected $2, got $actual)" >&2
    exit 1
  fi
}
fetch bom-1.6.schema.json "$bom_sha"
fetch spdx.schema.json "$spdx_sha"
fetch jsf-0.82.schema.json "$jsf_sha"

python3 -m venv "$work/venv"
"$work/venv/bin/pip" install --quiet jsonschema==4.23.0
"$work/venv/bin/python" - "$sbom" "$work" <<'PY'
import json, sys
from jsonschema import Draft7Validator
from referencing import Registry, Resource
from referencing.jsonschema import DRAFT7

sbom_path, work = sys.argv[1], sys.argv[2]
load = lambda name: json.load(open(f"{work}/{name}"))
bom = load("bom-1.6.schema.json")
registry = Registry().with_resources([
    (name, Resource.from_contents(load(name), default_specification=DRAFT7))
    for name in ("spdx.schema.json", "jsf-0.82.schema.json")
])
errors = sorted(
    Draft7Validator(bom, registry=registry).iter_errors(json.load(open(sbom_path))),
    key=lambda e: list(e.path),
)
for e in errors:
    print(f"validate_sbom: {'/'.join(map(str, e.path)) or '<root>'}: {e.message[:200]}", file=sys.stderr)
if errors:
    sys.exit(1)
print("validate_sbom: valid CycloneDX 1.6.")
PY
