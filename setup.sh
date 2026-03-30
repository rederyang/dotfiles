#!/bin/bash
# Dotfiles install script
# Safe to run multiple times

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Dotfiles Installation ==="
echo "Source: $DOTFILES_DIR"
echo ""

echo "[1/8] Zsh"
bash "$DOTFILES_DIR/zsh/setup.sh"
echo ""

echo "[2/8] Vim"
bash "$DOTFILES_DIR/vim/setup.sh"
echo ""

echo "[3/8] Tmux"
bash "$DOTFILES_DIR/tmux/setup.sh"
echo ""

echo "[4/8] Git"
bash "$DOTFILES_DIR/git/setup.sh"
echo ""

echo "[5/8] Conda"
bash "$DOTFILES_DIR/conda/setup.sh"
echo ""

echo "[6/8] AI tools"
bash "$DOTFILES_DIR/ai/setup.sh"
echo ""

echo "[7/8] Yazi"
bash "$DOTFILES_DIR/yazi/setup.sh"
echo ""

echo "[8/8] Lazygit"
bash "$DOTFILES_DIR/lazygit/setup.sh"
echo ""

bash "$DOTFILES_DIR/others/setup.sh"
echo ""

echo "=== Installation complete ==="
echo ""
echo "Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Run verify.sh to check everything is working"
