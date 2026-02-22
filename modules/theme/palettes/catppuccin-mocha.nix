# Catppuccin Mocha palette
# https://catppuccin.com/palette
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
{
  colors = {
    background = "#1e1e2e";     # Base
    foreground = "#cdd6f4";     # Text
    primary    = "#cba6f7";     # Mauve — distinctive Catppuccin accent

    red     = "#f38ba8";
    orange  = "#fab387";        # Peach
    yellow  = "#f9e2af";
    green   = "#a6e3a1";
    cyan    = "#94e2d5";        # Teal
    blue    = "#89b4fa";
    purple  = "#cba6f7";        # Mauve
    magenta = "#f5c2e7";        # Pink

    surface0 = "#313244";       # Surface0
    surface1 = "#45475a";       # Surface1
    surface2 = "#585b70";       # Surface2

    selection  = "#45475a";     # Surface1
    comment    = "#6c7086";     # Overlay0
    lightCyan  = "#89dceb";     # Sky
    lightGreen = "#a6e3a1";     # Green
    darkBlue   = "#74c7ec";     # Sapphire
  };

  # 16-color terminal palette (differs from UI colors for readability)
  terminal = {
    black   = "#45475a";  brightBlack   = "#585b70";
    red     = "#f38ba8";  brightRed     = "#f38ba8";
    green   = "#a6e3a1";  brightGreen   = "#a6e3a1";
    yellow  = "#f9e2af";  brightYellow  = "#f9e2af";
    blue    = "#89b4fa";  brightBlue    = "#89b4fa";
    magenta = "#f5c2e7";  brightMagenta = "#f5c2e7";
    cyan    = "#94e2d5";  brightCyan    = "#94e2d5";
    white   = "#bac2de";  brightWhite   = "#a6adc8";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/catppuccin-mocha.jpg";

  apps = {
    neovim    = { colorscheme = "catppuccin-mocha"; lualine = "catppuccin"; plugin = "catppuccin-nvim"; background = "dark"; };
    spicetify = { theme = "text"; colorScheme = "CatppuccinMocha"; };
    vscode    = { colorTheme = "Catppuccin Mocha"; extension = { publisher = "catppuccin"; name = "catppuccin-vsc"; }; };
  };
}
