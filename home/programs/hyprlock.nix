{ config, ... }:

let
  theme = config.theme;
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        grace = 2;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = theme.colors.foreground;
          font_size = 90;
          font_family = theme.fonts.monospace;
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = theme.colors.foreground;
          font_size = 20;
          font_family = theme.fonts.monospace;
          position = "0, 50";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [{
        monitor = "";
        size = "300, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.35;
        dots_center = true;
        outer_color = theme.colors.primary;
        inner_color = theme.colors.background;
        font_color = theme.colors.foreground;
        fade_on_empty = false;
        placeholder_text = "Enter Password...";
        hide_input = false;
        position = "0, -100";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
