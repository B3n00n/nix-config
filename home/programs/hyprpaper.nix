{ config, ... }:

let
  wallpaperPath = toString config.theme.wallpaper;
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = true;
      splash = false;

      preload = [ wallpaperPath ];

      wallpaper = [
        {
          monitor = "";
          path = wallpaperPath;
        }
      ];
    };
  };
}
