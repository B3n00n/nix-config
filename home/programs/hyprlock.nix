{ config, ... }:

let
  theme = config.theme;

  mkLabel = { format, size, y }: {
    monitor = "";
    text = ''cmd[update:1000] echo "$(date +"${format}")"'';
    color = theme.colors.foreground;
    font_size = size;
    font_family = theme.fonts.monospace;
    position = "0, ${toString y}";
    halign = "center";
    valign = "center";
  };
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
        (mkLabel { format = "%H:%M";        size = 90; y = 150; })
        (mkLabel { format = "%A, %B %d";    size = 20; y = 50;  })
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
