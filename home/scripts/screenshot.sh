#!/usr/bin/env bash
# Screenshot utility for Wayland
# Takes a screenshot of selected area, saves to file and copies to clipboard

set -euo pipefail

# Ensure Pictures directory exists
PICTURES_DIR="$HOME/Pictures"
mkdir -p "$PICTURES_DIR"

# Generate screenshot filename with timestamp
SCREENSHOT_FILE="$PICTURES_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"

# Take screenshot of selected area
if grim -g "$(slurp)" "$SCREENSHOT_FILE"; then
  # Copy to clipboard
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
