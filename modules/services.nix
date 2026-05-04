# System services configuration
{ pkgs, config, ... }:

{
  # Docker virtualization
  virtualisation.docker.enable = true;

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

  # USB automounting support
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Anyma uDMX / Studio Due Light Division USB-DMX interface
  # Grants dialout group access to the libusb-only device (16c0:05dc).
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", MODE="0660", GROUP="dialout"
  '';

  # Add user to docker group
  users.users.${config.system.variables.user.username}.extraGroups = [ "docker" ];
}
