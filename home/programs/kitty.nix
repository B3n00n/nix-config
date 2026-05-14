{ config, ... }:

let
  theme = config.theme;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = theme.fonts.terminal;
      size = theme.fonts.size.normal;
    };

    settings = {
      confirm_os_window_close = 0;

      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;

      cursor_shape = "block";
      cursor_blink_interval = 0;
      scrollback_lines = 10000;
      mouse_hide_wait = "3.0";

      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;
      window_padding_width = 4;

      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";

      foreground = theme.colors.foreground;
      background = theme.colors.background;

      selection_foreground = theme.colors.background;
      selection_background = theme.colors.primary;

      cursor = theme.colors.foreground;
      cursor_text_color = theme.colors.background;

      url_color = theme.colors.blue;

      color0  = theme.terminal.black;
      color1  = theme.terminal.red;
      color2  = theme.terminal.green;
      color3  = theme.terminal.yellow;
      color4  = theme.terminal.blue;
      color5  = theme.terminal.magenta;
      color6  = theme.terminal.cyan;
      color7  = theme.terminal.white;
      color8  = theme.terminal.brightBlack;
      color9  = theme.terminal.brightRed;
      color10 = theme.terminal.brightGreen;
      color11 = theme.terminal.brightYellow;
      color12 = theme.terminal.brightBlue;
      color13 = theme.terminal.brightMagenta;
      color14 = theme.terminal.brightCyan;
      color15 = theme.terminal.brightWhite;
    };
  };
}
