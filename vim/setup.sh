#!/bin/bash
# Vim setup script

echo "=== Vim Setup ==="

if ! command -v vim &>/dev/null; then
  echo "Installing vim..."
  sudo apt update && sudo apt install -y vim
else
  echo "vim already installed"
fi

echo "Vim setup complete!"
