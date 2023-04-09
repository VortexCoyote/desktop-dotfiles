export ZSH="/usr/share/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"

# see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster-copland"

plugins=(
	git
	vi-mode
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# plugin settings
ZSH_AUTOSUGGEST_STRATEGY=completion

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_VISUAL=2
VI_MODE_CURSOR_INSERT=5
VI_MODE_CURSOR_OPPEND=5

KEYTIMEOUT=1 # minimize delay entering normal-mode

bindkey -M vicmd 'v' edit-command-line  # rebind 'vv' to just 'v', since visual-mode is useless
bindkey -M vicmd '^[' undefined-key # makes esc-esc work in normal-mode, don't remember why

MODE_INDICATOR="%B%K{blue}%F{black} Normal %f%k%b"
# INSERT_MODE_INDICATOR="%B%K{yellow}%F{black} Insert %f%k%b"

# sources
source $ZSH/oh-my-zsh.sh

# env
export LANG=en_US.UTF-8
export EDITOR="cvim"
export TERMINAL="alacritty"
export PATH="${PATH}:$HOME/.local/bin"

# aliases
alias grepp='grep --color -snHC 1'
alias findc='grep --color -snHC 1 -RF'
alias q=exit
