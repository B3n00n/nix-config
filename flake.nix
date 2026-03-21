{
  description = "B3n00n's NixOS Configuration - Professional Hyprland Setup";

  inputs = {
    # NixOS stable channel (25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager (matching nixpkgs version)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify for ad-free Spotify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Always up-to-date Claude Code
    claude-code-nix = {
      url = "github:sadjow/claude-code-nix";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, claude-code-nix, ... }@inputs: 
    let
      # System architecture
      system = "x86_64-linux";
      
      # Import our centralized variables
      # We evaluate the variables module to get the actual values
      varsModule = import ./modules/variables.nix { 
        lib = nixpkgs.lib; 
      };
      
      # Extract the variables for easy access
      vars = varsModule.config.system.variables;

      # Resolve theme from variables
      theme = import ./modules/theme { themeName = vars.theme.name; lib = nixpkgs.lib; };
    in
    {
      # NixOS configuration for hostname from variables
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        # Make inputs available to all modules
        specialArgs = { inherit inputs; };

        modules = [
          # Fix stale hashes for plasticscm packages in nixpkgs
          # (upstream republishes debs without version bumps)
          ({ ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                plasticscm-theme = prev.plasticscm-theme.overrideAttrs (old: {
                  src = prev.fetchurl {
                    url = old.src.url;
                    hash = "sha256-gs9XGqpgxWue+Cke8x5FeyUDfQK8R/IrwWP59NRmubI=";
                  };
                });
                plasticscm-client-core-unwrapped = prev.plasticscm-client-core-unwrapped.overrideAttrs (old: {
                  src = prev.fetchurl {
                    url = old.src.url;
                    hash = "sha256-/tfZLJ3a/6Jdk3opRKs+3/l09bFViN7/YuQ0hxVy4J8=";
                  };
                });
                plasticscm-client-gui-unwrapped = prev.plasticscm-client-gui-unwrapped.overrideAttrs (old: {
                  src = prev.fetchurl {
                    url = old.src.url;
                    hash = "sha256-cilxGuy5Y6t/UImje0625qrfwgNp1gp7qKA1fpPcw2g=";
                  };
                });
              })
            ];
          })

          # System configuration
          ./configuration.nix

          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              
              # User home configuration from variables
              users.${vars.user.username} = import ./home/home.nix;

              # Make inputs and system config available to home-manager
              extraSpecialArgs = {
                inherit inputs theme;
                # Pass system variables to home-manager
                systemVars = vars;
                # Pass always-up-to-date Claude Code to home-manager
                inherit (claude-code-nix.packages.${system}) claude-code;
              };
            };
          }
        ];
      };
    };
}
