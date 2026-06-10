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

  # Install yazi and its package manager.
  if ! command -v yazi &>/dev/null || ! command -v ya &>/dev/null; then
    echo "Installing yazi and ya..."
    case "$(uname -m)" in
      x86_64)  YAZI_TARGET="yazi-x86_64-unknown-linux-gnu" ;;
      aarch64) YAZI_TARGET="yazi-aarch64-unknown-linux-gnu" ;;
      *) echo "Unsupported arch: $(uname -m)"; exit 1 ;;
    esac
    curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/${YAZI_TARGET}.zip" -o /tmp/yazi.zip
    unzip -o /tmp/yazi.zip -d /tmp/yazi
    mkdir -p "$HOME/.local/bin"
    install -m 755 "/tmp/yazi/${YAZI_TARGET}/yazi" "$HOME/.local/bin/yazi"
    install -m 755 "/tmp/yazi/${YAZI_TARGET}/ya" "$HOME/.local/bin/ya"
    rm -rf /tmp/yazi /tmp/yazi.zip
  else
    echo "yazi and ya already installed"
  fi
fi

if command -v ya &>/dev/null; then
  YA_BIN="$(command -v ya)"
elif [ -x "$HOME/.local/bin/ya" ]; then
  YA_BIN="$HOME/.local/bin/ya"
else
  echo "ya not found; cannot install Yazi plugins"
  exit 1
fi

echo "Installing Yazi plugins..."
"$YA_BIN" pkg install

echo "Yazi setup complete!"
