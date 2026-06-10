#!/bin/bash
# Git setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Git Setup ==="

# Symlink
symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Install git (preinstalled on macOS via Xcode CLT)
if ! command -v git &>/dev/null; then
  echo "Installing git..."
  pkg_install git
else
  echo "git already installed"
fi

echo "Git setup complete!"
