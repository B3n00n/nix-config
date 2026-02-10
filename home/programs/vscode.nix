# VS Code Configuration

{ pkgs, theme, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = [
        # Theme
        pkgs.vscode-extensions.${theme.apps.vscode.extension.publisher}.${theme.apps.vscode.extension.name}

        # Icons
        pkgs.vscode-extensions.vscode-icons-team.vscode-icons

        # Language support
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.rust-lang.rust-analyzer

        # Environment
        pkgs.vscode-extensions.mkhl.direnv
      ];

      userSettings = {
        # Theme
        "workbench.colorTheme" = theme.apps.vscode.colorTheme;
        "workbench.iconTheme" = "vscode-icons";

        # Fonts
        "editor.fontFamily" = "'${theme.fonts.monospace}', monospace";
        "editor.fontSize" = theme.fonts.size.normal + 2;
        "terminal.integrated.fontFamily" = "'${theme.fonts.terminal}'";

        # Editor
        "editor.formatOnSave" = true;
        "editor.tabSize" = 2;
        "editor.wordWrap" = "on";

        # Files
        "files.autoSave" = "afterDelay";
        "files.trimTrailingWhitespace" = true;

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
    };
  };
}
