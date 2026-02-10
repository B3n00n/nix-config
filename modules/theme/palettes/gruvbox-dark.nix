# Gruvbox Dark palette
# https://github.com/morhetz/gruvbox
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
{
  colors = {
    background = "#282828";
    foreground = "#ebdbb2";
    primary    = "#fabd2f";

    red     = "#fb4934";
    orange  = "#fe8019";
    yellow  = "#fabd2f";
    green   = "#b8bb26";
    cyan    = "#8ec07c";
    blue    = "#83a598";
    purple  = "#d3869b";
    magenta = "#d3869b";

    surface0 = "#1d2021";       # bg0_h
    surface1 = "#3c3836";       # bg1
    surface2 = "#504945";       # bg2

    selection  = "#504945";
    comment    = "#928374";
    lightCyan  = "#8ec07c";     # aqua
    lightGreen = "#b8bb26";
    darkBlue   = "#458588";
  };

  # 16-color terminal palette (uses neutral variants for normal, bright for bright)
  terminal = {
    black   = "#282828";  brightBlack   = "#928374";
    red     = "#cc241d";  brightRed     = "#fb4934";
    green   = "#98971a";  brightGreen   = "#b8bb26";
    yellow  = "#d79921";  brightYellow  = "#fabd2f";
    blue    = "#458588";  brightBlue    = "#83a598";
    magenta = "#b16286";  brightMagenta = "#d3869b";
    cyan    = "#689d6a";  brightCyan    = "#8ec07c";
    white   = "#a89984";  brightWhite   = "#ebdbb2";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/gruvbox-dark.jpg";

  apps = {
    neovim    = { colorscheme = "gruvbox"; lualine = "gruvbox"; plugin = "gruvbox-nvim"; background = "dark"; };
    spicetify = { theme = "text"; colorScheme = "Gruvbox"; };
    vscode    = { colorTheme = "Gruvbox Dark Hard"; extension = { publisher = "jdinhlife"; name = "gruvbox"; }; };
  };
}
