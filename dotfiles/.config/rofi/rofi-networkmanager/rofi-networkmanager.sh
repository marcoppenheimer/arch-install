THEME="$HOME/.config/rofi/onedark.rasi"

LIST=$(nmcli --get-values SSID dev wifi list | sed '/^$/d' | sort -u)
KNOWNCON=$(nmcli connection show)
CONSTATE=$(nmcli -fields WIFI g)
CURRSSID=$(LANGUAGE=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

if [[ ! -z $CURRSSID ]]; then
    HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}')")
fi

CHENTRY=$(echo -e "$LIST" | rofi -dmenu -p "🌏" -a "$HIGHLINE" -theme-str 'entry { placeholder: "Enter SSID"; }' -theme "$THEME")
CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')


if [ "$CHSSID" = "*" ]; then
    CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
fi

if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
    nmcli con up "$CHSSID"
else
    WIFIPASS=$(echo "" | rofi -dmenu -theme-str 'entry { placeholder: "Enter Password"; }' -p "🔒" -theme "$THEME" )
    nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
fi

