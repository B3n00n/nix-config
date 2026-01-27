# Waybar Status Bar Configuration
{ pkgs, systemVars, ... }:

let
  # Import Tokyo Night theme
  theme = import ../../modules/theme/tokyo-night.nix;
in
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
          format = "[{id}]";
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
          format = "[{:%H:%M - %a %d %b}]";
          interval = 60;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#33ccff'><b>{}</b></span>";
              days = "<span color='#c0caf5'><b>{}</b></span>";
              weeks = "<span color='#99d1db'><b>W{}</b></span>";
              weekdays = "<span color='#81a1c1'><b>{}</b></span>";
              today = "<span color='#00ff99'><b><u>{}</u></b></span>";
            };
          };
        };

        # System monitoring
        cpu = {
          format = "[CPU {usage}%]";
          tooltip = true;
          interval = 2;
        };

        memory = {
          format = "[RAM {percentage}%]";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "[BAT {capacity}%]";
          format-charging = "[CHR {capacity}%]";
          format-plugged = "[AC {capacity}%]";
        };

        # Network
        network = {
          format-wifi = "[WIFI {essid}]";
          format-ethernet = "[ETH]";
          format-disconnected = "[NO NET]";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        # Bluetooth
        bluetooth = {
          format = "[BT]";
          format-disabled = "[BT OFF]";
          format-connected = "[BT {device_alias}]";
          format-connected-battery = "[BT {device_alias} {device_battery_percentage}%]";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        # Audio
        pulseaudio = {
          format = "[VOL {volume}%]";
          format-muted = "[MUTE]";
          on-click = "pavucontrol";
        };

        # System tray
        tray = {
          icon-size = 18;
          spacing = 10;
        };

        # Custom modules
        "custom/spotify" = {
          exec = "playerctl -p spotify metadata --format '[{{ artist }} - {{ title }}]' 2>/dev/null || echo ''";
          interval = 2;
          max-length = 50;
          on-click = "playerctl -p spotify play-pause";
          on-click-right = "playerctl -p spotify next";
          on-scroll-up = "playerctl -p spotify previous";
          on-scroll-down = "playerctl -p spotify next";
        };

        "custom/power" = {
          format = "[PWR]";
          on-click = "~/.config/waybar/scripts/power-menu.sh";
          tooltip = false;
        };
      };
    };

    # Tokyo Night styled CSS
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "${theme.fonts.monospace}", monospace;
          font-size: ${toString theme.fonts.size.large}px;
          min-height: 0;
          font-weight: bold;
      }

      window#waybar {
          background-color: rgba(26, 27, 38, 0.95);
          color: ${theme.colors.foreground};
          transition-property: background-color;
          transition-duration: 0.5s;
      }

      /* Workspace buttons */
      #workspaces button {
          padding: 0 8px;
          background-color: transparent;
          color: ${theme.colors.blue};
          border-bottom: 2px solid transparent;
      }

      #workspaces button:hover {
          background-color: rgba(122, 162, 247, 0.1);
      }

      #workspaces button.active {
          color: ${theme.colors.cyan};
          border-bottom: 2px solid ${theme.colors.cyan};
      }

      #workspaces button.urgent {
          color: ${theme.colors.red};
          border-bottom: 2px solid ${theme.colors.red};
      }

      /* Clock */
      #clock {
          padding: 0 15px;
          color: ${theme.colors.purple};
          font-weight: bold;
      }

      /* Custom modules */
      #custom-spotify {
          padding: 0 10px;
          margin: 0 5px;
          color: ${theme.colors.green};
      }

      #custom-power {
          padding: 0 10px;
          margin: 0 5px;
          color: ${theme.colors.red};
      }

      #custom-power:hover {
          background-color: rgba(247, 118, 142, 0.2);
      }

      /* Right modules */
      #tray,
      #pulseaudio,
      #bluetooth,
      #network,
      #cpu,
      #memory,
      #battery {
          padding: 0 6px;
          margin: 0 3px;
          background-color: transparent;
          border-radius: 0;
      }

      #cpu {
          color: ${theme.colors.lightCyan};
      }

      #memory {
          color: ${theme.colors.purple};
      }

      #battery {
          color: ${theme.colors.lightGreen};
      }

      #battery.charging {
          color: ${theme.colors.green};
      }

      #battery.warning:not(.charging) {
          color: ${theme.colors.yellow};
      }

      #battery.critical:not(.charging) {
          color: ${theme.colors.red};
          animation: blink 1s linear infinite;
      }

      @keyframes blink {
          50% {
              opacity: 0.5;
          }
      }

      #network {
          color: ${theme.colors.blue};
      }

      #network.disconnected {
          color: ${theme.colors.red};
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

      #pulseaudio {
          color: ${theme.colors.lightCyan};
      }

      #pulseaudio.muted {
          color: ${theme.colors.comment};
      }

      #tray {
          background-color: transparent;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }
    '';
  };

  # Copy Waybar power menu script
  home.file.".config/waybar/scripts/power-menu.sh" = {
    source = ../scripts/power-menu.sh;
    executable = true;
  };
}
