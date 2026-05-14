{ config, pkgs, ... }:

let
  vars  = config.system.variables;
  theme = config.theme;
in
{
  imports = [ ./bindings.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = [
        "${vars.hardware.monitors.external2},1920x1080@165,-3840x0,1"
        "${vars.hardware.monitors.external1},1920x1080@165,-1920x0,1"
        "${vars.hardware.monitors.laptop},preferred,0x0,1"
        ",preferred,auto,1"
      ];

      "$terminal"    = vars.apps.terminal;
      "$fileManager" = vars.apps.fileManager;
      "$browser"     = vars.apps.browser;
      "$menu"        = vars.apps.launcher;
      "$mainMod"     = "ALT";

      exec-once = [
        "${pkgs.networkmanagerapplet}/bin/nm-applet"
        "${pkgs.wl-clipboard}/bin/wl-paste --type text  --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
      ];

      env = [
        "XCURSOR_THEME,${vars.theme.cursorTheme}"
        "XCURSOR_SIZE,${toString vars.theme.cursorSize}"
        "HYPRCURSOR_SIZE,${toString vars.theme.cursorSize}"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = theme.border.width;
        "col.active_border"   = "rgba(${theme.removeHash theme.colors.primary}ee) rgba(${theme.removeHash theme.colors.primaryLight}ee) 45deg";
        "col.inactive_border" = "rgba(${theme.removeHash theme.colors.surface2}aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = theme.border.radius;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(${theme.removeHash theme.colors.background}ee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
          "zoomFactor,1,7,quick"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us,il";
        # Switching at the xkb level (not via a Hyprland keybind) so hyprlock
        # picks it up too — hyprlock has no layout-switch keybind of its own.
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      gesture = "3,horizontal,workspace";
    };
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };
}
