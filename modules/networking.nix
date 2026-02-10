# Network configuration
{ config, ... }:

{
  networking = {
    # Set the system hostname from centralized variables
    hostName = config.system.variables.hostname;

    # Enable NetworkManager for easy network management
    networkmanager.enable = true;

    # Open ports for Arceus (TCP server, HTTP server, Alakazam API)
    firewall.allowedTCPPorts = [ 43571 43572 43573 ];
  };
}
