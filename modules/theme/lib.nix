# Color utility functions for the theme system
#
# Nix has no hex-parsing builtins, so we convert via lookup table.
#
# Usage:
#   lib = import ./lib.nix;
#   lib.hexToRgba "#33ccff" "0.15"  → "rgba(51, 204, 255, 0.15)"
#   lib.hexToRgb  "#33ccff"         → "rgb(51, 204, 255)"
#   lib.removeHash "#33ccff"        → "33ccff"

let
  hexDigits = {
    "0" = 0;  "1" = 1;  "2" = 2;  "3" = 3;
    "4" = 4;  "5" = 5;  "6" = 6;  "7" = 7;
    "8" = 8;  "9" = 9;
    "a" = 10; "b" = 11; "c" = 12; "d" = 13; "e" = 14; "f" = 15;
    "A" = 10; "B" = 11; "C" = 12; "D" = 13; "E" = 14; "F" = 15;
  };

  hexByteToInt = hex:
    (hexDigits.${builtins.substring 0 1 hex}) * 16
    + hexDigits.${builtins.substring 1 1 hex};

  # Strip leading "#" if present
  removeHash = hex:
    if builtins.substring 0 1 hex == "#"
    then builtins.substring 1 (-1) hex
    else hex;

  # Parse "#rrggbb" into { r, g, b } integers
  parseHex = hex:
    let clean = removeHash hex; in {
      r = hexByteToInt (builtins.substring 0 2 clean);
      g = hexByteToInt (builtins.substring 2 2 clean);
      b = hexByteToInt (builtins.substring 4 2 clean);
    };

in {
  inherit removeHash;

  # "#rrggbb" → "rgba(r, g, b, alpha)"
  hexToRgba = hex: alpha:
    let c = parseHex hex; in
    "rgba(${toString c.r}, ${toString c.g}, ${toString c.b}, ${alpha})";

  # "#rrggbb" → "rgb(r, g, b)"
  hexToRgb = hex:
    let c = parseHex hex; in
    "rgb(${toString c.r}, ${toString c.g}, ${toString c.b})";
}
