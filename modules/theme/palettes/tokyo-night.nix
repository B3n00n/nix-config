# Tokyo Night palette
# https://github.com/tokyo-night/tokyo-night-vscode-theme
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
# Only override the fields that differ — deep merge handles the rest.
{
  fonts = {
    monospace = "JetBrains Mono";
    terminal  = "JetBrains Mono";
  };

  colors = {
    background = "#1a1b26";
    foreground = "#c0caf5";
    primary      = "#33ccff";
    primaryLight = "#7dcfff";     # Lighter cyan for gradients

    red     = "#f7768e";
    orange  = "#ff9e64";
    yellow  = "#e0af68";
    green   = "#00ff99";
    cyan    = "#33ccff";
    blue    = "#7aa2f7";
    purple  = "#bb9af7";
    magenta = "#bb9af7";

    surface0 = "#1f2335";       # Darkest surface
    surface1 = "#24283b";       # Mid surface
    surface2 = "#414868";       # Lightest surface

    selection  = "#33467c";
    comment    = "#565f89";
    lightCyan  = "#7dcfff";
    lightGreen = "#9ece6a";
    darkBlue   = "#3d59a1";
  };

  # 16-color terminal palette (differs from UI colors for readability)
  terminal = {
    black   = "#15161e";  brightBlack   = "#414868";
    red     = "#f7768e";  brightRed     = "#f7768e";
    green   = "#9ece6a";  brightGreen   = "#9ece6a";
    yellow  = "#e0af68";  brightYellow  = "#e0af68";
    blue    = "#7aa2f7";  brightBlue    = "#7aa2f7";
    magenta = "#bb9af7";  brightMagenta = "#bb9af7";
    cyan    = "#7dcfff";  brightCyan    = "#7dcfff";
    white   = "#a9b1d6";  brightWhite   = "#c0caf5";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/tokyonight.jpg";

  apps = {
    neovim    = { colorscheme = "tokyonight-night"; lualine = "tokyonight"; plugin = "tokyonight-nvim"; background = "dark"; };
    spicetify = { theme = "text"; colorScheme = "TokyoNight"; };
    vscode    = { colorTheme = "Tokyo Night"; extension = { publisher = "enkia"; name = "tokyo-night"; }; };
    gtk       = { themeName = "Tokyonight-Dark"; themePackage = "tokyonight-gtk-theme"; iconName = "Papirus-Dark"; iconPackage = "papirus-icon-theme"; };
  };
}
