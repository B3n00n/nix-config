# Wayland compositor and desktop environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  programs.hyprland.enable = true;

  # Enable polkit for GUI authentication dialogs
  # Required for elevated privilege operations in GUI applications
  security.polkit.enable = true;

  # Configure greetd display manager with auto-login to Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = config.system.variables.user.username;
      };
    };
  };
}
