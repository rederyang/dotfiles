#!/bin/bash
# Ghostty setup script (macOS only)

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Ghostty Setup ==="

# Ghostty here is a macOS GUI terminal; skip on other platforms.
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Not macOS, skipping Ghostty."
  exit 0
fi

# Symlink config. Ghostty reads ~/.config/ghostty/config on macOS too (XDG),
# so this keeps the path portable.
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"
symlink "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"

# Install Ghostty via Homebrew cask
if [ -d "/Applications/Ghostty.app" ] || command -v ghostty &>/dev/null; then
  echo "Ghostty already installed"
elif command -v brew &>/dev/null; then
  echo "Installing Ghostty..."
  brew install --cask ghostty
else
  echo "Homebrew not found; install it first (https://brew.sh) or download Ghostty manually."
fi

echo "Ghostty setup complete!"
