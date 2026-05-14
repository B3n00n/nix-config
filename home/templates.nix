# Thunar "Create Document" templates.
{ pkgs, lib, ... }:

let
  templates = {
    "Empty.txt" = "\n";
    "Document.md" = "\n";
    "Script.sh" = ''
      #!/usr/bin/env bash
      set -euo pipefail

    '';
    "Module.nix" = ''
      { config, lib, pkgs, ... }:
      {

      }
    '';
    "Script.py" = ''
      #!/usr/bin/env python3

      def main() -> None:
          pass


      if __name__ == "__main__":
          main()
    '';
    "Data.json" = ''
      {

      }
    '';
  };
in
{
  home.activation.thunarTemplates = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatStringsSep "\n" (
      [ "run install -dm755 $HOME/Templates" ]
      ++ lib.mapAttrsToList (name: content:
        "run install -m644 ${pkgs.writeText name content} $HOME/Templates/${name}"
      ) templates
      ++ [ "run chmod +x $HOME/Templates/Script.sh $HOME/Templates/Script.py" ]
    )
  );
}
