{ ... }:
{
  imports = [
    ./hardware-configuration.nix

    ./modules/variables.nix
    ./modules/theme.nix

    ./modules/nix-settings.nix
    ./modules/overlays.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/audio.nix
    ./modules/nvidia.nix
    ./modules/wayland.nix
    ./modules/users.nix
    ./modules/programs.nix
    ./modules/nix-ld.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/services.nix
  ];

  system.stateVersion = "25.11";
}
