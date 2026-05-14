{ config, ... }:

let
  theme = config.theme;

  paletteVars = {
    bg          = theme.colors.background;
    fg          = theme.colors.foreground;
    primary     = theme.colors.primary;
    blue        = theme.colors.blue;
    red         = theme.colors.red;
    green       = theme.colors.green;
    yellow      = theme.colors.yellow;
    purple      = theme.colors.purple;
    cyan        = theme.colors.cyan;
    comment     = theme.colors.comment;
    surface0    = theme.colors.surface0;
    lightCyan   = theme.colors.lightCyan;
    lightGreen  = theme.colors.lightGreen;
  };

  defineColor = name: value: "@define-color ${name} ${value};";
  colorBlock = builtins.concatStringsSep "\n"
    (builtins.attrValues (builtins.mapAttrs defineColor paletteVars));

  rawCss = builtins.replaceStrings [ "@FONT_MONOSPACE@" ] [ theme.fonts.monospace ]
    (builtins.readFile ./style.css);

  styleSheet = ''
    /* Auto-generated palette bindings — see default.nix */
    ${colorBlock}

  '' + rawCss;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 4;

      modules-left   = [ "hyprland/workspaces" "custom/spotify" ];
      modules-center = [ "clock" ];
      modules-right  = [ "tray" "pulseaudio" "bluetooth" "network" "cpu" "memory" "battery" "custom/power" ];

      "hyprland/workspaces" = {
        format = "{name}";
        format-icons = {
          "1" = "1"; "2" = "2"; "3" = "3"; "4" = "4"; "5" = "5";
          active = "";
          default = "";
        };
        on-click = "activate";
        all-outputs = true;
        persistent-workspaces = { "1" = []; "2" = []; "3" = []; "4" = []; "5" = []; };
      };

      clock = {
        format = "{:%H:%M  %a %d %b}";
        format-alt = "{:%A, %B %d, %Y  %H:%M:%S}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months   = "<span color='${theme.colors.primary}'><b>{}</b></span>";
            days     = "<span color='${theme.colors.foreground}'><b>{}</b></span>";
            weeks    = "<span color='${theme.colors.lightCyan}'><b>W{}</b></span>";
            weekdays = "<span color='${theme.colors.blue}'><b>{}</b></span>";
            today    = "<span color='${theme.colors.green}'><b><u>{}</u></b></span>";
          };
        };
      };

      cpu = {
        format = "󰻠 {usage}%";
        tooltip = true;
        interval = 2;
      };

      memory = {
        format = "󰍛 {percentage}%";
        tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
      };

      battery = {
        bat = "BAT0";
        states = { warning = 30; critical = 15; };
        format          = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged  = "󰚥 {capacity}%";
        format-full     = "󱟢 {capacity}%";
        format-icons    = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      };

      network = {
        format-wifi         = "󰖩 {essid}";
        format-ethernet     = "󰈀 Connected";
        format-disconnected = "󰖪 Disconnected";
        tooltip-format          = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format-wifi     = "󰖩 {essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
        tooltip-format-ethernet = "󰈀 {ifname}\n{ipaddr}/{cidr}";
        on-click = "nm-connection-editor";
      };

      bluetooth = {
        format                   = "󰂯";
        format-disabled          = "󰂲";
        format-connected         = "󰂱 {device_alias}";
        format-connected-battery = "󰂱 {device_alias} {device_battery_percentage}%";
        tooltip-format                              = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected                    = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected          = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery  = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        on-click = "blueman-manager";
      };

      pulseaudio = {
        format       = "{icon} {volume}%";
        format-muted = "󰝟 Muted";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        on-click = "pavucontrol";
      };

      tray = {
        icon-size = 18;
        spacing = 10;
      };

      "custom/spotify" = {
        exec = "playerctl -p spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo ''";
        interval = 2;
        max-length = 50;
        on-click       = "playerctl -p spotify play-pause";
        on-click-right = "playerctl -p spotify next";
        on-scroll-up   = "playerctl -p spotify previous";
        on-scroll-down = "playerctl -p spotify next";
      };

      "custom/power" = {
        format = "⏻";
        on-click = "~/.config/waybar/scripts/power-menu.sh";
        tooltip = false;
      };
    };

    style = styleSheet;
  };

  home.file.".config/waybar/scripts/power-menu.sh" = {
    source = ../../scripts/power-menu.sh;
    executable = true;
  };
}
