#!/usr/bin/env bash
# Zip each asm* folder in the project root, excluding any 'archive' subfolder.
# Usage: ./zip_asm_folders.sh [output_dir]
# Default output_dir is project root.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
OUT_DIR="${1:-$SCRIPT_DIR}"

for dir in asm*/; do
  [ -d "$dir" ] || continue
  name="${dir%/}"
  zipname="$OUT_DIR/${name}.zip"
  echo "Creating $zipname (excluding archive/) ..."
  zip -r "$zipname" "$name" -x "$name/archive/*" -x "$name/archive"
done

echo "Done."
