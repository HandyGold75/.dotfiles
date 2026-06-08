#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# xterm-kitty is not often reconized but does support xterm-256color functionality.
if [ "$TERM" = "xterm-kitty" ]; then
    export TERM="xterm-256color"
fi

# FastFetch
if [ "$(hostname)" != "SV05" ] && [ ! "$(ps -o comm= $PPID)" = "nvim" ]; then
    ( (fastfetch && echo) &)
fi

# History file
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=2000
HISTFILESIZE=4000

# Check the window size after each command and, if necessary; update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Bash completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Language
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "/opt/nvim-linux-x86_64/bin" ] && PATH="/opt/nvim-linux-x86_64/bin:$PATH"
[ -d "/usr/local/go/bin" ] && PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.venv/bin" ] && PATH="$HOME/.venv/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias du='du -h --max-depth=1'
alias clr='clear && fastfetch && echo'
alias wgup='sudo wg-quick up WG'
alias wgdown='sudo wg-quick down WG'

alias vi='nvim'
alias gitfs='git fetch && git status'
alias gitfp='git fetch && git pull'
alias gitac='git add . && git commit -m $(date +%d-%b-%y)'
alias gitps='git push'
alias gitpl='git pull'

# Prompt
PS1='[\u@\h ${PWD/$HOME/\~}]\$ '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME} ${PWD/$HOME/\~}\007"'

# Dev
if [ "$(hostname)" = "Dev" ] && [ ! "$(ps -o comm= $PPID)" = "nvim" ]; then
    nvim
    exit
fi
