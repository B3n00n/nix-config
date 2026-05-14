{ config, lib, pkgs, inputs, ... }:
{
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
  };

  config.theme = import ./theme {
    inherit lib pkgs;
    themeName = config.system.variables.theme.name;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  };
}
