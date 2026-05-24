#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-generic}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$HOME/.agile-development-skills"
cp -R "$ROOT_DIR/skills" "$HOME/.agile-development-skills/"
cp -R "$ROOT_DIR/data" "$HOME/.agile-development-skills/"

cat <<EOF
Installed agile-development-skills for: $TARGET

Installed files:
  ~/.agile-development-skills/skills
  ~/.agile-development-skills/data

Next step:
Ask your coding agent to load or install skills from:
  ~/.agile-development-skills/skills
EOF
