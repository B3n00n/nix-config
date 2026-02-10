# Waybar Status Bar Configuration
{ theme, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "custom/spotify"
        ];

        modules-center = [ "clock" ];

        modules-right = [
          "tray"
          "pulseaudio"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "battery"
          "custom/power"
        ];

        # Hyprland workspaces
        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            active = "";
            default = "";
          };
          on-click = "activate";
          all-outputs = true;
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        # Clock module
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
              months = "<span color='${theme.colors.primary}'><b>{}</b></span>";
              days = "<span color='${theme.colors.foreground}'><b>{}</b></span>";
              weeks = "<span color='${theme.colors.lightCyan}'><b>W{}</b></span>";
              weekdays = "<span color='${theme.colors.blue}'><b>{}</b></span>";
              today = "<span color='${theme.colors.green}'><b><u>{}</u></b></span>";
            };
          };
        };

        # System monitoring
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
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-full = "󱟢 {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        # Network
        network = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 Connected";
          format-disconnected = "󰖪 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format-wifi = "󰖩 {essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
          tooltip-format-ethernet = "󰈀 {ifname}\n{ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        # Bluetooth
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        # Audio
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };

        # System tray
        tray = {
          icon-size = 18;
          spacing = 10;
        };

        # Custom modules
        "custom/spotify" = {
          exec = "playerctl -p spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo ''";
          interval = 2;
          max-length = 50;
          on-click = "playerctl -p spotify play-pause";
          on-click-right = "playerctl -p spotify next";
          on-scroll-up = "playerctl -p spotify previous";
          on-scroll-down = "playerctl -p spotify next";
        };

        "custom/power" = {
          format = "⏻";
          on-click = "~/.config/waybar/scripts/power-menu.sh";
          tooltip = false;
        };
      };
    };

    # CLEAN MODERN STYLE - Elegant, minimal, beautiful
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "${theme.fonts.monospace}", monospace;
          font-size: 12px;
          min-height: 0;
          font-weight: 500;
      }

      window#waybar {
          background-color: ${theme.hexToRgba theme.colors.background "0.95"};
          color: ${theme.colors.foreground};
          transition: background-color 0.3s ease;
      }

      /* Workspaces */
      #workspaces {
          margin: 4px 8px;
          padding: 0;
          background: transparent;
      }

      #workspaces button {
          padding: 4px 10px;
          margin: 0 2px;
          background-color: ${theme.hexToRgba theme.colors.surface0 "0.6"};
          color: ${theme.colors.foreground};
          border-radius: 8px;
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      }

      #workspaces button:hover {
          background-color: ${theme.hexToRgba theme.colors.primary "0.15"};
          box-shadow: 0 2px 8px ${theme.hexToRgba theme.colors.primary "0.2"};
      }

      #workspaces button.active {
          background: linear-gradient(135deg, ${theme.colors.primary}, ${theme.colors.blue});
          color: ${theme.colors.background};
          font-weight: 600;
          box-shadow: 0 2px 12px ${theme.hexToRgba theme.colors.primary "0.4"};
      }

      #workspaces button.urgent {
          background-color: ${theme.colors.red};
          color: ${theme.colors.background};
          animation: blink-urgent 1s ease-in-out infinite;
      }

      /* Clock */
      #clock {
          background-color: ${theme.hexToRgba theme.colors.surface0 "0.6"};
          padding: 4px 16px;
          margin: 4px 8px;
          color: ${theme.colors.purple};
          border-radius: 10px;
          font-weight: 600;
          transition: all 0.3s ease;
      }

      #clock:hover {
          background-color: ${theme.hexToRgba theme.colors.purple "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.purple "0.3"};
      }

      /* Spotify */
      #custom-spotify {
          background-color: ${theme.hexToRgba theme.colors.surface0 "0.6"};
          padding: 4px 14px;
          margin: 4px 4px;
          color: ${theme.colors.green};
          border-radius: 10px;
          transition: all 0.3s ease;
      }

      #custom-spotify:hover {
          background-color: ${theme.hexToRgba theme.colors.green "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.green "0.3"};
      }

      /* Power Button */
      #custom-power {
          background-color: ${theme.hexToRgba theme.colors.surface0 "0.6"};
          padding: 4px 12px;
          margin: 4px 8px 4px 4px;
          color: ${theme.colors.red};
          border-radius: 10px;
          font-size: 16px;
          transition: all 0.3s ease;
      }

      #custom-power:hover {
          background-color: ${theme.hexToRgba theme.colors.red "0.2"};
          box-shadow: inset 0 0 12px ${theme.hexToRgba theme.colors.red "0.4"};
      }

      /* System Modules */
      #tray,
      #pulseaudio,
      #bluetooth,
      #network,
      #cpu,
      #memory,
      #battery {
          background-color: ${theme.hexToRgba theme.colors.surface0 "0.6"};
          padding: 4px 12px;
          margin: 4px 3px;
          border-radius: 10px;
          transition: all 0.3s ease;
      }

      #cpu {
          color: ${theme.colors.lightCyan};
      }

      #cpu:hover {
          background-color: ${theme.hexToRgba theme.colors.lightCyan "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.lightCyan "0.3"};
      }

      #memory {
          color: ${theme.colors.purple};
      }

      #memory:hover {
          background-color: ${theme.hexToRgba theme.colors.purple "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.purple "0.3"};
      }

      #battery {
          color: ${theme.colors.lightGreen};
      }

      #battery.charging {
          color: ${theme.colors.green};
          background-color: ${theme.hexToRgba theme.colors.green "0.1"};
      }

      #battery.warning:not(.charging) {
          color: ${theme.colors.yellow};
          background-color: ${theme.hexToRgba theme.colors.yellow "0.15"};
      }

      #battery.critical:not(.charging) {
          color: ${theme.colors.red};
          background-color: ${theme.hexToRgba theme.colors.red "0.2"};
          animation: blink-urgent 1s ease-in-out infinite;
      }

      @keyframes blink-urgent {
          from { opacity: 1; }
          50% { opacity: 0.5; }
          to { opacity: 1; }
      }

      #network {
          color: ${theme.colors.blue};
      }

      #network.disconnected {
          color: ${theme.colors.red};
      }

      #network:hover {
          background-color: ${theme.hexToRgba theme.colors.blue "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.blue "0.3"};
      }

      #bluetooth {
          color: ${theme.colors.blue};
      }

      #bluetooth.connected {
          color: ${theme.colors.cyan};
      }

      #bluetooth.disabled {
          color: ${theme.colors.comment};
      }

      #bluetooth:hover {
          background-color: ${theme.hexToRgba theme.colors.cyan "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.cyan "0.3"};
      }

      #pulseaudio {
          color: ${theme.colors.lightCyan};
      }

      #pulseaudio.muted {
          color: ${theme.colors.comment};
      }

      #pulseaudio:hover {
          background-color: ${theme.hexToRgba theme.colors.lightCyan "0.15"};
          box-shadow: inset 0 0 8px ${theme.hexToRgba theme.colors.lightCyan "0.3"};
      }

      #tray {
          padding: 4px 8px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: ${theme.hexToRgba theme.colors.red "0.2"};
      }
    '';
  };

  # Copy Waybar power menu script
  home.file.".config/waybar/scripts/power-menu.sh" = {
    source = ../scripts/power-menu.sh;
    executable = true;
  };
}
