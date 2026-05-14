{ lib }:

let
  inherit (lib) mkOption types;

  strAttrs = fields: types.submodule {
    options = lib.genAttrs fields (_: mkOption { type = types.str; });
  };
in
{
  palette = {
    options = {
      dark      = mkOption { type = types.bool; };
      wallpaper = mkOption { type = types.path; };

      fonts = mkOption {
        type = types.submodule {
          options = {
            monospace = mkOption { type = types.str; };
            sansSerif = mkOption { type = types.str; };
            terminal  = mkOption { type = types.str; };
            size = mkOption {
              type = types.submodule {
                options.normal = mkOption { type = types.ints.positive; };
              };
            };
          };
        };
      };

      border = mkOption {
        type = types.submodule {
          options = {
            width  = mkOption { type = types.ints.positive; };
            radius = mkOption { type = types.ints.unsigned; };
          };
        };
      };

      colors = mkOption {
        type = strAttrs [
          "background" "foreground"
          "primary" "primaryLight"
          "red" "yellow" "green" "cyan" "blue" "purple"
          "surface0" "surface1" "surface2"
          "comment" "lightCyan" "lightGreen"
        ];
      };

      terminal = mkOption {
        type = strAttrs [
          "black"   "brightBlack"
          "red"     "brightRed"
          "green"   "brightGreen"
          "yellow"  "brightYellow"
          "blue"    "brightBlue"
          "magenta" "brightMagenta"
          "cyan"    "brightCyan"
          "white"   "brightWhite"
        ];
      };
    };
  };

  integration = {
    options = {
      neovim = mkOption {
        type = types.submodule {
          options = {
            colorscheme = mkOption { type = types.str; };
            lualine     = mkOption { type = types.str; };
            plugin      = mkOption { type = types.package; };
            background  = mkOption { type = types.enum [ "dark" "light" ]; };
          };
        };
      };

      spicetify = mkOption {
        type = types.submodule {
          options = {
            theme       = mkOption { type = types.attrs; };
            colorScheme = mkOption { type = types.str; };
          };
        };
      };

      vscode = mkOption {
        type = types.submodule {
          options = {
            colorTheme = mkOption { type = types.str; };
            extension  = mkOption { type = types.package; };
          };
        };
      };

      gtk = mkOption {
        type = types.submodule {
          options = {
            themeName    = mkOption { type = types.str; };
            themePackage = mkOption { type = types.package; };
            iconName     = mkOption { type = types.str; };
            iconPackage  = mkOption { type = types.package; };
          };
        };
      };
    };
  };
}
