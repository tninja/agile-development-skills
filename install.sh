#!/bin/bash
# Claude Code installer for agile development agent skills.
# Copies skills into the user or project Claude Code skills directory.
# Usage: ./install.sh [--project /path/to/project]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

if [ "$1" = "--project" ] && [ -n "$2" ]; then
    TARGET_DIR="$2/.claude/skills"
    echo "Installing to project: $TARGET_DIR"
else
    TARGET_DIR="$HOME/.claude/skills"
    echo "Installing to user skills: $TARGET_DIR"
fi

mkdir -p "$TARGET_DIR"

for skill in "$SKILLS_SRC"/*.md; do
    name=$(basename "$skill")
    cp "$skill" "$TARGET_DIR/$name"
    echo "  installed: $name"
done

echo ""
echo "Done. Skills installed to: $TARGET_DIR"
echo "Available skills: refactoring, tdd, code-review"
