#!/bin/bash
# AI tools setup script

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== AI Tools Setup ==="

# Symlink Claude Code config
mkdir -p "$HOME/.claude"
symlink "$DOTFILES_DIR/ai/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# Install Claude Code (standalone binary)
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed ($(claude --version 2>/dev/null))"
fi

echo "AI tools setup complete!"
