#!/bin/sh

# Device config
headsetcontrol -l 0

xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1
sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Profile Enabled" 0 1 &
xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30
sleep 5 && xinput set-prop "Logitech MX Master 3S" "libinput Accel Speed" -0.30 &

xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1
sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Profile Enabled" 0 1 &
xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30
sleep 5 && xinput set-prop "MX Master 3S" "libinput Accel Speed" -0.30 &

# Autostart
run() {
    if ! pgrep -f "$1" ;
    then
        "$@"&
    fi
}

echo "--- running applications ---" >> ~/.xsession-errors

run "teams-for-linux"
run "thunderbird"
run "vivaldi"
run "yakuake"

if ! pgrep -f "dunst" ;
then
    dunst --config ~/.config/dunst/dunstrc &
fi

if ! pgrep -f "macros" ;
then
    st macros &
fi

if ! pgrep -f "solaar" ;
then
    solaar -w hide &
fi

if ! pgrep -f "xautolock" ;
then
    xautolock -time 5 -notify 60 -detectsleep -locker "i3lock -c 000000 -i /home/ianzoontjens/.config/wallpapers/lockscreen/DI-Background-Fill.png -ft" -notifier "notify-send -a xautolock -u critical -t 10000 xautolock 'Locking in 60 seconds'" &
fi

if ! pgrep -f "xbindkeys" ;
then
    xbindkeys
fi

