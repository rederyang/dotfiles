#!/bin/bash
# Yazi setup script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/utils.sh"

echo "=== Yazi Setup ==="

YAZI_CONFIG_DIR="$HOME/.config/yazi"
mkdir -p "$YAZI_CONFIG_DIR"

# Symlink config files
symlink "$DOTFILES_DIR/yazi/yazi.toml" "$YAZI_CONFIG_DIR/yazi.toml"
symlink "$DOTFILES_DIR/yazi/init.lua" "$YAZI_CONFIG_DIR/init.lua"
symlink "$DOTFILES_DIR/yazi/package.toml" "$YAZI_CONFIG_DIR/package.toml"

if is_macos; then
  # macOS: yazi + companion tools all via Homebrew
  echo "Installing yazi and companion tools via Homebrew..."
  pkg_install yazi fd ripgrep fzf jq poppler ffmpeg sevenzip imagemagick zoxide
else
  # Linux: companion tools via apt, zoxide + yazi via released binaries
  echo "Installing yazi companion tools..."
  sudo apt update && sudo apt install -y fd-find ripgrep fzf jq poppler-utils imagemagick

  # Install zoxide
  if ! command -v zoxide &>/dev/null; then
    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  else
    echo "zoxide already installed"
  fi

  # Install yazi
  if ! command -v yazi &>/dev/null; then
    echo "Installing yazi..."
    case "$(uname -m)" in
      x86_64)  YAZI_TARGET="yazi-x86_64-unknown-linux-gnu" ;;
      aarch64) YAZI_TARGET="yazi-aarch64-unknown-linux-gnu" ;;
      *) echo "Unsupported arch: $(uname -m)"; exit 1 ;;
    esac
    curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/${YAZI_TARGET}.zip" -o /tmp/yazi.zip
    unzip -o /tmp/yazi.zip -d /tmp/yazi
    mkdir -p "$HOME/.local/bin"
    install -m 755 "/tmp/yazi/${YAZI_TARGET}/yazi" "$HOME/.local/bin/yazi"
    rm -rf /tmp/yazi /tmp/yazi.zip
  else
    echo "yazi already installed"
  fi
fi

echo "Yazi setup complete!"
