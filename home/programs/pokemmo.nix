{
  config,
  lib,
  pkgs,
  ...
}:

let
  pokemmoDir = "${config.home.homeDirectory}/.local/share/pokemmo";

  gtkLibs = lib.makeLibraryPath (
    with pkgs;
    [
      gtk3
      glib
      cairo
      pango
      gdk-pixbuf
      at-spi2-core
      harfbuzz
    ]
  );

  pokemmo = pkgs.writeShellApplication {
    name = "pokemmo";
    text = ''
      updater="${pokemmoDir}/PokeMMO-Updater"

      if [ ! -x "$updater" ]; then
        echo "PokeMMO is not installed at ${pokemmoDir}." >&2
        echo "Download the Linux client from https://pokemmo.com and extract it there." >&2
        exit 1
      fi

      export LD_LIBRARY_PATH="${gtkLibs}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      cd "${pokemmoDir}"
      exec "$updater" "$@"
    '';
  };
in
{
  home.packages = [ pokemmo ];

  xdg.desktopEntries.pokemmo = {
    name = "PokeMMO";
    genericName = "MMORPG";
    comment = "Multiplayer Pokemon emulator";
    exec = "pokemmo";
    icon = "${pokemmoDir}/data/icons/128x128.png";
    terminal = false;
    type = "Application";
    categories = [
      "Game"
      "RolePlaying"
    ];
  };
}
