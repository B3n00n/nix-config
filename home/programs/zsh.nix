{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lh";
      la = "ls -lha";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };

    initContent = ''
      PROMPT='%F{cyan}%~%f %(?:%F{green}➜:%F{red}➜)%f '
    '';
  };
}
