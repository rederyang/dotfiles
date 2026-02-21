#!/bin/bash
# AI tools setup script

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== AI Tools Setup ==="

# Symlink Claude Code config
mkdir -p "$HOME/.claude"
symlink "$DOTFILES_DIR/ai/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
symlink "$DOTFILES_DIR/ai/settings.json" "$HOME/.claude/settings.json"

# Install Claude Code (standalone binary)
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed ($(claude --version 2>/dev/null))"
fi

# Merge .claude.json config (theme, editorMode, etc.)
"$HOME/miniconda3/bin/python3" - <<EOF
import json, os
target = os.path.expanduser("~/.claude.json")
src = "$DOTFILES_DIR/ai/.claude.json"
data = json.load(open(target)) if os.path.exists(target) else {}
data.update(json.load(open(src)))
json.dump(data, open(target, "w"), indent=2)
EOF
echo "  Merged .claude.json config"

echo "AI tools setup complete!"
