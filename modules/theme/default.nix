# Theme resolver.
#
{ themeName, lib, pkgs, spicePkgs }:

let
  palettes = {
    "tokyo-night" = import ./palettes/tokyo-night.nix;
    "dracula"     = import ./palettes/dracula.nix;
  };

  schemas         = import ./types.nix { inherit lib; };
  colorLib        = import ./lib.nix;
  rawIntegrations = import ./integrations.nix { inherit pkgs spicePkgs; };

  defaults = {
    fonts = {
      monospace = "JetBrains Mono";
      sansSerif = "Noto Sans";
      terminal  = "JetBrains Mono";
      size.normal = 11;
    };
    border = { width = 2; radius = 10; };
  };

  available = builtins.concatStringsSep ", " (builtins.attrNames palettes);

  rawPalette = palettes.${themeName}
    or (throw "Unknown theme '${themeName}'. Available: ${available}");

  rawIntegration = rawIntegrations.${themeName}
    or (throw "No integrations for '${themeName}'. Add an entry in modules/theme/integrations.nix.");

  # Defaults use mkDefault so palette values win the merge.
  evaluatedPalette = lib.evalModules {
    modules = [
      schemas.palette
      { config = lib.mapAttrsRecursive (_: lib.mkDefault) defaults; }
      { config = rawPalette; }
    ];
  };

  evaluatedIntegration = lib.evalModules {
    modules = [
      schemas.integration
      { config = rawIntegration; }
    ];
  };
in
  evaluatedPalette.config
    // { apps = evaluatedIntegration.config; }
    // { inherit (colorLib) hexToRgba removeHash; }
