#!/usr/bin/env bash
# Copies the generated/authored data files from the sibling
# Caltech-Course-Tooltip repo into this repo, ready to commit + push.
#
# Usage (after regenerating data in the main repo, e.g. via
# tools/merge_data.py, or after hand-editing popup-content.json there):
#
#   ./sync.sh
#   git add -A
#   git commit -m "Update catalog data"
#   git push
#
# GitHub Pages picks up the push within a minute or two — no separate
# cache-purge step needed.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO="$SCRIPT_DIR/../Caltech-Course-Tooltip"

if [ ! -d "$MAIN_REPO" ]; then
  echo "Expected the main repo at $MAIN_REPO — not found." >&2
  exit 1
fi

for f in catalog.json course-codes.json popup-content.json; do
  src="$MAIN_REPO/extension/data/$f"
  if [ ! -f "$src" ]; then
    echo "Missing $src — skipping $f." >&2
    continue
  fi
  cp "$src" "$SCRIPT_DIR/$f"
  echo "Synced $f"
done
