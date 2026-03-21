# Program-specific configurations - OS programs only
{ pkgs, ... }:

{
  # Zsh - enable as login shell (user config in home-manager)
  programs.zsh.enable = true;

  # XFCE configuration daemon (required for Thunar preferences)
  programs.xfconf.enable = true;

  # Thunar file manager (must use module for plugin discovery)
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # nix-ld — provides /lib64/ld-linux-x86-64.so.2 so precompiled binaries just work
  programs.nix-ld.enable = true;
}
