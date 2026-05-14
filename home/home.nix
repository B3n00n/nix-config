# Home Manager Configuration
{ pkgs, inputs, systemVars, theme, claude-code, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  
  # Alias for easier access to system variables
  vars = systemVars;
in
{
  # Import program configurations
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./programs/kitty.nix
    ./programs/hyprland.nix
    ./programs/hyprlock.nix
    ./programs/hypridle.nix
    ./programs/gtk.nix
    ./programs/hyprpaper.nix
    ./programs/mako.nix
    ./programs/neovim.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/waybar.nix
    ./programs/wofi.nix
  ];

  # Home Manager state - using centralized variables
  home = {
    username = vars.user.username;
    homeDirectory = "/home/${vars.user.username}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11";

    # User-specific packages
    packages = [
      claude-code            # AI coding assistant (always up-to-date from flake)
    ] ++ (with pkgs; [
      # Desktop applications
      discord                # Chat application
      android-studio         # Android Studio
      godot_4_6              # Godot Engine 4.6
      (unityhub.override {   # Unity Hub (with Unity 6000 fixes)
        extraLibs = pkgs': [ pkgs'.harfbuzz ];
      })
      plasticscm-client-complete  # Plastic SCM (Unity Version Control)
      arduino-ide            # Arduino IDE
      anydesk                # Remote desktop
      drawing                # Simple paint/drawing tool
      protonvpn-gui          # ProtonVPN official GUI client
      pokemmo-installer      # PokeMMO launcher
      tiled                  # Map Editor

      # Development tools
      nixd                   # Nix language server (for VS Code & Neovim)

      # Wayland compositor tools
      wofi                   # Application launcher
      
      # Wayland utilities
      wl-clipboard           # Clipboard utilities
      cliphist               # Clipboard history
      grim                   # Screenshot utility
      slurp                  # Screen area selection
      imv                    # Image viewer
    ]);

    # Session variables using centralized configuration
    sessionVariables = {
      TERMINAL = vars.apps.terminal;
      EDITOR = vars.apps.editor;
    };
  };

  # Spicetify configuration (ad-free Spotify)
  programs.spicetify = {
    enable = true;
    
    # Theme configuration from palette
    theme = spicePkgs.themes.${theme.apps.spicetify.theme};
    colorScheme = theme.apps.spicetify.colorScheme;

    # Essential extensions for ad-blocking and functionality
    enabledExtensions = with spicePkgs.extensions; [
      adblock          # Block ads
      hidePodcasts     # Hide podcast section
      shuffle          # Shuffle+ with improved controls
      playlistIcons    # Show icons in playlists
      fullAppDisplay   # Full app display on song change
    ];

    # Custom apps
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus       # Enhanced lyrics display
      newReleases      # Show new releases
    ];
  };

  # Git configuration using centralized variables
  programs.git = {
    enable = true;

    # Use the settings structure for compatibility with latest Home Manager
    settings = {
      user = {
        name = vars.user.username;
        email = vars.user.email;
      };

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
      };
    };

    # Global gitignore for direnv and other dev tools
    ignores = [
      ".direnv/"
      ".envrc"
    ];
  };

  # Direnv configuration for directory-specific environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lh";
      la = "ls -lha";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };

    # Custom prompt to show full path from home
    initContent = ''
      # Override prompt to show full path
      PROMPT='%F{cyan}%~%f %(?:%F{green}➜:%F{red}➜)%f '
    '';
  };

  # XFCE helpers configuration for Thunar terminal integration
  # Uses centralized terminal variable
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${vars.apps.terminal}
  '';

  # MIME type associations for default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = ["nvim.desktop"];
      "text/x-log" = ["nvim.desktop"];
      "application/x-shellscript" = ["nvim.desktop"];
    };
  };

  # Custom desktop file for nvim (opens in terminal from variables)
  xdg.dataFile."applications/nvim.desktop".text = ''
    [Desktop Entry]
    Name=Neovim
    GenericName=Text Editor
    Comment=Edit text files
    Exec=${vars.apps.terminal} nvim %F
    Terminal=false
    Type=Application
    Icon=nvim
    Categories=Utility;TextEditor;
    MimeType=text/plain;text/x-log;application/x-shellscript;
  '';

  # Screenshot utility script with executable permissions
  # Screenshots will be saved to Pictures directory from variables
  home.file.".local/bin/screenshot.sh" = {
    source = ./scripts/screenshot.sh;
    executable = true;
  };

  # Theme switcher script (wofi picker → rebuild → restart services)
  home.file.".local/bin/theme-switcher.sh" = {
    source = ./scripts/theme-switcher.sh;
    executable = true;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
