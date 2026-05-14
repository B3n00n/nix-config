{ config, pkgs, ... }:

let
  theme = config.theme;
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = [
        theme.apps.vscode.extension

        pkgs.vscode-extensions.vscode-icons-team.vscode-icons
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.rust-lang.rust-analyzer
        pkgs.vscode-extensions.mkhl.direnv
      ];

      userSettings = {
        "workbench.colorTheme" = theme.apps.vscode.colorTheme;
        "workbench.iconTheme"  = "vscode-icons";

        "editor.fontFamily" = "'${theme.fonts.monospace}', monospace";
        "editor.fontSize"   = theme.fonts.size.normal + 2;
        "terminal.integrated.fontFamily" = "'${theme.fonts.terminal}'";

        "editor.formatOnSave" = true;
        "editor.tabSize"      = 2;
        "editor.wordWrap"     = "on";

        "files.autoSave"               = "afterDelay";
        "files.trimTrailingWhitespace" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath"           = "nixd";
      };
    };
  };
}
