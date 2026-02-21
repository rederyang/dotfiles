#!/bin/bash
# Dotfiles install script
# Safe to run multiple times

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Dotfiles Installation ==="
echo "Source: $DOTFILES_DIR"
echo ""

# ── Symlink helper ─────────────────────────────────────────────────────────────
symlink() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst → $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  Already linked: $dst"
    return
  fi

  ln -sf "$src" "$dst"
  echo "  Linked: $dst → $src"
}

# ── Step 1: Symlinks (before setup scripts, so nvm can inject into .zshrc) ────
echo "--- Symlinking dotfiles ---"
symlink "$DOTFILES_DIR/zsh/.zshrc"       "$HOME/.zshrc"
symlink "$DOTFILES_DIR/tmux/.tmux.conf"  "$HOME/.tmux.conf"
symlink "$DOTFILES_DIR/git/.gitconfig"   "$HOME/.gitconfig"
symlink "$DOTFILES_DIR/vim/.vimrc"       "$HOME/.vimrc"
echo ""

# ── Step 2: Run setup scripts ──────────────────────────────────────────────────
echo "--- Running setup scripts ---"

echo "[1/4] Zsh"
bash "$DOTFILES_DIR/zsh/setup.sh"
echo ""

echo "[2/4] Tmux"
bash "$DOTFILES_DIR/tmux/setup.sh"
echo ""

echo "[3/4] AI tools"
bash "$DOTFILES_DIR/ai/setup.sh"
echo ""

echo "[4/4] Custom"
bash "$DOTFILES_DIR/scripts/others.sh"
echo ""

# ── Done ───────────────────────────────────────────────────────────────────────
echo "=== Installation complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Open tmux and plugins will be auto-installed"
echo "  3. Run OAuth login for AI tools: claude / codex / gemini"
