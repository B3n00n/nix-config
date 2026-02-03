# NVIDIA GPU configuration for Wayland/Hyprland
# Optimized for RTX 40/50 series cards
{ config, ... }:

{
  # Load NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for Wayland compositors
    modesetting.enable = true;

    # Power management - helps with suspend/resume
    powerManagement.enable = true;

    # Use open source kernel module (recommended for RTX 20xx+)
    # RTX 40/50 series have full support
    open = true;

    # Enable nvidia-settings GUI tool
    nvidiaSettings = true;

    # Use the stable driver package
    package = config.hardware.nvidia.package;
  };

  # Enable graphics/OpenGL support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # For 32-bit applications (Steam, Wine, etc.)
  };
}
