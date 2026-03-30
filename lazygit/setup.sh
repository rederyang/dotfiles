#!/bin/bash
# Lazygit setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Lazygit Setup ==="

# Install lazygit
if ! command -v lazygit &>/dev/null; then
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -o /tmp/lazygit.tar.gz
  tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
  mkdir -p "$HOME/.local/bin"
  install -m 755 /tmp/lazygit "$HOME/.local/bin/lazygit"
  rm -f /tmp/lazygit /tmp/lazygit.tar.gz
else
  echo "lazygit already installed"
fi

echo "Lazygit setup complete!"
