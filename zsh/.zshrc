# Environment
export EDITOR=vim
export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions highlight color (default fg=8 is too dark)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=246"

# Bindkey
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

export TERM=xterm-256color

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	local cwd
	cwd="$(cat -- "$tmp")"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
	rm -f -- "$tmp"
}
