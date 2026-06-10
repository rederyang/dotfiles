#!/bin/bash
# Conda setup script - Install Miniconda

set -e

echo "=== Conda Setup ==="

# Pick the right installer for this OS/arch
case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)        MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh" ;;
  Linux-aarch64)       MINICONDA_INSTALLER="Miniconda3-latest-Linux-aarch64.sh" ;;
  Darwin-arm64)        MINICONDA_INSTALLER="Miniconda3-latest-MacOSX-arm64.sh" ;;
  Darwin-x86_64)       MINICONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh" ;;
  *) echo "Unsupported platform: $(uname -s)-$(uname -m)"; exit 1 ;;
esac

# Install Miniconda
if [ ! -d "$HOME/miniconda3" ]; then
  echo "Installing Miniconda ($MINICONDA_INSTALLER)..."
  curl -fsSL "https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER" -o /tmp/miniconda.sh
  bash /tmp/miniconda.sh -b -p "$HOME/miniconda3"
  rm /tmp/miniconda.sh
else
  echo "Miniconda already installed"
fi

# Run conda init (injects into ~/.zshrc via symlink)
"$HOME/miniconda3/bin/conda" init zsh

echo "Conda setup complete!"
echo "Note: Restart shell or run 'exec zsh' to activate conda"
