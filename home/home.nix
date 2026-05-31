{ config, pkgs, inputs, ... }:

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

    stateVersion = "26.05";

    packages = with pkgs; [
      # CLI
      claude-code
      nixd

      # Comms / media
      discord

      # Dev
      android-studio
      arduino-ide
      godot_4_6
      plasticscm-client-complete
      (unityhub.override { extraLibs = pkgs': [ pkgs'.harfbuzz ]; })  # Unity 6000 fix
      tiled

      # Utilities
      anydesk
      drawing
      pokemmo-installer
      proton-vpn

      # Wayland tooling
      cliphist
      grim
      imv
      slurp
      wl-clipboard
      wofi
    ];

    # EDITOR comes from programs.neovim.defaultEditor.
    sessionVariables.TERMINAL = vars.apps.terminal;
  };

  programs.home-manager.enable = true;
}
