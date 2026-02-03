# Wayland compositor and desktop environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  programs.hyprland.enable = true;

  # NVIDIA + Wayland environment variables
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
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
