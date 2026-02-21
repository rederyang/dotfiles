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

# Install jq
if ! command -v jq &>/dev/null; then
  echo "Installing jq..."
  sudo apt update && sudo apt install -y jq
else
  echo "jq already installed"
fi

# Merge .claude.json config (theme, editorMode, etc.)
if [ -f "$HOME/.claude.json" ]; then
  jq '. * $config' \
    --argjson config "$(cat "$DOTFILES_DIR/ai/.claude.json")" \
    "$HOME/.claude.json" > /tmp/.claude.json && mv /tmp/.claude.json "$HOME/.claude.json"
  echo "  Merged .claude.json config"
else
  cp "$DOTFILES_DIR/ai/.claude.json" "$HOME/.claude.json"
  echo "  Created .claude.json config"
fi

echo "AI tools setup complete!"
