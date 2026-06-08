{ pkgs, ... }:

let
  mkScript =
    name: runtimeInputs:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile (./scripts + "/${name}.sh");
    };
in
{
  home.packages = [
    (mkScript "screenshot" (
      with pkgs;
      [
        grim
        slurp
        wl-clipboard
        libnotify
        coreutils
      ]
    ))
    (mkScript "power-menu" (
      with pkgs;
      [
        wofi
        hyprlock
        libnotify
      ]
    ))
    (mkScript "theme-switcher" (
      with pkgs;
      [
        wofi
        libnotify
        git
        gnused
        gawk
        findutils
        coreutils
      ]
    ))
  ];
}
