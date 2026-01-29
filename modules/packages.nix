# System-wide package installation
#
# Only essential system-level packages should be here.
# User applications and GUI tools belong in home-manager.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core system utilities
    neovim              # System editor (also configured in home-manager)
    wget                # Download utility
    git                 # Version control
    gh                  # GitHub CLI
    btop                # Process monitor
    neofetch            # System information
    claude-code         # AI coding assistant
    tree                # Directory tree visualization

    # Archive tools
    unzip               # ZIP extraction
    zip                 # ZIP compression
    p7zip               # 7-Zip support
    unrar               # RAR extraction
    file-roller         # Archive manager GUI (required for Thunar integration)

    # File management
    thunar                        # Lightweight file manager
    thunar-archive-plugin         # Archive extraction in Thunar
    thunar-volman                 # Automatic volume management
    tumbler                       # Thumbnail service
    xfce4-exo                     # Application launcher (for "Open Terminal Here")
    
    # File type detection and theming
    shared-mime-info              # MIME type database
    papirus-icon-theme            # Icon theme
    gnome-icon-theme              # Fallback icons
    ffmpegthumbnailer             # Video thumbnails
    bibata-cursors                # Cursor theme
    
    # XDG utilities
    xdg-utils                     # XDG desktop integration

    # System utilities
    brightnessctl                 # Brightness control
    pamixer                       # Audio mixer
    pavucontrol                   # PulseAudio GUI
    networkmanagerapplet          # NetworkManager GUI
    playerctl                     # Media player control

    # Bluetooth utilities
    bluez                         # Bluetooth protocol stack
    bluez-tools                   # Additional Bluetooth tools
    blueman                       # Bluetooth manager GUI
  ];
}
