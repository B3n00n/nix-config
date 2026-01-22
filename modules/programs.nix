# Program-specific configurations - OS programs only
{ pkgs, ... }:

{
  # Zsh shell configuration (system-level)
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Shell aliases
    shellAliases = {
      # File operations
      ls = "ls --color=auto";
      ll = "ls -lh";
      la = "ls -lha";

      # Grep with color
      grep = "grep --color=auto";

      # Quick navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
    };

    # Interactive shell initialization
    interactiveShellInit = ''
      # Rust environment
      if [ -d "$HOME/.cargo/bin" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
      fi

      # Custom Tokyo Night themed prompt
      # Shows: username ~/current/full/path (git branch if in git repo) $
      autoload -Uz vcs_info
      precmd() { vcs_info }

      # Enable git info in prompt
      zstyle ':vcs_info:git:*' formats ' (%b)'
      zstyle ':vcs_info:*' enable git

      # Set custom prompt with colors
      # Cyan username, Green path, Purple git branch, Cyan prompt symbol
      setopt PROMPT_SUBST
      PROMPT='%F{cyan}%n%f %F{green}%~%f%F{magenta}''${vcs_info_msg_0_}%f %F{cyan}$%f '
    '';

    # Oh-My-Zsh framework for Zsh
    ohMyZsh = {
      enable = true;
      theme = "";  # Disable to use custom prompt
      plugins = [ "git" ];
    };
  };

  # XFCE configuration daemon (required for Thunar preferences)
  programs.xfconf.enable = true;
}
