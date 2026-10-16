#!/bin/sh
# Regenerates probe_artifact.json: the ABI and creation bytecode of `Probe`,
# compiled from packages/viem_dart/test/integration/fixtures/CapabilityProbes.sol
# (the one contract source; it is read from there, not copied) with the same
# settings as that package's build_probes.sh. Needs Foundry's `forge` and
# python3. Run from anywhere.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
source_sol="$here/../../../../viem_dart/test/integration/fixtures/CapabilityProbes.sol"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/src"
cp "$source_sol" "$work/src/"
cat > "$work/foundry.toml" <<'TOML'
[profile.default]
src = 'src'
solc_version = '0.8.24'
evm_version = 'paris'
optimizer = true
optimizer_runs = 200
via_ir = true
bytecode_hash = 'none'
cbor_metadata = false
TOML
out="$(cd "$work" && forge build 2>&1)" || { echo "$out" >&2; exit 1; }
forge inspect --root "$work" Probe abi --json 2>/dev/null > "$work/abi.json"
forge inspect --root "$work" Probe bytecode 2>/dev/null > "$work/bytecode.txt"
WORK="$work" OUT="$here/probe_artifact.json" python3 - <<'PY'
import json, os
w = os.environ["WORK"]
abi = json.load(open(w + "/abi.json"))
bytecode = open(w + "/bytecode.txt").read().strip()
assert bytecode.startswith("0x")
with open(os.environ["OUT"], "w") as f:
    json.dump({"contract": "Probe", "abi": abi, "bytecode": bytecode}, f, indent=2)
    f.write("\n")
PY
