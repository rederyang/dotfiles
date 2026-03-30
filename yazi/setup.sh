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

# Install companion tools
echo "Installing yazi companion tools..."
sudo apt update && sudo apt install -y fd-find ripgrep fzf jq poppler-utils imagemagick

# Install zoxide
if ! command -v zoxide &>/dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "zoxide already installed"
fi

# Install yazi
if ! command -v yazi &>/dev/null; then
  echo "Installing yazi..."
  curl -fsSL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip -o /tmp/yazi.zip
  unzip -o /tmp/yazi.zip -d /tmp/yazi
  mkdir -p "$HOME/.local/bin"
  install -m 755 /tmp/yazi/yazi-x86_64-unknown-linux-gnu/yazi "$HOME/.local/bin/yazi"
  rm -rf /tmp/yazi /tmp/yazi.zip
else
  echo "yazi already installed"
fi

echo "Yazi setup complete!"
