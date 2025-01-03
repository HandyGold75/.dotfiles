#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Tmux
if [ -z "$TMUX" ] && [ ! "$(ps -o comm= $PPID)" = "nvim" ] && command -v tmux >/dev/null 2>&1; then
    if [ "$TERM" = "xterm-kitty" ]; then
        export TERM="xterm-256color"
    fi
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
export LANG="en_US.utf8"
export LANGUAGE="en_US.utf8"
export LC_ALL="en_US.utf8"
# export LC_CTYPE="en_US.utf8"

# Path
export PATH="$PATH:$HOME/.local/bin:$PATH:$HOME/go/bin:/usr/local/go/bin"

# Aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ll='ls -halF'
alias la='ls -hA'
alias du='du -h --max-depth=1'
alias shutdown='shutdown now'
alias py='~/venv/bin/python3'
alias clr='clear && echo && /usr/bin/neofetch --colors 1 7 7 1 7 7 --color_blocks off'
alias wgup='sudo wg-quick up Kubu-IZO'
alias wgdown='sudo wg-quick down Kubu-IZO'
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

# Neofetch
echo && /usr/bin/neofetch --colors 1 7 7 1 7 7 --color_blocks off

