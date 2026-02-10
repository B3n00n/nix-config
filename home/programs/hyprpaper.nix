# Hyprpaper Wallpaper Configuration
{ theme, ... }:

{
  # Hyprpaper configuration file
  home.file.".config/hypr/hyprpaper.conf".text = ''
    # Preload wallpapers from theme
    preload = ${theme.wallpaper}

    # Set wallpaper for all monitors
    wallpaper = ,${theme.wallpaper}

    # Fully disable IPC if not needed
    ipc = off
  '';
}
