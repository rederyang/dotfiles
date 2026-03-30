#!/bin/bash
# Lazygit setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Lazygit Setup ==="

# Install lazygit
if ! command -v lazygit &>/dev/null; then
  echo "Installing lazygit..."
  sudo apt update && sudo apt install -y lazygit
else
  echo "lazygit already installed"
fi

echo "Lazygit setup complete!"
