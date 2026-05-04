# Wayland compositor and desktop environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland Wayland compositor
  # NVIDIA-specific compositor env lives in home/programs/hyprland.nix so it's
  # injected into Hyprland directly rather than via /etc/profile.
  programs.hyprland.enable = true;

  # Portal config lives in home-manager (home/programs/hyprland.nix). With
  # home-manager.useUserPackages, NIX_XDG_DESKTOP_PORTAL_DIR points at the
  # per-user profile, so portals must be installed there to be discovered.
  xdg.portal.enable = true;

  # dconf service must run for xdg-desktop-portal-gtk to read color-scheme
  # and answer org.freedesktop.appearance queries from apps like Firefox.
  programs.dconf.enable = true;

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
