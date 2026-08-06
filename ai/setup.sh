#!/bin/bash
# AI tools setup script

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== AI Tools Setup ==="

# Symlink Claude Code config
CLAUDE_CONFIG_DIR="$DOTFILES_DIR/ai/claude_code"
mkdir -p "$HOME/.claude"
symlink "$CLAUDE_CONFIG_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
symlink "$CLAUDE_CONFIG_DIR/settings.json" "$HOME/.claude/settings.json"
symlink "$CLAUDE_CONFIG_DIR/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
chmod +x "$CLAUDE_CONFIG_DIR/statusline-command.sh"

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
src = "$CLAUDE_CONFIG_DIR/.claude.json"
data = json.load(open(target)) if os.path.exists(target) else {}
data.update(json.load(open(src)))
json.dump(data, open(target, "w"), indent=2)
EOF
echo "  Merged .claude.json config"

# Install Codex
if ! command -v codex &>/dev/null; then
  echo "Installing Codex..."
  curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
else
  echo "Codex already installed ($(codex --version 2>/dev/null))"
fi

# Merge Codex TUI config (status line, theme)
mkdir -p "$HOME/.codex"
"$HOME/miniconda3/bin/python3" - <<EOF
import os, re
target = os.path.expanduser("~/.codex/config.toml")
src = "$DOTFILES_DIR/ai/codex/config.toml"
data = open(target).read() if os.path.exists(target) else ""
config = open(src).read().strip()
pattern = r"(?ms)^\[tui\]\s*\n.*?(?=^\[|\Z)"
data = re.sub(pattern, config + "\n\n", data, count=1) if re.search(pattern, data) else data.rstrip() + ("\n\n" if data.strip() else "") + config + "\n"
open(target, "w").write(data)
EOF
echo "  Merged Codex config"

echo "AI tools setup complete!"
