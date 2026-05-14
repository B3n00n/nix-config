{ config, ... }:

let
  vars = config.system.variables;
in
{
  programs.git = {
    enable = true;

    settings = {
      user.name  = vars.user.username;
      user.email = vars.user.email;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
      };
    };

    ignores = [ ".direnv/" ".envrc" ];
  };
}
