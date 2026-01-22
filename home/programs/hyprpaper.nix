# Hyprpaper Wallpaper Configuration
{ systemVars, ... }:

let
  vars = systemVars;
in
{
  # Hyprpaper configuration file
  home.file.".config/hypr/hyprpaper.conf".text = ''
    # Preload wallpapers from centralized path
    preload = ${vars.paths.wallpaper}
    
    # Set wallpaper for all monitors
    wallpaper = ,${vars.paths.wallpaper}
    
    # Fully disable IPC if not needed
    ipc = off
  '';
}
