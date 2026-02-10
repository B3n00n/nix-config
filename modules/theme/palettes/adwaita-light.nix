# Adwaita Light palette
# https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/named-colors.html
#
# Only theme-specific values live here.
# Fonts, border, and opacity inherit from shared defaults in default.nix.
{
  colors = {
    background = "#fafafa";
    foreground = "#242424";
    primary    = "#1c71d8";

    red     = "#c01c28";
    orange  = "#e66100";
    yellow  = "#e5a50a";
    green   = "#26a269";
    cyan    = "#2aa1b3";
    blue    = "#1c71d8";
    purple  = "#a347ba";
    magenta = "#a347ba";

    surface0 = "#ebebeb";       # headerbar_bg_color
    surface1 = "#deddda";       # shade between header and borders
    surface2 = "#c0bfbc";       # borders / dividers

    selection  = "#1c71d8";
    comment    = "#9a9996";     # insensitive_fg_color
    lightCyan  = "#33c7de";
    lightGreen = "#33d17a";
    darkBlue   = "#12488b";
  };

  # 16-color terminal palette (GNOME Terminal — same hues, light background)
  terminal = {
    black   = "#241f31";  brightBlack   = "#5e5c64";
    red     = "#c01c28";  brightRed     = "#f66151";
    green   = "#26a269";  brightGreen   = "#33d17a";
    yellow  = "#a2734c";  brightYellow  = "#e5a50a";
    blue    = "#12488b";  brightBlue    = "#3584e4";
    magenta = "#a347ba";  brightMagenta = "#c061cb";
    cyan    = "#2aa1b3";  brightCyan    = "#33c7de";
    white   = "#d0cfcc";  brightWhite   = "#ffffff";
  };

  wallpaper = "/etc/nixos/assets/wallpapers/adwaita-light.jpg";

  apps = {
    neovim    = { colorscheme = "adwaita"; lualine = "auto"; plugin = "adwaita-nvim"; background = "light"; };
    spicetify = { theme = "text"; colorScheme = "CatppuccinLatte"; };
    vscode    = { colorTheme = "Adwaita Light"; extension = { publisher = "piousdeer"; name = "adwaita-theme"; }; };
  };
}
