{ config, pkgs, ... }:

let
  theme = config.theme;

  # The extensions below are themselves .NET apps and need a runtime to execute.
  # Left alone, the .NET Install Tool downloads one, and that binary cannot run
  # on NixOS — so point every extension at a Nix-provided host instead.
  #
  # This is the *editor's* runtime, not the project's. Roslyn currently targets
  # net10.0 with rollForward=Major, so 10 is the floor; it also satisfies the
  # net8.0 MSBuild BuildHost. Project SDKs stay in each project's devShell.
  dotnetHost = "${pkgs.dotnet-runtime_10}/share/dotnet/dotnet";

  # C#/Unity extension stack, in dependency order:
  #   .NET Install Tool → C# → IntelliCode → C# Dev Kit → Unity
  # The .NET SDK itself is project-scoped: each project's flake devShell
  # provides it via direnv (see the project's flake.nix / .envrc).
  dotnetExtensions =
    (with pkgs.vscode-extensions.ms-dotnettools; [
      vscode-dotnet-runtime    # .NET Install Tool — required by everything below
      csharp                   # C# language server (Roslyn)
      vscodeintellicode-csharp # IntelliCode — required by C# Dev Kit
      csdevkit                 # C# Dev Kit — required by the Unity extension
    ])
    ++ [
      pkgs.vscode-extensions.visualstudiotoolsforunity.vstuc # Unity integration
    ];
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
      ]
      ++ dotnetExtensions;

      userSettings = {
        "workbench.colorTheme" = theme.apps.vscode.colorTheme;
        "workbench.iconTheme" = "vscode-icons";

        "editor.fontFamily" = "'${theme.fonts.monospace}', monospace";
        "editor.fontSize" = theme.fonts.size.normal + 2;
        "terminal.integrated.fontFamily" = "'${theme.fonts.terminal}'";

        "editor.formatOnSave" = true;
        "editor.tabSize" = 2;
        "editor.wordWrap" = "on";

        "files.autoSave" = "afterDelay";
        "files.trimTrailingWhitespace" = true;

        "dotnetAcquisitionExtension.sharedExistingDotnetPath" = dotnetHost;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
      };
    };
  };
}
