# Capture a selected area, save it to ~/Pictures and copy it to the clipboard.

PICTURES_DIR="$HOME/Pictures"
mkdir -p "$PICTURES_DIR"

SCREENSHOT_FILE="$PICTURES_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"

if grim -g "$(slurp)" "$SCREENSHOT_FILE"; then
  if wl-copy < "$SCREENSHOT_FILE"; then
    notify-send "Screenshot" "Saved to $SCREENSHOT_FILE and copied to clipboard" \
      --icon="$SCREENSHOT_FILE" --urgency=normal
  else
    notify-send "Screenshot" "Saved to $SCREENSHOT_FILE (clipboard copy failed)" \
      --icon="$SCREENSHOT_FILE" --urgency=normal
  fi
else
  notify-send "Screenshot Failed" "Could not capture screenshot" --urgency=critical
  exit 1
fi
