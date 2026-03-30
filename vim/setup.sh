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

# Install vim-commentary plugin
COMMENTARY_DIR="$HOME/.vim/pack/plugins/start/vim-commentary"
if [ -d "$COMMENTARY_DIR" ]; then
  echo "vim-commentary already installed"
else
  echo "Installing vim-commentary..."
  mkdir -p "$HOME/.vim/pack/plugins/start"
  git clone https://github.com/tpope/vim-commentary.git "$COMMENTARY_DIR"
fi

echo "Vim setup complete!"
