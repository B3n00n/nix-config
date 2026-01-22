# Home Manager Configuration
{ pkgs, inputs, systemVars, ... }:

let
  # Import Tokyo Night theme
  theme = import ../modules/theme/tokyo-night.nix;
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
    ./programs/waybar.nix
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
    packages = with pkgs; [
      # Desktop applications
      firefox                # Web browser
      vscode                 # Code editor
      discord                # Chat application
      android-studio         # Android Studio
      
      # Terminal and shell
      kitty                  # Terminal emulator
      zsh                    # Z shell
      oh-my-zsh              # Zsh framework

      # Wayland compositor tools
      waybar                 # Status bar
      wofi                   # Application launcher
      hyprpaper              # Wallpaper daemon
      mako                   # Notification daemon
      hyprlock               # Screen locker
      hypridle               # Idle daemon
      
      # Wayland utilities
      wl-clipboard           # Clipboard utilities
      cliphist               # Clipboard history
      grim                   # Screenshot utility
      slurp                  # Screen area selection
      imv                    # Image viewer
    ];

    # Session variables using centralized configuration
    sessionVariables = {
      TERMINAL = vars.apps.terminal;
      EDITOR = vars.apps.editor;
    };
  };

  # Spicetify configuration (ad-free Spotify)
  programs.spicetify = {
    enable = true;
    
    # Theme configuration (Tokyo Night style)
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    # Essential extensions for ad-blocking and functionality
    enabledExtensions = with spicePkgs.extensions; [
      adblock          # Block ads
      hidePodcasts     # Hide podcast section
      shuffle          # Shuffle+ with improved controls
      playlistIcons    # Show icons in playlists
      lastfm           # Last.fm scrobbling
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

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "direnv" ];
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

  # Wofi configuration
  home.file.".config/wofi/config".text = ''
    width=600
    height=400
    location=center
    show=drun
    prompt=Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=32
    gtk_dark=true
  '';

  home.file.".config/wofi/style.css".text = ''
    * {
        font-family: "${theme.fonts.monospace}", monospace;
        font-size: 14px;
        font-weight: bold;
    }

    window {
        margin: 0px;
        border: 2px solid ${theme.colors.cyan};
        background-color: ${theme.colors.background};
        border-radius: 0px;
    }

    #input {
        margin: 8px;
        padding: 8px 12px;
        border: 1px solid ${theme.colors.cyan};
        color: ${theme.colors.foreground};
        background-color: ${theme.colors.gray2};
        border-radius: 0px;
    }

    #input:focus {
        border: 1px solid ${theme.colors.green};
        outline: none;
    }

    #inner-box {
        margin: 8px;
        border: none;
        background-color: ${theme.colors.background};
    }

    #outer-box {
        margin: 0px;
        border: none;
        background-color: ${theme.colors.background};
    }

    #scroll {
        margin: 0px;
        border: none;
    }

    #text {
        margin: 4px;
        padding: 4px;
        color: ${theme.colors.foreground};
    }

    #text:selected {
        color: ${theme.colors.background};
    }

    #entry {
        margin: 2px;
        padding: 8px;
        border: 1px solid transparent;
        background-color: transparent;
    }

    #entry:selected {
        border: 1px solid ${theme.colors.cyan};
        background-color: ${theme.colors.cyan};
        color: ${theme.colors.background};
    }

    #entry:hover {
        background-color: rgba(51, 204, 255, 0.2);
    }

    #img {
        margin-right: 8px;
    }
  '';

  # Screenshot utility script with executable permissions
  # Screenshots will be saved to Pictures directory from variables
  home.file.".local/bin/screenshot.sh" = {
    source = ./scripts/screenshot.sh;
    executable = true;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
