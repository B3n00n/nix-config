# Color helpers — Nix has no hex parser, so we look up nibbles in a table.
let
  hexDigit = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
    "A" = 10;
    "B" = 11;
    "C" = 12;
    "D" = 13;
    "E" = 14;
    "F" = 15;
  };

  hexByte = s: hexDigit.${builtins.substring 0 1 s} * 16 + hexDigit.${builtins.substring 1 1 s};

  removeHash = hex: if builtins.substring 0 1 hex == "#" then builtins.substring 1 (-1) hex else hex;

  parseHex =
    hex:
    let
      s = removeHash hex;
    in
    {
      r = hexByte (builtins.substring 0 2 s);
      g = hexByte (builtins.substring 2 2 s);
      b = hexByte (builtins.substring 4 2 s);
    };

  # { name = value; } -> "<fmt name value>\n<fmt name value>…"
  renderLines =
    fmt: attrs: builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs fmt attrs));
in
{
  inherit removeHash;

  hexToRgba =
    hex: alpha:
    let
      c = parseHex hex;
    in
    "rgba(${toString c.r}, ${toString c.g}, ${toString c.b}, ${alpha})";

  hyprRgb = hex: "rgb(${removeHash hex})";
  hyprRgba = hex: alpha: "rgba(${removeHash hex}${alpha})";

  # GTK / Waybar stylesheets: `@define-color name #rrggbb;`
  cssDefineColors = attrs: renderLines (name: value: "@define-color ${name} ${value};") attrs + "\n";

  # Standard CSS custom properties, wrapped in a `:root` block.
  cssRootVars =
    attrs: ":root {\n" + renderLines (name: value: "  ${name}: ${value};") attrs + "\n}\n";
}
