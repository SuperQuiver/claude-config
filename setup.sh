#!/bin/bash
# ~/Claude/claude-config/setup.sh
# 新しい端末で clone 後に実行して symlink を張るスクリプト

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"

echo "Setting up claude-config symlinks..."

# CONVENTIONS.md
TARGET="$SCRIPT_DIR/CONVENTIONS.md"
LINK="$CLAUDE_DIR/CONVENTIONS.md"

if [ -L "$LINK" ]; then
    echo "  Symlink already exists: $LINK -> $(readlink "$LINK")"
elif [ -f "$LINK" ]; then
    echo "  WARNING: $LINK exists as a regular file."
    echo "  Back up to $LINK.bak and replace with symlink."
    mv "$LINK" "$LINK.bak"
    ln -s "$TARGET" "$LINK"
    echo "  Created: $LINK -> $TARGET"
else
    ln -s "$TARGET" "$LINK"
    echo "  Created: $LINK -> $TARGET"
fi

echo "Done."
