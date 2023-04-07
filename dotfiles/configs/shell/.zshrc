# path to your oh-my-zsh installation.
export ZSH="/home/x3tr0v/.oh-my-zsh"

# see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
	git
   	zsh-autosuggestions
	zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# user configuration
export LANG=en_US.UTF-8
export EDITOR="cvim"
export TERMINAL="alacritty"

# aliases
alias grepp='grep --color -snHC 1'
alias findc='grep --color -snHC 1 -RF'
alias q=exit
alias softlink=ln -s
