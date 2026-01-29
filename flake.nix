{
  description = "B3n00n's NixOS Configuration - Professional Hyprland Setup";

  inputs = {
    # NixOS unstable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (matching nixpkgs version)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify for ad-free Spotify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }@inputs: 
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
    in
    {
      # NixOS configuration for hostname from variables
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        # Make inputs available to all modules
        specialArgs = { inherit inputs; };

        modules = [
          # System configuration
          ./configuration.nix

          # Home Manager integration
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              
              # User home configuration from variables
              users.${vars.user.username} = import ./home/home.nix;

              # Make inputs and system config available to home-manager
              extraSpecialArgs = { 
                inherit inputs; 
                # Pass system variables to home-manager
                systemVars = vars;
              };
            };
          }
        ];
      };
    };
}
