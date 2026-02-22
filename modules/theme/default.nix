# Theme Resolver
#
# Selects a palette by name, deep-merges shared defaults, and attaches color utils.
# Palettes only need to define what differs from defaults — any field they set
# (even nested ones like fonts.monospace) overrides just that field.
#
# Usage:
#   theme = import ./modules/theme { themeName = "tokyo-night"; lib = nixpkgs.lib; };
#   theme.colors.primary              → "#33ccff"
#   theme.fonts.monospace             → "JetBrains Mono" (or palette override)
#   theme.hexToRgba "#33ccff" "0.5"   → "rgba(51, 204, 255, 0.5)"

{ themeName, lib }:

let
  palettes = {
    "tokyo-night" = import ./palettes/tokyo-night.nix;
    "dracula"     = import ./palettes/dracula.nix;
  };

  colorLib = import ./lib.nix;

  # Shared defaults — palettes override any field via deep merge
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
  (lib.recursiveUpdate defaults palette) // { inherit (colorLib) hexToRgba hexToRgb removeHash; }
