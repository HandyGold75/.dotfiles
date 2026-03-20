#!/bin/bash

if command -v pacman &> /dev/null; then
    wl-copy "sudo pacman -Syu && paru"
elif command -v apt &> /dev/null; then
    wl-copy "sudo apt update && sudo apt upgrade"
fi
