# Network configuration
{ config, ... }:

{
  networking = {
    # Set the system hostname from centralized variables
    hostName = config.system.variables.hostname;

    # Enable NetworkManager for easy network management
    networkmanager.enable = true;

    # TCP
    firewall.allowedTCPPorts = [ 43571 43572 43573 43555 8000 8080 ];

    # UDP
    firewall.allowedUDPPorts = [ 6454 7777 ];
  };
}
