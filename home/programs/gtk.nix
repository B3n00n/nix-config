# GTK Configuration - Tokyo Night Theme
{ config, pkgs, systemVars, ... }:

let
  # Import Tokyo Night theme
  theme = import ../../modules/theme/tokyo-night.nix;
  vars = systemVars;
in
{
  # GTK theming configuration
  gtk = {
    enable = true;

    # Font configuration
    font = {
      name = theme.fonts.sansSerif;
      size = theme.fonts.size.normal;
    };

    # Icon theme from centralized variables
    iconTheme = {
      name = vars.theme.iconTheme;
      package = pkgs.papirus-icon-theme;
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

    # GTK 3 configuration
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

      # Custom CSS for Tokyo Night theming
      extraCss = ''
        /* Tokyo Night GTK Theme - Custom CSS */

        /* Base colors */
        @define-color theme_bg_color ${theme.colors.background};
        @define-color theme_fg_color ${theme.colors.foreground};
        @define-color theme_base_color ${theme.colors.gray2};
        @define-color theme_text_color ${theme.colors.foreground};
        @define-color theme_selected_bg_color ${theme.colors.cyan};
        @define-color theme_selected_fg_color ${theme.colors.background};

        /* Additional semantic colors */
        @define-color insensitive_bg_color ${theme.colors.gray1};
        @define-color insensitive_fg_color ${theme.colors.comment};
        @define-color borders ${theme.colors.gray3};
        @define-color warning_color ${theme.colors.yellow};
        @define-color error_color ${theme.colors.red};
        @define-color success_color ${theme.colors.green};

        /* Window background */
        window {
          background-color: ${theme.colors.background};
          color: ${theme.colors.foreground};
        }

        /* Headerbar styling */
        headerbar {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.foreground};
          border-bottom: 2px solid ${theme.colors.gray3};
          box-shadow: none;
        }

        headerbar:backdrop {
          background-color: ${theme.colors.background};
        }

        /* Buttons */
        button {
          background-color: ${theme.colors.gray2};
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
          padding: 6px 12px;
        }

        button:hover {
          background-color: ${theme.colors.gray3};
          border-color: ${theme.colors.cyan};
        }

        button:active,
        button:checked {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        button:disabled {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.comment};
        }

        /* Entry fields (text inputs) */
        entry {
          background-color: ${theme.colors.gray2};
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
          padding: 6px;
        }

        entry:focus {
          border-color: ${theme.colors.cyan};
          box-shadow: 0 0 0 1px ${theme.colors.cyan};
        }

        entry:disabled {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.comment};
        }

        /* Selection and highlighting */
        selection {
          background-color: ${theme.colors.selection};
          color: ${theme.colors.foreground};
        }

        *:selected {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        /* Scrollbars */
        scrollbar {
          background-color: ${theme.colors.background};
        }

        scrollbar slider {
          background-color: ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
          min-width: 12px;
          min-height: 12px;
        }

        scrollbar slider:hover {
          background-color: ${theme.colors.cyan};
        }

        /* Menus */
        menu,
        .menu {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
        }

        menuitem {
          padding: 6px 12px;
        }

        menuitem:hover {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        /* Tooltips */
        tooltip {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.cyan};
          border-radius: ${toString theme.border.radius}px;
          padding: 6px;
        }

        /* Sidebars (like in Thunar) */
        .sidebar {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.foreground};
        }

        .sidebar:selected {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        /* Notebooks (tabs) */
        notebook {
          background-color: ${theme.colors.background};
        }

        notebook header {
          background-color: ${theme.colors.gray1};
          border-bottom: 2px solid ${theme.colors.gray3};
        }

        notebook tab {
          background-color: transparent;
          color: ${theme.colors.comment};
          padding: 8px 16px;
          border: none;
        }

        notebook tab:hover {
          background-color: ${theme.colors.gray2};
          color: ${theme.colors.foreground};
        }

        notebook tab:checked {
          background-color: ${theme.colors.background};
          color: ${theme.colors.cyan};
          border-bottom: 2px solid ${theme.colors.cyan};
        }

        /* Treeview (file lists, etc.) */
        treeview {
          background-color: ${theme.colors.background};
          color: ${theme.colors.foreground};
        }

        treeview:selected {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        treeview:hover {
          background-color: ${theme.colors.gray2};
        }

        /* Checkboxes and radio buttons */
        checkbutton check,
        radiobutton radio {
          background-color: ${theme.colors.gray2};
          border: 1px solid ${theme.colors.gray3};
          border-radius: 3px;
        }

        checkbutton check:checked,
        radiobutton radio:checked {
          background-color: ${theme.colors.cyan};
          border-color: ${theme.colors.cyan};
          -gtk-icon-source: -gtk-icontheme("object-select-symbolic");
          color: ${theme.colors.background};
        }

        /* Progress bars */
        progressbar {
          background-color: ${theme.colors.gray2};
          border-radius: ${toString theme.border.radius}px;
        }

        progressbar progress {
          background-color: ${theme.colors.cyan};
          border-radius: ${toString theme.border.radius}px;
        }

        /* Switches */
        switch {
          background-color: ${theme.colors.gray2};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
        }

        switch:checked {
          background-color: ${theme.colors.cyan};
        }

        switch slider {
          background-color: ${theme.colors.foreground};
          border-radius: ${toString theme.border.radius}px;
        }

        /* Separators */
        separator {
          background-color: ${theme.colors.gray3};
          min-width: 1px;
          min-height: 1px;
        }

        /* Popovers */
        popover {
          background-color: ${theme.colors.gray1};
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        /* List items */
        list,
        .view {
          background-color: ${theme.colors.background};
          color: ${theme.colors.foreground};
        }

        list row:selected,
        .view:selected {
          background-color: ${theme.colors.cyan};
          color: ${theme.colors.background};
        }

        /* Spinbuttons (number inputs) */
        spinbutton {
          background-color: ${theme.colors.gray2};
          border: 1px solid ${theme.colors.gray3};
          border-radius: ${toString theme.border.radius}px;
        }

        spinbutton button {
          background-color: transparent;
          border: none;
        }

        spinbutton button:hover {
          background-color: ${theme.colors.gray3};
        }
      '';
    };

    # GTK 4 configuration
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = "menu:close";
      };

      # Custom CSS for GTK 4 (similar to GTK 3 but with updated selectors)
      extraCss = ''
        /* Tokyo Night GTK 4 Theme - Custom CSS */

        /* Base colors */
        @define-color theme_bg_color ${theme.colors.background};
        @define-color theme_fg_color ${theme.colors.foreground};
        @define-color accent_bg_color ${theme.colors.cyan};
        @define-color accent_fg_color ${theme.colors.background};
        @define-color window_bg_color ${theme.colors.background};
        @define-color window_fg_color ${theme.colors.foreground};
        @define-color view_bg_color ${theme.colors.background};
        @define-color view_fg_color ${theme.colors.foreground};
        @define-color headerbar_bg_color ${theme.colors.gray1};
        @define-color headerbar_fg_color ${theme.colors.foreground};
        @define-color card_bg_color ${theme.colors.gray2};
        @define-color card_fg_color ${theme.colors.foreground};
        @define-color popover_bg_color ${theme.colors.gray1};
        @define-color popover_fg_color ${theme.colors.foreground};
        @define-color dialog_bg_color ${theme.colors.gray1};
        @define-color dialog_fg_color ${theme.colors.foreground};
        @define-color sidebar_bg_color ${theme.colors.gray1};
        @define-color sidebar_fg_color ${theme.colors.foreground};
        @define-color warning_bg_color ${theme.colors.yellow};
        @define-color warning_fg_color ${theme.colors.background};
        @define-color error_bg_color ${theme.colors.red};
        @define-color error_fg_color ${theme.colors.background};
        @define-color success_bg_color ${theme.colors.green};
        @define-color success_fg_color ${theme.colors.background};

        /* Apply base styling to all windows */
        window {
          background-color: ${theme.colors.background};
          color: ${theme.colors.foreground};
        }
      '';
    };
  };

  # Qt applications - use GTK theme for consistency
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
