# Dracula palette
# https://draculatheme.com/contribute
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
{
  colors = {
    background = "#282a36";
    foreground = "#f8f8f2";
    primary    = "#bd93f9";     # Purple — Dracula's signature accent

    red     = "#ff5555";
    orange  = "#ffb86c";
    yellow  = "#f1fa8c";
    green   = "#50fa7b";
    cyan    = "#8be9fd";
    blue    = "#6272a4";        # Comment blue (Dracula has no distinct "blue")
    purple  = "#bd93f9";
    magenta = "#ff79c6";        # Pink

    surface0 = "#21222c";       # Darker than bg
    surface1 = "#44475a";       # Current line
    surface2 = "#6272a4";       # Comment color

    selection  = "#44475a";
    comment    = "#6272a4";
    lightCyan  = "#8be9fd";
    lightGreen = "#50fa7b";
    darkBlue   = "#6272a4";
  };

  # 16-color terminal palette (differs from UI colors for readability)
  terminal = {
    black   = "#21222c";  brightBlack   = "#6272a4";
    red     = "#ff5555";  brightRed     = "#ff6e6e";
    green   = "#50fa7b";  brightGreen   = "#69ff94";
    yellow  = "#f1fa8c";  brightYellow  = "#ffffa5";
    blue    = "#bd93f9";  brightBlue    = "#d6acff";
    magenta = "#ff79c6";  brightMagenta = "#ff92df";
    cyan    = "#8be9fd";  brightCyan    = "#a4ffff";
    white   = "#f8f8f2";  brightWhite   = "#ffffff";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/dracula.jpg";

  apps = {
    neovim    = { colorscheme = "dracula"; lualine = "dracula"; plugin = "dracula-nvim"; background = "dark"; };
    spicetify = { theme = "text"; colorScheme = "Dracula"; };
    vscode    = { colorTheme = "Dracula"; extension = { publisher = "dracula-theme"; name = "theme-dracula"; }; };
  };
}
