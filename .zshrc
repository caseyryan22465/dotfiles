# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=4000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/casey/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# dotfile git
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# basic command aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alh --group-directories-first --color=auto'
