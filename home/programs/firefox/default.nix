{ config, ... }:

let
  theme = config.theme;
  paletteVars = {
    "--my-bg"       = theme.colors.background;
    "--my-fg"       = theme.colors.foreground;
    "--my-primary"  = theme.colors.primary;
    "--my-surface0" = theme.colors.surface0;
    "--my-surface1" = theme.colors.surface1;
    "--my-surface2" = theme.colors.surface2;
    "--my-comment"  = theme.colors.comment;
  };

  rootBlock = ''
    :root {
    ${builtins.concatStringsSep "\n" (
      builtins.attrValues (builtins.mapAttrs (name: value: "  ${name}: ${value};") paletteVars)
    )}
    }

  '';

  withPalette = path: rootBlock + builtins.readFile path;
in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Disable sponsored content on new tab.
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Disable the Alt key revealing the menu bar.
        "ui.key.menuAccessKey" = 0;
        "ui.key.menuAccessKeyFocuses" = false;
      };

      userChrome  = withPalette ./userChrome.css;
      userContent = withPalette ./userContent.css;
    };
  };
}
