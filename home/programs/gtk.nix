{ config, pkgs, ... }:

let
  vars  = config.system.variables;
  theme = config.theme;
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

    # GTK3 — palette overrides on top of the chosen theme so colors match exactly.
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:close";
    };
    gtk3.extraCss = ''
      @define-color theme_bg_color ${theme.colors.background};
      @define-color theme_fg_color ${theme.colors.foreground};
      @define-color theme_base_color ${theme.colors.surface1};
      @define-color theme_text_color ${theme.colors.foreground};
      @define-color theme_selected_bg_color ${theme.colors.primary};
      @define-color theme_selected_fg_color ${theme.colors.background};
      @define-color insensitive_bg_color ${theme.colors.surface0};
      @define-color insensitive_fg_color ${theme.colors.comment};
      @define-color borders ${theme.colors.surface2};
      @define-color warning_color ${theme.colors.yellow};
      @define-color error_color ${theme.colors.red};
      @define-color success_color ${theme.colors.green};
    '';

    # GTK4 / libadwaita.
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:close";
    };
    gtk4.extraCss = ''
      @define-color theme_bg_color ${theme.colors.background};
      @define-color theme_fg_color ${theme.colors.foreground};
      @define-color accent_bg_color ${theme.colors.primary};
      @define-color accent_fg_color ${theme.colors.background};
      @define-color window_bg_color ${theme.colors.background};
      @define-color window_fg_color ${theme.colors.foreground};
      @define-color view_bg_color ${theme.colors.background};
      @define-color view_fg_color ${theme.colors.foreground};
      @define-color headerbar_bg_color ${theme.colors.surface0};
      @define-color headerbar_fg_color ${theme.colors.foreground};
      @define-color card_bg_color ${theme.colors.surface1};
      @define-color card_fg_color ${theme.colors.foreground};
      @define-color popover_bg_color ${theme.colors.surface0};
      @define-color popover_fg_color ${theme.colors.foreground};
      @define-color dialog_bg_color ${theme.colors.surface0};
      @define-color dialog_fg_color ${theme.colors.foreground};
      @define-color sidebar_bg_color ${theme.colors.surface0};
      @define-color sidebar_fg_color ${theme.colors.foreground};
      @define-color warning_bg_color ${theme.colors.yellow};
      @define-color warning_fg_color ${theme.colors.background};
      @define-color error_bg_color ${theme.colors.red};
      @define-color error_fg_color ${theme.colors.background};
      @define-color success_bg_color ${theme.colors.green};
      @define-color success_fg_color ${theme.colors.background};
    '';
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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
