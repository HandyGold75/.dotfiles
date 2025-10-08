#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# xterm-kitty is not often reconized but does support xterm-256color functionality.
if [ "$TERM" = "xterm-kitty" ]; then
    export TERM="xterm-256color"
fi

# Tmux
if [ -z "$TMUX" ] && [ ! "$(ps -o comm= $PPID)" = "nvim" ] && command -v tmux >/dev/null 2>&1; then
    tmux source "./.config/tmux/tmux.conf"
    if ! tmux has-session -t "Tmux";  then
        tmux new-session -d -s "Tmux";
        tmux send-keys -t "Tmux" "vi" C-m
    fi
    if tmux attach -t "Tmux"; then
        exit "$?"
    fi
    printf "\n/\\ Tmux failed to attach /\\\n"
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

# Path (Arch)
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/usr/local/go/bin" ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi
if [ -d "$HOME/venv/bin" ] ; then
    PATH="$HOME/venv/bin:$PATH"
fi
if [ -d "/opt/nvim-linux-x86_64/bin" ] ; then
    PATH="/opt/nvim-linux-x86_64/bin:$PATH"
fi

# Aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ll='ls -halF'
alias la='ls -hA'
alias du='du -h --max-depth=1'
alias shutdown='shutdown now'
alias clr='clear && fastfetch && echo'
alias wgup='sudo wg-quick up MROLP027'
alias wgdown='sudo wg-quick down MROLP027'
alias vi='nvim'
alias vim='nvim'
alias gitfs='git fetch && git status'
alias gitfp='git fetch && git pull'
alias gitac='git add . && git commit -m $(date +%d-%b-%y)'
alias gitps='git push'
alias gitpl='git pull'

# Prompt
PS1='[\u@\h ${PWD/$HOME/\~}]\$ '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME} ${PWD/$HOME/\~}\007"'

# nvm (For node installation)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FastFetch
fastfetch && echo
