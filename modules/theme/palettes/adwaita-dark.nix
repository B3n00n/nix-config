# Adwaita Dark palette
# https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/named-colors.html
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
{
  colors = {
    background = "#242424";
    foreground = "#ffffff";
    primary    = "#3584e4";

    red     = "#ed333b";
    orange  = "#ff7800";
    yellow  = "#f6d32d";
    green   = "#57e389";
    cyan    = "#5bc8af";
    blue    = "#3584e4";
    purple  = "#c061cb";
    magenta = "#c061cb";

    surface0 = "#1e1e1e";       # view_bg_color
    surface1 = "#303030";       # headerbar_bg_color
    surface2 = "#383838";       # card_bg_color

    selection  = "#3584e4";
    comment    = "#9a9996";     # insensitive_fg_color
    lightCyan  = "#93ddc2";
    lightGreen = "#8ff0a4";
    darkBlue   = "#1a5fb4";
  };

  # 16-color terminal palette (GNOME Terminal default)
  terminal = {
    black   = "#171421";  brightBlack   = "#5e5c64";
    red     = "#c01c28";  brightRed     = "#f66151";
    green   = "#26a269";  brightGreen   = "#33d17a";
    yellow  = "#a2734c";  brightYellow  = "#e5a50a";
    blue    = "#12488b";  brightBlue    = "#3584e4";
    magenta = "#a347ba";  brightMagenta = "#c061cb";
    cyan    = "#2aa1b3";  brightCyan    = "#33c7de";
    white   = "#d0cfcc";  brightWhite   = "#ffffff";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/adwaita-dark.jpg";

  apps = {
    neovim    = { colorscheme = "adwaita"; lualine = "auto"; plugin = "adwaita-nvim"; background = "dark"; };
    spicetify = { theme = "text"; colorScheme = "Spotify"; };
    vscode    = { colorTheme = "Adwaita Dark"; extension = { publisher = "piousdeer"; name = "adwaita-theme"; }; };
  };
}
