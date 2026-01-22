# Nix settings and experimental features
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
}
