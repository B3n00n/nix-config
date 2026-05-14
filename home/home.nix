{ config, pkgs, inputs, claude-code, ... }:

let
  vars = config.system.variables;
in
{
  imports = [
    ../modules/variables.nix
    ../modules/theme.nix

    inputs.spicetify-nix.homeManagerModules.default

    ./programs/direnv.nix
    ./programs/firefox
    ./programs/git.nix
    ./programs/gtk.nix
    ./programs/hypridle.nix
    ./programs/hyprland
    ./programs/hyprlock.nix
    ./programs/hyprpaper.nix
    ./programs/kitty.nix
    ./programs/mako.nix
    ./programs/neovim
    ./programs/spicetify.nix
    ./programs/vscode.nix
    ./programs/waybar
    ./programs/wofi.nix
    ./programs/zsh.nix

    ./xdg.nix
    ./scripts.nix
    ./templates.nix
  ];

  home = {
    username = vars.user.username;
    homeDirectory = "/home/${vars.user.username}";

    # Don't change. See the HM release notes before bumping.
    stateVersion = "25.11";

    packages = [
      claude-code
    ] ++ (with pkgs; [
      discord
      android-studio
      godot_4_6
      (unityhub.override { extraLibs = pkgs': [ pkgs'.harfbuzz ]; })  # Unity 6000 fix
      plasticscm-client-complete
      arduino-ide
      anydesk
      drawing
      protonvpn-gui
      pokemmo-installer
      tiled

      nixd

      wofi
      wl-clipboard
      cliphist
      grim
      slurp
      imv
    ]);

    # EDITOR comes from programs.neovim.defaultEditor.
    sessionVariables.TERMINAL = vars.apps.terminal;
  };

  programs.home-manager.enable = true;
}
