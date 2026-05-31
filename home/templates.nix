# Thunar "Create Document" templates.
{ lib, pkgs, ... }:

let
  templates = {
    "Empty.txt"    = { text = "\n"; };
    "Document.md"  = { text = "\n"; };
    "Data.json"    = { text = "{\n\n}\n"; };
    "Module.nix"   = { text = "{ config, lib, pkgs, ... }:\n{\n\n}\n"; };
    "Script.sh"    = { executable = true; text = ''
      #!/usr/bin/env bash
      set -euo pipefail

    ''; };
    "Script.py"    = { executable = true; text = ''
      #!/usr/bin/env python3

      def main() -> None:
          pass


      if __name__ == "__main__":
          main()
    ''; };
  };

  mkTemplate = name: { text, executable ? false }: {
    name = "Templates/${name}";
    value = {
      source = pkgs.writeText name text;
      inherit executable;
    };
  };
in
{
  home.file = lib.mapAttrs' mkTemplate templates;
}
