{ config, ... }:

let
  theme = config.theme;
in
{
  services.mako = {
    enable = true;

    settings = {
      font = "${theme.fonts.sansSerif} ${toString theme.fonts.size.normal}";

      background-color = theme.colors.surface0;
      text-color       = theme.colors.foreground;
      border-color     = theme.colors.primary;
      progress-color   = "over ${theme.colors.green}";

      border-size   = theme.border.width;
      border-radius = theme.border.radius;
      padding = "12";
      margin  = "10";

      icon-path = "${theme.apps.gtk.iconPackage}/share/icons/${theme.apps.gtk.iconName}";
      max-icon-size = 48;

      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;

      anchor = "top-right";
      width  = 400;
      height = 150;

      "urgency=low"    = { border-color = theme.colors.blue;    default-timeout = 3000; };
      "urgency=normal" = { border-color = theme.colors.primary; default-timeout = 5000; };
      "urgency=high"   = { border-color = theme.colors.red;     default-timeout = 0; };

      "app-name=\"Spotify\"" = {
        border-color = theme.colors.green;
        default-timeout = 3000;
      };
    };
  };
}
