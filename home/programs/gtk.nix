{ config, pkgs, ... }:

let
  vars  = config.system.variables;
  theme = config.theme;
  c     = theme.colors;

  # Identical for GTK 3 and 4.
  extraConfig = {
    gtk-application-prefer-dark-theme = theme.dark;
    gtk-decoration-layout = "menu:close";
  };

  gtk3Css = theme.cssDefineColors {
    theme_bg_color          = c.background;
    theme_fg_color          = c.foreground;
    theme_base_color        = c.surface1;
    theme_text_color        = c.foreground;
    theme_selected_bg_color = c.primary;
    theme_selected_fg_color = c.background;
    insensitive_bg_color    = c.surface0;
    insensitive_fg_color    = c.comment;
    borders                 = c.surface2;
    warning_color           = c.yellow;
    error_color             = c.red;
    success_color           = c.green;
  };

  gtk4Css = theme.cssDefineColors {
    theme_bg_color     = c.background;
    theme_fg_color     = c.foreground;
    accent_bg_color    = c.primary;
    accent_fg_color    = c.background;
    window_bg_color    = c.background;
    window_fg_color    = c.foreground;
    view_bg_color      = c.background;
    view_fg_color      = c.foreground;
    headerbar_bg_color = c.surface0;
    headerbar_fg_color = c.foreground;
    card_bg_color      = c.surface1;
    card_fg_color      = c.foreground;
    popover_bg_color   = c.surface0;
    popover_fg_color   = c.foreground;
    dialog_bg_color    = c.surface0;
    dialog_fg_color    = c.foreground;
    sidebar_bg_color   = c.surface0;
    sidebar_fg_color   = c.foreground;
    warning_bg_color   = c.yellow;
    warning_fg_color   = c.background;
    error_bg_color     = c.red;
    error_fg_color     = c.background;
    success_bg_color   = c.green;
    success_fg_color   = c.background;
  };
in
{
  gtk = {
    enable = true;

    theme = {
      name    = theme.apps.gtk.themeName;
      package = theme.apps.gtk.themePackage;
    };

    font = {
      name = theme.fonts.sansSerif;
      size = theme.fonts.size.normal;
    };

    iconTheme = {
      name    = theme.apps.gtk.iconName;
      package = theme.apps.gtk.iconPackage;
    };

    cursorTheme = {
      name    = vars.theme.cursorTheme;
      package = pkgs.bibata-cursors;
      size    = vars.theme.cursorSize;
    };

    # Palette overrides on top of the chosen theme so colors match exactly.
    gtk3 = { inherit extraConfig; extraCss = gtk3Css; };
    gtk4 = { inherit extraConfig; extraCss = gtk4Css; }; # libadwaita
  };

  # Canonical freedesktop "prefers dark" signal. xdg-desktop-portal-gtk
  # exposes this via org.freedesktop.appearance; Firefox/libadwaita/Electron
  # all honor it. Don't add per-app dark prefs.
  dconf.settings."org/gnome/desktop/interface".color-scheme =
    if theme.dark then "prefer-dark" else "default";

  # Qt picks up GTK colors via the platform theme; adwaita-qt is just the
  # widget style.
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = if theme.dark then "adwaita-dark" else "adwaita";
      package = pkgs.adwaita-qt;
    };
  };
}
