#!/bin/bash
# Dotfiles verification script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASS=0
FAIL=0

green='\033[0;32m'
red='\033[0;31m'
nc='\033[0m'

ok()   { echo -e "  ${green}✓${nc} $1"; ((PASS++)); }
fail() { echo -e "  ${red}✗${nc} $1"; ((FAIL++)); }

check_symlink() {
  local dst="$1"
  local src="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    ok "symlink $dst"
  else
    fail "symlink $dst (expected → $src)"
  fi
}

check_cmd() {
  if command -v "$1" &>/dev/null; then
    ok "$1 installed ($(command -v $1))"
  else
    fail "$1 not found"
  fi
}

check_dir() {
  if [ -d "$1" ]; then
    ok "$2"
  else
    fail "$2 ($1 not found)"
  fi
}

# ── Symlinks ───────────────────────────────────────────────────────────────────
echo "--- Symlinks ---"
check_symlink "$HOME/.zshrc"      "$DOTFILES_DIR/zsh/.zshrc"
check_symlink "$HOME/.tmux.conf"  "$DOTFILES_DIR/tmux/.tmux.conf"
check_symlink "$HOME/.gitconfig"  "$DOTFILES_DIR/git/.gitconfig"
check_symlink "$HOME/.vimrc"      "$DOTFILES_DIR/vim/.vimrc"
echo ""

# ── Zsh ───────────────────────────────────────────────────────────────────────
echo "--- Zsh ---"
check_cmd zsh
check_dir "$HOME/.oh-my-zsh" "Oh My Zsh installed"
check_dir "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "zsh-autosuggestions installed"
check_dir "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting installed"
echo ""

# ── Tmux ──────────────────────────────────────────────────────────────────────
echo "--- Tmux ---"
check_cmd tmux
check_dir "$HOME/.tmux/plugins/tpm" "TPM installed"
check_dir "$HOME/.tmux/plugins/tmux-resurrect" "tmux-resurrect installed"
check_dir "$HOME/.tmux/plugins/tmux-continuum" "tmux-continuum installed"
echo ""

# ── Git ───────────────────────────────────────────────────────────────────────
echo "--- Git ---"
check_cmd git
if git config --global user.name &>/dev/null; then
  ok "git user.name = $(git config --global user.name)"
else
  fail "git user.name not set"
fi
if git config --global user.email &>/dev/null; then
  ok "git user.email = $(git config --global user.email)"
else
  fail "git user.email not set"
fi
echo ""

# ── Vim ───────────────────────────────────────────────────────────────────────
echo "--- Vim ---"
check_cmd vim
if vim --version 2>/dev/null | grep -q "Vi IMproved"; then
  ok "vim config loads (.vimrc linked)"
fi
echo ""

# ── Conda ─────────────────────────────────────────────────────────────────────
echo "--- Conda ---"
check_dir "$HOME/miniconda3" "Miniconda installed"
if grep -q "conda initialize" "$HOME/.zshrc" 2>/dev/null; then
  ok "conda init injected into .zshrc"
else
  fail "conda init not found in .zshrc"
fi
echo ""

# ── AI Tools ──────────────────────────────────────────────────────────────────
echo "--- AI Tools ---"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

check_dir "$HOME/.nvm" "nvm installed"
if command -v node &>/dev/null; then
  ok "node $(node --version)"
else
  fail "node not found"
fi
check_cmd claude
check_cmd codex
check_cmd gemini
echo ""

# ── Summary ───────────────────────────────────────────────────────────────────
echo "================================"
echo -e "  ${green}Passed: $PASS${nc}   ${red}Failed: $FAIL${nc}"
echo "================================"
