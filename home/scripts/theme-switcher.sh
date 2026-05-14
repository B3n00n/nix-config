#!/usr/bin/env bash
# Theme Switcher for NixOS with Hyprland

set -euo pipefail

readonly NIXOS_DIR="/etc/nixos"
readonly VARIABLES_FILE="$NIXOS_DIR/modules/variables.nix"
readonly PALETTES_DIR="$NIXOS_DIR/modules/theme/palettes"

if [[ "${1:-}" == "--rebuild" ]]; then
    echo "Rebuilding NixOS with new theme..."
    echo ""

    if sudo nixos-rebuild switch --flake "$NIXOS_DIR"; then
        echo ""
        echo "Rebuild successful! Restarting services..."

        # Belt-and-suspenders restart in case HM activation skips them.
        # `|| true` because some services (mako) are dbus-activated and have no unit.
        systemctl --user restart hyprpaper.service || true
        systemctl --user restart waybar.service    || true
        systemctl --user restart mako.service      || true

        notify-send "Theme Switched" "Theme applied successfully!" --urgency=normal
        sleep 3
    else
        echo ""
        echo "Rebuild failed! Check the errors above."
        notify-send "Theme Switch Failed" "nixos-rebuild encountered errors" --urgency=critical
        read -r
    fi
    exit 0
fi

# Discover available themes from palette files
mapfile -t palette_files < <(find "$PALETTES_DIR" -maxdepth 1 -name "*.nix" -type f 2>/dev/null | sort)

if [[ ${#palette_files[@]} -eq 0 ]]; then
    notify-send "Theme Switcher" "No palettes found in $PALETTES_DIR" --urgency=critical
    exit 1
fi

# Extract theme names from filenames (strip path and .nix extension)
themes=()
for f in "${palette_files[@]}"; do
    themes+=("$(basename "$f" .nix)")
done

# Get current theme from variables.nix (scoped to the theme block)
current_theme=$(awk '/^[[:space:]]*theme = \{/{f=1} f && /name = "/{gsub(/.*name = "/, ""); gsub(/".*/, ""); print; exit}' "$VARIABLES_FILE")

# Build wofi menu entries
menu=()
for t in "${themes[@]}"; do
    if [[ "$t" == "$current_theme" ]]; then
        menu+=("$t (current)")
    else
        menu+=("$t")
    fi
done

# Show wofi picker
selected=$(printf '%s\n' "${menu[@]}" | wofi --dmenu --prompt "Theme" --width 300 --height 200 || true)

# Exit silently if user cancelled
if [[ -z "$selected" ]]; then
    exit 0
fi

# Strip " (current)" suffix if present
selected="${selected% (current)}"

# Validate selection against available themes
valid=false
for t in "${themes[@]}"; do
    if [[ "$t" == "$selected" ]]; then
        valid=true
        break
    fi
done

if [[ "$valid" != "true" ]]; then
    notify-send "Theme Switcher" "Invalid selection: $selected" --urgency=critical
    exit 1
fi

# Check if already using this theme
if [[ "$selected" == "$current_theme" ]]; then
    notify-send "Theme Switcher" "Already using '$selected'" --urgency=normal
    exit 0
fi

# Update theme name in variables.nix (scoped to the theme = { ... }; block)
sed -i "/^[[:space:]]*theme = {/,/^[[:space:]]*};/ s/name = \".*\"/name = \"${selected}\"/" "$VARIABLES_FILE"

# Stage the change (flake reads git index, not working tree)
git -C "$NIXOS_DIR" add "$VARIABLES_FILE"

# Spawn a terminal for Phase 2 (rebuild needs sudo password + visible output).
# $TERMINAL is set by home-manager from systemVars.apps.terminal.
"${TERMINAL:-kitty}" --title "Theme Switcher - Rebuilding..." -e ~/.local/bin/theme-switcher.sh --rebuild &
disown
