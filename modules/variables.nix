# Centralized system variables and configuration constants
# 
# This module provides a single source of truth for all configurable
# values used throughout the system. Import this module and reference
# config.system.variables.* to access these values.
#
# Usage in other modules:
#   { config, ... }: {
#     users.users.${config.system.variables.user.username} = { ... };
#   }

{ lib, ... }:

{
  options.system.variables = lib.mkOption {
    type = lib.types.attrs;
    description = "Centralized system configuration variables";
    default = {};
  };

  config.system.variables = {
    # User configuration
    user = {
      username = "benoon";
      fullName = "benoon";
      email = "benbahar321@gmail.com";
      shell = "zsh";
    };

    # System identification
    hostname = "B3n00n";
    timezone = "Asia/Jerusalem";
    locale = "en_US.UTF-8";

    # Theming
    theme = {
      name = "tokyo-night";
      cursorTheme = "Bibata-Modern-Ice";
      cursorSize = 24;
      iconTheme = "Papirus-Dark";
    };

    # Paths
    paths = {
      wallpaper = "etc/nixos/assets/wallpapers/tokyonight.jpg";
      screenshots = "~/Pictures";
    };

    # Hardware
    hardware = {
      # Monitor layout for docking station
      monitors = {
        laptop = "eDP-1";
        external1 = "DP-3";
        external2 = "DP-4";
      };
    };

    # Application defaults
    apps = {
      terminal = "kitty";
      editor = "nvim";
      browser = "firefox";
      fileManager = "thunar";
      launcher = "wofi";
    };
  };
}
