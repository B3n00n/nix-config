# Lock / logout / reboot / shutdown picker.

selected=$(printf '%s\n' "  Lock" "  Logout" "  Reboot" "  Shutdown" |
  wofi --dmenu --prompt "Power Menu" --width 300 --height 200 || true)

if [ -z "$selected" ]; then
  exit 0
fi

case $selected in
  *Lock)
    hyprlock || notify-send "Error" "Failed to lock screen" --urgency=critical
    ;;
  *Logout)
    hyprctl dispatch exit || notify-send "Error" "Failed to logout" --urgency=critical
    ;;
  *Reboot)
    systemctl reboot || notify-send "Error" "Failed to reboot" --urgency=critical
    ;;
  *Shutdown)
    systemctl poweroff || notify-send "Error" "Failed to shutdown" --urgency=critical
    ;;
  *)
    notify-send "Error" "Unknown option selected" --urgency=normal
    ;;
esac
