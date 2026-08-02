# Shell scripts wrapped with their runtime closures. writeShellApplication
# supplies the shebang and `set -euo pipefail`, so the .sh files carry neither.
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
  home.packages = with pkgs; [
    (mkScript "screenshot" [
      grim
      slurp
      wl-clipboard
      libnotify
      coreutils
    ])

    (mkScript "power-menu" [
      wofi
      hyprland
      systemd
      libnotify
    ])

    (mkScript "theme-switcher" [
      wofi
      systemd
      libnotify
      git
      gnused
      gawk
      findutils
      coreutils
    ])
  ];
}
