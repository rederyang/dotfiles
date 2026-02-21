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
| **ai** | nvm, Node.js LTS, claude-code, codex, gemini-cli |

## After Installation

1. Restart shell: `exec zsh`
2. Fill in git identity if needed: `vim ~/.gitconfig`
3. Login to AI tools on first use: `claude` / `codex` / `gemini`

## Customization

Add your own setup steps to `scripts/others.sh`.
