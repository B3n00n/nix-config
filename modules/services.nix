# System services configuration
{ pkgs, config, ... }:

{
  # Docker virtualization
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Bluetooth manager service
  services.blueman.enable = true;

  # Add user to docker group
  users.users.${config.system.variables.user.username}.extraGroups = [ "docker" ];
}
