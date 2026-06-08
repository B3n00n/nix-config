{ config, ... }:

let
  theme = config.theme;
in
{
  programs.zathura = {
    enable = true;

    options = {
      recolor = true;
      recolor-keephue = true;
      recolor-lightcolor = theme.colors.background;
      recolor-darkcolor = theme.colors.foreground;

      default-bg = theme.colors.background;
      default-fg = theme.colors.foreground;

      statusbar-bg = theme.colors.surface0;
      statusbar-fg = theme.colors.foreground;
      inputbar-bg = theme.colors.surface0;
      inputbar-fg = theme.colors.foreground;

      highlight-color = theme.colors.yellow;
      highlight-active-color = theme.colors.primary;

      completion-bg = theme.colors.surface0;
      completion-fg = theme.colors.foreground;
      completion-highlight-bg = theme.colors.primary;
      completion-highlight-fg = theme.colors.background;

      notification-bg = theme.colors.surface0;
      notification-fg = theme.colors.foreground;
      notification-error-bg = theme.colors.red;
      notification-error-fg = theme.colors.background;
      notification-warning-bg = theme.colors.yellow;
      notification-warning-fg = theme.colors.background;
    };
  };
}
