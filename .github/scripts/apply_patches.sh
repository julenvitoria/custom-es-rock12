#!/usr/bin/env bash
# Apply every *.patch directly inside the given directory (not subfolders) to
# the current git checkout. Stops with a GitHub Actions error if one no longer
# applies, so a stale patch never produces a silently different build.
# Usage: apply_patches.sh <patch-dir>
set -euo pipefail
dir=$1
for p in "$dir"/*.patch; do
    [ -e "$p" ] || continue
    if ! git apply --check "$p"; then
        echo "::error::$(basename "$p") no longer applies to upstream; update it."
        exit 1
    fi
    git apply "$p"
    echo "Applied $(basename "$p")"
done
