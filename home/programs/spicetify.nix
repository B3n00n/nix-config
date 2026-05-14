# Spicetify — themed, ad-blocked Spotify
{ config, pkgs, inputs, ... }:

let
  theme = config.theme;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;

    theme       = theme.apps.spicetify.theme;
    colorScheme = theme.apps.spicetify.colorScheme;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      playlistIcons
      fullAppDisplay
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];
  };
}
