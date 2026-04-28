# Nix daemon settings, garbage collection, and nixpkgs config
{ ... }:

{
  nix = {
    # Enable flakes and new nix command
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      # Optimize storage automatically by hardlinking identical files
      auto-optimise-store = true;
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Allow proprietary packages (Discord, Spotify, NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;
}
