#!/bin/bash
# Dotfiles install script
# Safe to run multiple times

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure ~/.local/bin exists and is in PATH
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

echo "=== Dotfiles Installation ==="
echo "Source: $DOTFILES_DIR"
echo ""

echo "[1/9] Zsh"
bash "$DOTFILES_DIR/zsh/setup.sh"
echo ""

echo "[2/9] Vim"
bash "$DOTFILES_DIR/vim/setup.sh"
echo ""

echo "[3/9] Tmux"
bash "$DOTFILES_DIR/tmux/setup.sh"
echo ""

echo "[4/9] Git"
bash "$DOTFILES_DIR/git/setup.sh"
echo ""

echo "[5/9] Conda"
bash "$DOTFILES_DIR/conda/setup.sh"
echo ""

echo "[6/9] AI tools"
bash "$DOTFILES_DIR/ai/setup.sh"
echo ""

echo "[7/9] Yazi"
bash "$DOTFILES_DIR/yazi/setup.sh"
echo ""

echo "[8/9] Lazygit"
bash "$DOTFILES_DIR/lazygit/setup.sh"
echo ""

echo "[9/9] Ghostty (macOS only)"
bash "$DOTFILES_DIR/ghostty/setup.sh"
echo ""

bash "$DOTFILES_DIR/others/setup.sh"
echo ""

echo "=== Installation complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Run verify.sh to check everything is working"
