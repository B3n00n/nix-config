# Firefox Browser Configuration
{ theme, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        # Enable custom stylesheets
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Disable sponsored content
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };

      userChrome = ''
        /* Firefox chrome themed from NixOS palette */

        :root {
          --my-bg: ${theme.colors.background};
          --my-fg: ${theme.colors.foreground};
          --my-primary: ${theme.colors.primary};
          --my-surface0: ${theme.colors.surface0};
          --my-surface1: ${theme.colors.surface1};
          --my-surface2: ${theme.colors.surface2};
          --my-comment: ${theme.colors.comment};
        }

        /* ── Frame & toolbox ────────────────────────────────────── */

        #navigator-toolbox {
          background: var(--my-bg) !important;
          border-bottom: none !important;
        }

        /* ── Tab bar ────────────────────────────────────────────── */

        #TabsToolbar {
          background: var(--my-surface0) !important;
        }

        .tabbrowser-tab {
          color: var(--my-comment) !important;
        }

        .tab-background[selected] {
          background: var(--my-bg) !important;
          border-bottom: 2px solid var(--my-primary) !important;
        }

        .tabbrowser-tab[selected] {
          color: var(--my-fg) !important;
        }

        .tabbrowser-tab:not([selected]):hover .tab-background {
          background: var(--my-surface1) !important;
        }

        /* New tab button */
        #tabs-newtab-button,
        #new-tab-button {
          color: var(--my-comment) !important;
        }

        #tabs-newtab-button:hover,
        #new-tab-button:hover {
          color: var(--my-primary) !important;
        }

        /* ── Navigation bar ─────────────────────────────────────── */

        #nav-bar {
          background: var(--my-bg) !important;
          border-top: 1px solid var(--my-surface1) !important;
        }

        /* ── URL bar ────────────────────────────────────────────── */

        #urlbar-background {
          background: var(--my-surface1) !important;
          border: 1px solid var(--my-surface2) !important;
        }

        #urlbar[focused] #urlbar-background {
          border-color: var(--my-primary) !important;
        }

        #urlbar-input {
          color: var(--my-fg) !important;
        }

        /* URL bar results dropdown */
        .urlbarView {
          background: var(--my-bg) !important;
          color: var(--my-fg) !important;
        }

        .urlbarView-row[selected] {
          background: var(--my-surface1) !important;
        }

        .urlbarView-row:hover {
          background: var(--my-surface1) !important;
        }

        /* ── Bookmarks toolbar ──────────────────────────────────── */

        #PersonalToolbar {
          background: var(--my-bg) !important;
          color: var(--my-fg) !important;
        }

        /* ── Sidebar ────────────────────────────────────────────── */

        #sidebar-box {
          background: var(--my-surface0) !important;
          color: var(--my-fg) !important;
        }

        #sidebar-header {
          background: var(--my-surface0) !important;
          color: var(--my-fg) !important;
          border-bottom: 1px solid var(--my-surface1) !important;
        }

        /* ── Panels & popups ────────────────────────────────────── */

        .panel-arrowcontent,
        panel,
        panelview {
          background: var(--my-bg) !important;
          color: var(--my-fg) !important;
        }

        /* ── Context menus ──────────────────────────────────────── */

        menupopup {
          --panel-background: var(--my-bg) !important;
          --panel-color: var(--my-fg) !important;
        }

        menuitem:hover,
        menu:hover {
          background: var(--my-surface1) !important;
        }

        /* ── Findbar ────────────────────────────────────────────── */

        .browserContainer > findbar {
          background: var(--my-bg) !important;
          color: var(--my-fg) !important;
        }
      '';

      userContent = ''
        /* New tab and home page */
        @-moz-document url("about:newtab"), url("about:home") {
          body {
            background-color: ${theme.colors.background} !important;
          }

          .top-site-outer .tile {
            background-color: ${theme.colors.surface0} !important;
          }
        }
      '';
    };
  };
}
