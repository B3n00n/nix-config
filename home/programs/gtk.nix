# GTK Configuration
{ config, pkgs, systemVars, theme, ... }:

let
  vars = systemVars;
in
{
  # GTK theming configuration
  gtk = {
    enable = true;

    # GTK theme from palette (Dracula, Tokyonight-Dark, etc.)
    theme = {
      name = theme.apps.gtk.themeName;
      package = pkgs.${theme.apps.gtk.themePackage};
    };

    # Font configuration
    font = {
      name = theme.fonts.sansSerif;
      size = theme.fonts.size.normal;
    };

    # Icon theme from palette
    iconTheme = {
      name = theme.apps.gtk.iconName;
      package = pkgs.${theme.apps.gtk.iconPackage};
    };

    # Cursor theme from centralized variables
    cursorTheme = {
      name = vars.theme.cursorTheme;
      package = pkgs.bibata-cursors;
      size = vars.theme.cursorSize;
    };

    # GTK 2 configuration
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-application-prefer-dark-theme = 1
        gtk-toolbar-style = GTK_TOOLBAR_BOTH
        gtk-toolbar-icon-size = GTK_ICON_SIZE_LARGE_TOOLBAR
        gtk-button-images = 1
        gtk-menu-images = 1
        gtk-enable-event-sounds = 0
        gtk-enable-input-feedback-sounds = 0
        gtk-xft-antialias = 1
        gtk-xft-hinting = 1
        gtk-xft-hintstyle = "hintfull"
        gtk-xft-rgba = "rgb"
      '';
    };

    # GTK 3 — color overrides ensure exact palette matching on top of the theme
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = true;
        gtk-menu-images = true;
        gtk-enable-event-sounds = false;
        gtk-enable-input-feedback-sounds = false;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-decoration-layout = "menu:close";
      };

      extraCss = ''
        /* Color overrides — ensures GTK3 apps match our palette exactly */
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
    };

    # GTK 4 — color overrides for libadwaita apps
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = "menu:close";
      };

      extraCss = ''
        /* Color overrides — ensures GTK4/libadwaita apps match our palette */
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
  };

  # Qt applications - colors come from GTK (which follows our theme),
  # adwaita-qt provides the widget rendering style (dark/light follows theme)
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = if theme.apps.neovim.background == "dark" then "adwaita-dark" else "adwaita";
      package = pkgs.adwaita-qt;
    };
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
