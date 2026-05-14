# Centralized, typed system variables.
#
{ lib, ... }:

let
  inherit (lib) mkOption types;

  userType = types.submodule {
    options = {
      username = mkOption { type = types.str; };
      email    = mkOption { type = types.str; };
    };
  };

  themeType = types.submodule {
    options = {
      name        = mkOption { type = types.str; description = "Palette name under modules/theme/palettes/."; };
      cursorTheme = mkOption { type = types.str; };
      cursorSize  = mkOption { type = types.ints.positive; };
    };
  };

  monitorsType = types.submodule {
    options = {
      laptop    = mkOption { type = types.str; description = "Built-in display (run `hyprctl monitors` to find names)."; };
      external1 = mkOption { type = types.str; description = "Dock layout: centre monitor."; };
      external2 = mkOption { type = types.str; description = "Dock layout: left monitor."; };
    };
  };

  hardwareType = types.submodule {
    options.monitors = mkOption { type = monitorsType; };
  };

  appsType = types.submodule {
    options = {
      terminal    = mkOption { type = types.str; };
      editor      = mkOption { type = types.str; };
      browser     = mkOption { type = types.str; };
      fileManager = mkOption { type = types.str; };
      launcher    = mkOption { type = types.str; };
    };
  };

  variablesType = types.submodule {
    options = {
      hostname = mkOption { type = types.str; };
      timezone = mkOption { type = types.str; };
      locale   = mkOption { type = types.str; };
      user     = mkOption { type = userType; };
      theme    = mkOption { type = themeType; };
      hardware = mkOption { type = hardwareType; };
      apps     = mkOption { type = appsType; };
    };
  };
in
{
  options.system.variables = mkOption {
    type = variablesType;
  };

  config.system.variables = {
    hostname = "B3n00n";
    timezone = "Asia/Jerusalem";
    locale   = "en_US.UTF-8";

    user = {
      username = "benoon";
      email    = "benbahar321@gmail.com";
    };

    theme = {
      name        = "dracula";
      cursorTheme = "Bibata-Modern-Ice";
      cursorSize  = 24;
    };

    hardware.monitors = {
      laptop    = "eDP-1";
      external1 = "DP-3";
      external2 = "DP-4";
    };

    apps = {
      terminal    = "kitty";
      editor      = "nvim";
      browser     = "firefox";
      fileManager = "thunar";
      launcher    = "wofi";
    };
  };
}
