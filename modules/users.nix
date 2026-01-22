# User account configuration
{ config, pkgs, ... }:

let
  vars = config.system.variables;
in
{
  # Define user from centralized variables
  users.users.${vars.user.username} = {
    # Standard user account (not a system account)
    isNormalUser = true;

    # Additional groups for various permissions:
    # - wheel: sudo access
    # - networkmanager: network configuration
    # - audio: audio device access
    # - video: video device access
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];

    # Set Zsh as the default shell from variables
    shell = pkgs.${vars.user.shell};
  };
}
