#!/bin/bash
# Tmux setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Tmux Setup ==="

# Symlink
symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install tmux
if ! command -v tmux &>/dev/null; then
  echo "Installing tmux..."
  sudo apt update && sudo apt install -y tmux
else
  echo "tmux already installed"
fi

# Install TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "TPM already installed"
fi

# Auto-install all plugins
echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "Tmux setup complete!"
