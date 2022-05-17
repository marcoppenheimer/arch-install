#!/usr/bin/env bash

THEME="$HOME/.config/rofi/onedark.rasi"

rofi -theme-str 'textbox-custom { expand: false; content:"🕒 '$(date +"%T")'  🔋'$(cat /sys/class/power_supply/BAT0/capacity)'";}' -no-lazy-grab -show drun -modi drun -theme "$THEME"
