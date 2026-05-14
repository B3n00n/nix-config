# Hyprpaper wallpaper daemon
{ config, ... }:

let
  # theme.wallpaper is a path literal; hyprpaper's serializer wants a string.
  wallpaperPath = toString config.theme.wallpaper;
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload   = [ wallpaperPath ];
      wallpaper = [ ",${wallpaperPath}" ];
      ipc = "off";
    };
  };
}
