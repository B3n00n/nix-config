# Hyprland bindings.
{ ... }:

let
  mod = "$mainMod";

  workspaceKeys = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ];
  workspaceOf = k: if k == "0" then "10" else k;
in
{
  wayland.windowManager.hyprland.settings = {
    # Layout switch (Win+Space) is handled at the xkb level via kb_options
    # in default.nix so hyprlock inherits it.
    bind = [
      # Core apps
      "${mod}, RETURN, exec, $terminal"
      "${mod}, Q, killactive,"
      "${mod}, F, exec, $fileManager"
      "${mod}, BACKSLASH, exec, $menu"

      # App launchers
      "${mod}, B, exec, $browser"
      "${mod}, D, exec, discord"
      "${mod}, V, exec, code"
      "${mod}, S, exec, spotify"

      # System
      "${mod}, L, exec, hyprlock"
      "${mod} SHIFT, S, exec, ~/.local/bin/screenshot.sh"
      "${mod} SHIFT, T, exec, ~/.local/bin/theme-switcher.sh"
      "${mod}, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

      # Window management
      "${mod}, E, movetoworkspace, special:magic"
      "${mod}, W, fullscreen, 1"
      "${mod}, P, togglefloating,"
      "${mod}, T, togglesplit,"
      "${mod}, SPACE, togglefloating,"

      # Focus movement
      "${mod}, left,  movefocus, l"
      "${mod}, right, movefocus, r"
      "${mod}, up,    movefocus, u"
      "${mod}, down,  movefocus, d"

      # Special workspace toggle
      "${mod} SHIFT, E, togglespecialworkspace, magic"

      # Move workspace to monitor
      "${mod} CTRL, left,  movecurrentworkspacetomonitor, l"
      "${mod} CTRL, right, movecurrentworkspacetomonitor, r"

      # Workspace scrolling
      "${mod}, mouse_down, workspace, e+1"
      "${mod}, mouse_up,   workspace, e-1"
    ]
    # Workspace switch and move-window-to-workspace per number key
    ++ map (k: "${mod}, ${k}, workspace, ${workspaceOf k}") workspaceKeys
    ++ map (k: "${mod} SHIFT, ${k}, movetoworkspace, ${workspaceOf k}") workspaceKeys;

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];

    # Repeatable while held
    bindel = [
      ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    # Active while the screen is locked
    bindl = [
      ",XF86AudioNext,  exec, playerctl next"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioPlay,  exec, playerctl play-pause"
      ",XF86AudioPrev,  exec, playerctl previous"
    ];

    windowrule = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
