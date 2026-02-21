#!/bin/bash
# Shared utility functions for dotfiles setup scripts

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
