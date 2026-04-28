# Wayland compositor and desktop environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  # NVIDIA-specific compositor env lives in home/programs/hyprland.nix so it's
  # injected into Hyprland directly rather than via /etc/profile.
  programs.hyprland.enable = true;

  # XDG portal configuration (programs.hyprland already enables portal + hyprland backend)
  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

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
