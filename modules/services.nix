{ config, ... }:

let
  vars = config.system.variables;
in
{
  virtualisation.docker.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
  services.blueman.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Anyma uDMX / Studio Due Light Division USB-DMX interface (libusb-only).
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", MODE="0660", GROUP="dialout"
  '';

  users.users.${vars.user.username}.extraGroups = [ "docker" ];
}
