{ config, pkgs, ... }:

let
  vars = config.system.variables;
in
{
  programs.hyprland.enable = true;

  xdg.portal.enable = true;

  programs.dconf.enable = true;

  security.polkit.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = vars.user.username;
    };
  };
}
