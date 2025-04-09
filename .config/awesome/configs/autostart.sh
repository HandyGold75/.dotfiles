#!/bin/sh

#   _____              __ _
#  /  __ \            / _(_)
#  | /  \/ ___  _ __ | |_ _  __ _
#  | |    / _ \| '_ \|  _| |/ _` |
#  | \__/\ (_) | | | | | | | (_| |
#   \____/\___/|_| |_|_| |_|\__, |
#                            __/ |
#                           |___/

headsetcontrol -l 0

setxkbmap -option caps:swapescape

# xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1
# sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1 &
# xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30
# sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30 &

# xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1
# sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1 &
# xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30
# sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30 &

#    ___        _            _             _
#   / _ \      | |          | |           | |
#  / /_\ \_   _| |_ ___  ___| |_ __ _ _ __| |_
#  |  _  | | | | __/ _ \/ __| __/ _` | '__| __|
#  | | | | |_| | || (_) \__ \ || (_| | |  | |_
#  \_| |_/\__,_|\__\___/|___/\__\__,_|_|   \__|
#
#

run() {
    if ! pgrep -f "$1" ;
    then
        "$@"&
    fi
}

run "nm-applet"
run "qlipper"
run "xbindkeys"
run "flameshot"
run "teams-for-linux"
run "thunderbird"
run "vivaldi"

if ! pgrep -f "dunst" ;
then
    dunst --config ~/.config/dunst/dunstrc &
fi

if ! pgrep -f "macros" ;
then
    hg macros &
fi

if ! pgrep -f "xautolock" ;
then
    xautolock -time 5 -notify 60 -detectsleep -locker "i3lock -c 000000 -i ~/.config/awesome/theme/lockscreen.png -fet" -notifier "notify-send -u critical -a XAutoLock -t 10000 xautolock 'Locking in 60 seconds'" &
fi
