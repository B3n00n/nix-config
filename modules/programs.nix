{ pkgs, ... }:
{
  programs.zsh.enable = true;

  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.teamviewer.enable = true;
}
