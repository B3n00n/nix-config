# System-wide packages. Keep this short — user apps belong in home-manager.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Shell tools
    neovim wget git gh btop fastfetch tree

    # Archives
    unzip zip p7zip unrar
    file-roller                   # Thunar archive plugin

    # Thunar
    xfce.tumbler
    xfce.exo                      # "Open Terminal Here"

    # File typing + theming
    shared-mime-info
    papirus-icon-theme
    adwaita-icon-theme            # portal-gtk fallback icons
    ffmpegthumbnailer
    bibata-cursors

    xdg-utils

    # System utilities
    brightnessctl pamixer pavucontrol networkmanagerapplet playerctl

    # Bluetooth
    bluez bluez-tools blueman
  ];
}
