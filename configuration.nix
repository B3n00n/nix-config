# NixOS system configuration
#
# This is the main configuration file that imports all modular components.
# Edit specific modules in ./modules/ for focused configuration changes.
#
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ ... }:

{
  imports = [
    # Hardware configuration (auto-generated)
    ./hardware-configuration.nix

    # Centralized variables and configuration constants
    ./modules/variables.nix

    # Modular system configuration
    ./modules/nix-settings.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/audio.nix
    ./modules/wayland.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/packages.nix
    ./modules/theme.nix
    ./modules/services.nix
  ];

  # Allow proprietary packages (Discord, Spotify, etc.)
  nixpkgs.config.allowUnfree = true;

  # NixOS release version - DO NOT CHANGE
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of your first install.
  system.stateVersion = "25.11";
}
