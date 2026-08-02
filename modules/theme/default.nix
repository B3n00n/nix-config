# Home-manager module: resolves the palette named in variables.nix and exposes
# the whole thing as `config.theme`.
{ config, lib, pkgs, inputs, ... }:
{
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
  };

  config.theme = import ./resolve.nix {
    inherit lib pkgs;
    themeName = config.system.variables.theme.name;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  };
}
