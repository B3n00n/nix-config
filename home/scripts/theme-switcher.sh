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

mapfile -t palette_files < <(find "$PALETTES_DIR" -maxdepth 1 -name "*.nix" -type f 2>/dev/null | sort)

if [[ ${#palette_files[@]} -eq 0 ]]; then
    notify-send "Theme Switcher" "No palettes found in $PALETTES_DIR" --urgency=critical
    exit 1
fi

themes=()
for f in "${palette_files[@]}"; do
    themes+=("$(basename "$f" .nix)")
done

current_theme=$(awk '/^[[:space:]]*theme[[:space:]]*=[[:space:]]*\{/{f=1} f && /name[[:space:]]*=[[:space:]]*"/{sub(/^.*name[[:space:]]*=[[:space:]]*"/, ""); sub(/".*/, ""); print; exit}' "$VARIABLES_FILE")

menu=()
for t in "${themes[@]}"; do
    if [[ "$t" == "$current_theme" ]]; then
        menu+=("$t (current)")
    else
        menu+=("$t")
    fi
done

selected=$(printf '%s\n' "${menu[@]}" | wofi --dmenu --prompt "Theme" --width 300 --height 200 || true)

if [[ -z "$selected" ]]; then
    exit 0
fi

selected="${selected% (current)}"

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

if [[ "$selected" == "$current_theme" ]]; then
    notify-send "Theme Switcher" "Already using '$selected'" --urgency=normal
    exit 0
fi

sed -i -E "/^[[:space:]]*theme[[:space:]]*=[[:space:]]*\{/,/^[[:space:]]*\};/ s/(name[[:space:]]*=[[:space:]]*\")[^\"]*(\")/\1${selected}\2/" "$VARIABLES_FILE"

git -C "$NIXOS_DIR" add "$VARIABLES_FILE"
"${TERMINAL:-kitty}" --title "Theme Switcher - Rebuilding..." -e "$0" --rebuild &
disown
