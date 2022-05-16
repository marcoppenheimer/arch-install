#!/usr/bin/env bash

# rofi theme
THEME="$HOME/.config/rofi/rofi-screenshot/onedark.rasi"
SCREENSHOT_DIRECTORY="$HOME/pictures/screenshots"


get_options() {
  echo "Capture Region - Clip"
  echo "Capture Region - File"
}

main() {

  # Get choice from rofi
  choice=$( (get_options) | rofi -dmenu -i -fuzzy -p "📷" -theme "$THEME")

  # If user has not picked anything, exit
  if [[ -z "${choice// /}" ]]; then
    exit 1
  fi

  # run the selected command
  case $choice in
  'Capture Region - Clip')
    maim -s > /tmp/screenshot_clip.png
    xclip -selection clipboard -t image/png /tmp/screenshot_clip.png
    rm /tmp/screenshot_clip.png
    ;;
  'Capture Region - File')
    dt=$(date '+%d-%m-%Y %H:%M:%S')
    maim -s > "$SCREENSHOT_DIRECTORY/$dt.png"
    ;;
  esac

  # done
  set -e
}

main &

exit 0
