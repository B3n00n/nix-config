{ pkgs, ... }:
{
  # Enabled as a login shell; user-level config is in home-manager.
  programs.zsh.enable = true;

  # Required for Thunar to read its preferences.
  programs.xfconf.enable = true;

  # Thunar must be enabled at the NixOS level for plugin discovery.
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Steam must be a NixOS program, not a home-manager package: the module
  # injects hardware.graphics.package32 into Steam's FHS env, enables the
  # steam-hardware udev rules, 32-bit pipewire, and the firewall ports.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall                = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
