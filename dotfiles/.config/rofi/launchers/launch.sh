#!/usr/bin/env bash

theme="onedark"
dir="$HOME/.config/rofi/launchers"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
