# dotfiles

Personal dotfiles.

## Quick Start

```bash
git clone https://github.com/rederyang/dotfiles.git ~/dotfiles
cd ~/dotfiles && bash install.sh
```

## What Gets Installed

| Module | Contents |
|--------|----------|
| **zsh** | Oh My Zsh, robbyrussell theme, plugins (git, z, zsh-autosuggestions, zsh-syntax-highlighting) |
| **tmux** | TPM, tmux-resurrect, tmux-continuum, mouse support |
| **git** | Editor, default branch, common aliases |
| **vim** | Line numbers, syntax highlighting, 4-space indent, mouse |
| **conda** | Miniconda3 |
| **ai** | Claude Code |

## After Installation

1. Restart shell: `exec zsh`
2. Run `verify.sh` to check everything is working

## Customization

Add your own setup steps to `others/setup.sh`.
