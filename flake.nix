{
  description = "B3n00n's NixOS — Hyprland on NVIDIA";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code-nix.url = "github:sadjow/claude-code-nix";
  };

  outputs = { nixpkgs, home-manager, claude-code-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      vars = (nixpkgs.lib.evalModules {
        modules = [ ./modules/variables.nix ];
      }).config.system.variables;
    in
    {
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";

              users.${vars.user.username} = import ./home/home.nix;

              extraSpecialArgs = {
                inherit inputs;
                inherit (claude-code-nix.packages.${system}) claude-code;
              };
            };
          }
        ];
      };
    };
}
