#!/bin/bash
# Conda setup script - Install Miniconda

set -e

echo "=== Conda Setup ==="

# Install Miniconda
if [ ! -d "$HOME/miniconda3" ]; then
  echo "Installing Miniconda..."
  curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
  bash /tmp/miniconda.sh -b -p "$HOME/miniconda3"
  rm /tmp/miniconda.sh
else
  echo "Miniconda already installed"
fi

# Run conda init (injects into ~/.zshrc via symlink)
"$HOME/miniconda3/bin/conda" init zsh

echo "Conda setup complete!"
echo "Note: Restart shell or run 'exec zsh' to activate conda"
