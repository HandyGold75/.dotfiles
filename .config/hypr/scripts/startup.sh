#!/bin/bash
#
#   _____ _             _
#  /  ___| |           | |
#  \ `--.| |_ __ _ _ __| |_ _   _ _ __
#   `--. \ __/ _` | '__| __| | | | '_ \.
#  /\__/ / || (_| | |  | |_| |_| | |_) |
#  \____/ \__\__,_|_|   \__|\__,_| .__/
#                                | |
#                                |_|


# Ensure only dph is running (Can be removed after remaval of xdg-desktop-portal-)
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-kde
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# export $(dbus-launch)

# Virtual Audio Cable 1 & 2 + loopback
pactl load-module module-null-sink sink_name=VAC1 sink_properties=device.description="VirtualAudioOutput1"
pactl load-module module-null-sink sink_name=VAC2 sink_properties=device.description="VirtualAudioOutput2"
pactl load-module module-loopback sink=alsa_output.usb-Logitech_G733_Gaming_Headset_0000000000000000-00.analog-stereo source=VAC1.monitor
pactl load-module module-loopback sink=alsa_output.usb-Logitech_G733_Gaming_Headset_0000000000000000-00.analog-stereo source=VAC2.monitor
