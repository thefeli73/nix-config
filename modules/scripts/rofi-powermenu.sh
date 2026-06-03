set -euo pipefail

if pgrep -x rofi >/dev/null; then
  pkill -x rofi
  exit 0
fi

theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/powermenu-type1-style1-gruvbox.rasi"
theme_args=()

if [[ -r "$theme" ]]; then
  theme_args=(-theme "$theme")
fi

rofi_args=(
  -dmenu
  -no-sort
  -no-custom
  "${theme_args[@]}"
)

user_name="${USER:-$(whoami)}"
host_name="$(hostname)"
user_host="${user_name}@${host_name}"
uptime_text="$(uptime -p | sed 's/^up //')"

lock=' Lock'
suspend=' Suspend'
logout=' Logout'
reboot=' Reboot'
shutdown=' Shutdown'

yes=' Yes'
no=' No'

confirm() {
  local answer
  answer="$(printf '%s\n%s\n' "$yes" "$no" | rofi \
    "${rofi_args[@]}" \
    -p 'Confirmation' \
    -mesg 'Are you sure?' \
    -theme-str 'window { width: 250px; }' \
    -theme-str 'listview { columns: 2; lines: 1; }' \
    -theme-str 'element-text { horizontal-align: 0.5; }')" || return 1

  [[ "$answer" == "$yes" ]]
}

choice="$(printf '%s\n%s\n%s\n%s\n%s\n' \
  "$lock" \
  "$suspend" \
  "$logout" \
  "$reboot" \
  "$shutdown" | rofi \
  "${rofi_args[@]}" \
  -p "$user_host" \
  -mesg "Uptime: $uptime_text")" || exit 0

case "$choice" in
  "$lock")
    exec hyprlock
    ;;
  "$suspend")
    exec systemctl suspend
    ;;
  "$logout")
    if confirm; then
      exec hyprctl dispatch exit
    fi
    ;;
  "$reboot")
    if confirm; then
      exec systemctl reboot
    fi
    ;;
  "$shutdown")
    if confirm; then
      exec systemctl poweroff
    fi
    ;;
esac
