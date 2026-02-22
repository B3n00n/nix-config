# Theme Resolver
#
# Selects a palette by name, merges shared defaults, and attaches color utils.
# Palettes only need to define colors, terminal, wallpaper, and apps —
# fonts, border, and opacity come from shared defaults (overridable per-palette).
#
# Usage:
#   theme = import ./modules/theme { themeName = "tokyo-night"; };
#   theme.colors.primary              → "#33ccff"
#   theme.hexToRgba "#33ccff" "0.5"   → "rgba(51, 204, 255, 0.5)"

{ themeName }:

let
  palettes = {
    "tokyo-night" = import ./palettes/tokyo-night.nix;
    "dracula"     = import ./palettes/dracula.nix;
  };

  colorLib = import ./lib.nix;

  # Shared defaults — palettes can override any of these
  defaults = {
    fonts = {
      monospace  = "JetBrains Mono";
      sansSerif  = "Noto Sans";
      serif      = "Noto Serif";
      terminal   = "JetBrains Mono";
      size       = { normal = 11; small = 9; large = 13; };
    };

    border = {
      width  = 2;
      radius = 10;
    };

    opacity = {
      opaque          = "1.0";
      semiTransparent = "0.9";
      transparent     = "0.8";
    };
  };

  palette = palettes.${themeName}
    or (throw "Unknown theme '${themeName}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames palettes)}");

in
  defaults // palette // { inherit (colorLib) hexToRgba hexToRgb removeHash; }
