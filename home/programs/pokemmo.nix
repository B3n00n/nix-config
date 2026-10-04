{ config, pkgs, ... }:

let
  pokemmoDir = "${config.home.homeDirectory}/.local/share/pokemmo";

  pokemmo = pkgs.writeShellApplication {
    name = "pokemmo";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      launcher="${pokemmoDir}/PokeMMO.sh"

      if [ ! -x "$launcher" ]; then
        echo "PokeMMO is not installed at ${pokemmoDir}." >&2
        echo "Run 'pokemmo-installer' once to download the client." >&2
        exit 1
      fi

      exec "$launcher" "$@"
    '';
  };

  installer = pkgs.pokemmo-installer.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      rm -f "$out/share/applications/pokemmo-installer.desktop"
    '';
  });
in
{
  home.packages = [
    pokemmo
    installer
  ];

  xdg.desktopEntries.pokemmo = {
    name = "PokeMMO";
    genericName = "MMORPG";
    comment = "Multiplayer Pokemon emulator";
    exec = "pokemmo";
    icon = "pokemmo-installer";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "RolePlaying"
    ];
  };
}
