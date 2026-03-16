#!/bin/bash
# ~/Claude/claude-config/setup.sh
# 新しい端末で clone 後に実行して symlink を張るスクリプト
# symlink は相対パスで作成するため、どの端末でも動作する

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"
# リポのディレクトリ名（相対パス用）
REPO_DIRNAME="$(basename "$SCRIPT_DIR")"

echo "Setting up claude-config symlinks..."

# CONVENTIONS.md（相対パスで symlink を作成）
REL_TARGET="$REPO_DIRNAME/CONVENTIONS.md"
LINK="$CLAUDE_DIR/CONVENTIONS.md"

if [ -L "$LINK" ]; then
    echo "  Symlink already exists: $LINK -> $(readlink "$LINK")"
elif [ -f "$LINK" ]; then
    echo "  WARNING: $LINK exists as a regular file."
    echo "  Back up to $LINK.bak and replace with symlink."
    mv "$LINK" "$LINK.bak"
    ln -s "$REL_TARGET" "$LINK"
    echo "  Created: $LINK -> $REL_TARGET"
else
    ln -s "$REL_TARGET" "$LINK"
    echo "  Created: $LINK -> $REL_TARGET"
fi

echo "Done."
