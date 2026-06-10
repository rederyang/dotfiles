# dotfiles

Personal dotfiles.

Works on both **Linux** (Debian/Ubuntu, via `apt`) and **macOS** (via Homebrew).
Each module's `setup.sh`/`verify.sh` branches per OS where needed.

## Quick Start

**Linux:**

```bash
sudo apt update && sudo apt install -y git curl
git clone https://github.com/rederyang/dotfiles.git ~/dotfiles
cd ~/dotfiles && bash setup.sh
```

**macOS:**

```bash
# Install Homebrew if you don't have it yet
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Apple Silicon: load brew into the current shell (the installer also prints this)
eval "$(/opt/homebrew/bin/brew shellenv)"

git clone https://github.com/rederyang/dotfiles.git ~/dotfiles
cd ~/dotfiles && bash setup.sh
```

## What Gets Installed

| Module | Contents |
|--------|----------|
| **zsh** | Oh My Zsh, robbyrussell theme, plugins (git, z, zsh-autosuggestions, zsh-syntax-highlighting) |
| **tmux** | TPM, tmux-resurrect, tmux-continuum, mouse support |
| **git** | Editor, default branch, common aliases |
| **vim** | Line numbers, syntax highlighting, 4-space indent, mouse |
| **conda** | Miniconda3 |
| **ai** | Claude Code, Codex |
| **ghostty** | Ghostty terminal + config (macOS only, via Homebrew cask) |

## After Installation

1. Restart shell: `exec zsh`
2. Run `verify.sh` to check everything is working

## Customization

Add your own setup steps to `others/setup.sh`.

## Todo

- [x] Add yazi and its config.
- [x] Add lazygit.
