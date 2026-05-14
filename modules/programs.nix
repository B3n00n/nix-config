{ pkgs, ... }:
{
  # Enabled as a login shell; user-level config is in home-manager.
  programs.zsh.enable = true;

  # Required for Thunar to read its preferences.
  programs.xfconf.enable = true;

  # Thunar must be enabled at the NixOS level for plugin discovery.
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
