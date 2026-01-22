# Boot loader configuration
{ pkgs, ... }:

{
  boot.loader = {
    # Use systemd-boot as the EFI boot loader
    systemd-boot.enable = true;

    # Allow modifying EFI variables (required for systemd-boot)
    efi.canTouchEfiVariables = true;
  };
}
