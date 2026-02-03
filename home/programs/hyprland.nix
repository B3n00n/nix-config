# Hyprland Wayland Compositor Configuration
{ lib, systemVars, ... }:

let
  # Import Tokyo Night theme
  theme = import ../../modules/theme/tokyo-night.nix;
  
  # Alias for easier access
  vars = systemVars;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # Monitor configuration for docking station setup
      # When docked: 2 external monitors (DP) + laptop screen
      # Adjust monitor names after running: hyprctl monitors
      monitor = [
        # External monitor 2 (left) - DP-4
        "${vars.hardware.monitors.external2},1920x1080@165,-3840x0,1"
        
        # External monitor 1 (middle, primary) - DP-3
        "${vars.hardware.monitors.external1},1920x1080@165,-1920x0,1"
        
        # Laptop display (right, anchor) - eDP-1
        "${vars.hardware.monitors.laptop},preferred,0x0,1"
        
        # Fallback for any other connected displays
        ",preferred,auto,1"
      ];

      # Program definitions from centralized variables
      "$terminal" = vars.apps.terminal;
      "$fileManager" = vars.apps.fileManager;
      "$menu" = vars.apps.launcher;
      "$mainMod" = "ALT";

      # Autostart
      exec-once = [
        "waybar"
        "hyprpaper"
        "nm-applet"
        "wl-paste --type text --watch cliphist store"   # Clipboard history
        "wl-paste --type image --watch cliphist store"  # Clipboard images
      ];

      # Environment variables using centralized theme settings
      env = [
        "XCURSOR_THEME,${vars.theme.cursorTheme}"
        "XCURSOR_SIZE,${toString vars.theme.cursorSize}"
        "HYPRCURSOR_SIZE,${toString vars.theme.cursorSize}"
        # NVIDIA + Wayland support
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        # Tokyo Night border colors
        "col.active_border" = "rgba(${lib.removePrefix "#" theme.colors.cyan}ee) rgba(${lib.removePrefix "#" theme.colors.green}ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
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

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Input configuration
      input = {
        kb_layout = "us,il";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # Gestures
      gesture = "3,horizontal,workspace";

      # Device-specific configuration
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Key bindings
      bind = [
        # Keyboard layout switch (Super+Shift)
        "SUPER, Shift_L, exec, hyprctl switchxkblayout all next"

        # Core applications
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, BACKSLASH, exec, $menu"

        # Application launchers
        "$mainMod, B, exec, ${vars.apps.browser}"
        "$mainMod, D, exec, discord"
        "$mainMod, V, exec, code"
        "$mainMod, S, exec, spotify"

        # System controls
        "$mainMod, L, exec, hyprlock"
        "$mainMod SHIFT, S, exec, ~/.local/bin/screenshot.sh"
        "$mainMod, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mainMod SHIFT, W, exec, killall hyprpaper && hyprpaper &"

        # Window management
        "$mainMod, E, movetoworkspace, special:magic"
        "$mainMod, W, fullscreen, 1"
        "$mainMod, P, togglefloating,"
        "$mainMod, T, togglesplit,"
        "$mainMod, SPACE, togglefloating,"

        # Focus movement (arrow keys)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod SHIFT, E, togglespecialworkspace, magic"

        # Workspace scrolling
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Multimedia keys (repeatable)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media player controls (lock-able)
      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      # Window rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
