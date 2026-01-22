# Network configuration
{ config, ... }:

{
  networking = {
    # Set the system hostname from centralized variables
    hostName = config.system.variables.hostname;

    # Enable NetworkManager for easy network management
    networkmanager.enable = true;
  };
}
