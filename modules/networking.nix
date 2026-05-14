{ config, ... }:

let
  vars = config.system.variables;
in
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 43571 43572 43573 43555 8000 8080 ];
    firewall.allowedUDPPorts = [ 6454 7777 ];
  };
}
