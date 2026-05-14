{ config, pkgs, ... }:

let
  vars = config.system.variables;
in
{
  users.users.${vars.user.username} = {
    isNormalUser = true;
    # dialout: serial access (Arduino, uDMX).
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "dialout" ];
    shell = pkgs.zsh;
  };
}
