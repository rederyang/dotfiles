#!/bin/bash
# Git setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Git Setup ==="

# Symlink
symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Install git
if ! command -v git &>/dev/null; then
  echo "Installing git..."
  sudo apt update && sudo apt install -y git
else
  echo "git already installed"
fi

echo "Git setup complete!"
