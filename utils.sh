#!/bin/bash
# Shared utility functions for dotfiles setup scripts

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# OS detection
case "$(uname -s)" in
  Darwin) OS="macos" ;;
  Linux)  OS="linux" ;;
  *)      OS="unknown" ;;
esac

is_macos() { [ "$OS" = "macos" ]; }
is_linux() { [ "$OS" = "linux" ]; }

# Install one or more packages with the platform's package manager.
# macOS -> Homebrew, Linux -> apt. Package names must match on both;
# for packages named differently per platform, branch in the module instead.
pkg_install() {
  if is_macos; then
    if ! command -v brew &>/dev/null; then
      echo "  Homebrew not found; install it first (https://brew.sh), then re-run."
      return 1
    fi
    brew install "$@"
  elif is_linux; then
    sudo apt update && sudo apt install -y "$@"
  else
    echo "  Unsupported OS ($(uname -s)); cannot install: $*"
    return 1
  fi
}

symlink() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst → $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  Already linked: $dst"
    return
  fi

  ln -sf "$src" "$dst"
  echo "  Linked: $dst → $src"
}
