#!/bin/bash
# Lazygit setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Lazygit Setup ==="

# Install lazygit
if command -v lazygit &>/dev/null; then
  echo "lazygit already installed"
elif is_macos; then
  echo "Installing lazygit..."
  pkg_install lazygit
else
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
  case "$(uname -m)" in
    x86_64)  LAZYGIT_ARCH="Linux_x86_64" ;;
    aarch64) LAZYGIT_ARCH="Linux_arm64" ;;
    *) echo "Unsupported arch: $(uname -m)"; exit 1 ;;
  esac
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_${LAZYGIT_ARCH}.tar.gz" -o /tmp/lazygit.tar.gz
  tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
  mkdir -p "$HOME/.local/bin"
  install -m 755 /tmp/lazygit "$HOME/.local/bin/lazygit"
  rm -f /tmp/lazygit /tmp/lazygit.tar.gz
fi

echo "Lazygit setup complete!"
