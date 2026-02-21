#!/bin/bash
# Vim setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Vim Setup ==="

# Symlink
symlink "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Install vim
if ! command -v vim &>/dev/null; then
  echo "Installing vim..."
  sudo apt update && sudo apt install -y vim
else
  echo "vim already installed"
fi

echo "Vim setup complete!"
