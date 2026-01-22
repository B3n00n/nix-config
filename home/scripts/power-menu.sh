#!/usr/bin/env bash
# Professional power menu for NixOS with Hyprland
# Provides lock, logout, reboot, and shutdown options

set -euo pipefail

# Display power menu using wofi
selected=$(echo -e "  Lock\n  Logout\n  Reboot\n  Shutdown" | \
  wofi --dmenu --prompt "Power Menu" --width 300 --height 200 || true)

# Exit if user cancelled selection
if [ -z "$selected" ]; then
  exit 0
fi

# Execute selected action
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
