# System services configuration
{ pkgs, config, ... }:

{
  # Docker virtualization
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Add user to docker group
  users.users.${config.variables.mainUser}.extraGroups = [ "docker" ];
}
