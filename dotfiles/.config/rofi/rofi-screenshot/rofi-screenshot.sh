#!/usr/bin/env bash

# rofi theme
THEME="$HOME/.config/rofi/rofi-screenshot/onedark.rasi"
SCREENSHOT_DIRECTORY="$HOME/pictures/screenshots"


get_options() {
  echo "Capture Region - Clip"
  echo "Capture Region - File"
  echo "Capture Screen - Clip"
  echo "Capture Screen - File"
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
    notify-send "Screenshot" "Select a region to capture"
    ffcast -q $(slop -n -f '-g %g ') png /tmp/screenshot_clip.png
    xclip -selection clipboard -t image/png /tmp/screenshot_clip.png
    rm /tmp/screenshot_clip.png
    notify-send "Screenshot" "Region copied to Clipboard"
    ;;
  'Capture Region - File')
    notify-send "Screenshot" "Select a region to capture"
    dt=$(date '+%d-%m-%Y %H:%M:%S')
    ffcast -q $(slop -n -f '-g %g ') png "$SCREENSHOT_DIRECTORY/$dt.png"
    notify-send "Screenshot" "Region saved to $SCREENSHOT_DIRECTORY"
    ;;
  'Capture Screen - Clip')
    ffcast -q png /tmp/screenshot_clip.png
    xclip -selection clipboard -t image/png /tmp/screenshot_clip.png
    rm /tmp/screenshot_clip.png
    notify-send "Screenshot" "Screenshot copied to Clipboard"
    ;;
  'Capture Screen -File')
    dt=$(date '+%d-%m-%Y %H:%M:%S')
    ffcast -q png "$SCREENSHOT_DIRECTORY/$dt.png"
    notify-send "Screenshot" "Screenshot saved to $SCREENSHOT_DIRECTORY"
    ;;
  esac

  # done
  set -e
}

main &

exit 0
