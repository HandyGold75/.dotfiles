# ~/.bash_logout: executed by bash(1) when login shell exits.

# Clear on leave
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
