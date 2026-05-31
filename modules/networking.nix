{ config, ... }:

let
  vars = config.system.variables;
in
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;

    networkmanager.ensureProfiles.profiles = {
      home-wired = {
        connection = {
          id = "home-wired";
          type = "ethernet";
          autoconnect = true;
          autoconnect-priority = 10;
        };
        ethernet.mac-address = "80:CA:52:B5:E4:89";
        ipv4 = {
          method = "manual";
          address1 = "192.168.50.128/24,192.168.50.1";
          dns = "1.1.1.1;9.9.9.9;";
        };
        ipv6.method = "auto";
      };
    };

    firewall.allowedTCPPorts = [ 43571 43572 43573 43555 8000 8080 ];
    firewall.allowedUDPPorts = [ 6454 7777 ];
  };
}
