#!/usr/bin/env bash

theme="onedark"
dir="$HOME/.config/rofi/launchers"

rofi -theme-str 'textbox-custom { expand: false; content:"🕒 '$(date +"%T")'  🔋'$(cat /sys/class/power_supply/BAT0/capacity)'";}' -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
