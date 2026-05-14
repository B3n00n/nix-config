{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      plasticscm-theme = prev.plasticscm-theme.overrideAttrs (old: {
        src = prev.fetchurl {
          url = old.src.url;
          hash = "sha256-gs9XGqpgxWue+Cke8x5FeyUDfQK8R/IrwWP59NRmubI=";
        };
      });
      plasticscm-client-core-unwrapped = prev.plasticscm-client-core-unwrapped.overrideAttrs (old: {
        src = prev.fetchurl {
          url = old.src.url;
          hash = "sha256-/tfZLJ3a/6Jdk3opRKs+3/l09bFViN7/YuQ0hxVy4J8=";
        };
      });
      plasticscm-client-gui-unwrapped = prev.plasticscm-client-gui-unwrapped.overrideAttrs (old: {
        src = prev.fetchurl {
          url = old.src.url;
          hash = "sha256-cilxGuy5Y6t/UImje0625qrfwgNp1gp7qKA1fpPcw2g=";
        };
      });
    })
  ];
}
