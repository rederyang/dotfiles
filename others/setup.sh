#!/bin/bash
# Custom setup script - add your own configurations here
# Called at the end of install.sh

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Custom Setup ==="

# Add your custom steps below:
# Examples:
#   sudo apt install -y htop fzf ripgrep
#   git clone ... some tool

echo "Custom setup complete!"
