#!/bin/bash
# Yazi setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Yazi Setup ==="

YAZI_CONFIG_DIR="$HOME/.config/yazi"
mkdir -p "$YAZI_CONFIG_DIR"

# Symlink config files
symlink "$DOTFILES_DIR/yazi/yazi.toml" "$YAZI_CONFIG_DIR/yazi.toml"
symlink "$DOTFILES_DIR/yazi/init.lua" "$YAZI_CONFIG_DIR/init.lua"
symlink "$DOTFILES_DIR/yazi/package.toml" "$YAZI_CONFIG_DIR/package.toml"

# Install yazi
if ! command -v yazi &>/dev/null; then
  echo "Installing yazi..."
  sudo apt update && sudo apt install -y yazi
else
  echo "yazi already installed"
fi

echo "Yazi setup complete!"
