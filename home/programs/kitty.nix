# Kitty Terminal Emulator Configuration
{ pkgs, systemVars ? null, ... }:

let
  # Import Tokyo Night theme
  theme = import ../../modules/theme/tokyo-night.nix;
in
{
  programs.kitty = {
    enable = true;

    # Font configuration
    font = {
      name = theme.fonts.terminal;
      size = theme.fonts.size.normal;
    };

    settings = {
      # Disable confirmation on close
      confirm_os_window_close = 0;

      # Performance settings
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;

      # Cursor configuration
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # Scrollback buffer
      scrollback_lines = 10000;

      # Mouse behavior
      mouse_hide_wait = "3.0";

      # Window layout
      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;
      window_padding_width = 4;

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";

      # Tokyo Night color scheme
      foreground = theme.colors.foreground;
      background = theme.colors.background;

      # Selection colors
      selection_foreground = theme.colors.background;
      selection_background = theme.colors.cyan;

      # Cursor colors
      cursor = theme.colors.foreground;
      cursor_text_color = theme.colors.background;

      # URL underline color
      url_color = theme.colors.blue;

      # Terminal colors (16-color palette)
      color0 = theme.colors.terminal.black;
      color1 = theme.colors.terminal.red;
      color2 = theme.colors.terminal.green;
      color3 = theme.colors.terminal.yellow;
      color4 = theme.colors.terminal.blue;
      color5 = theme.colors.terminal.magenta;
      color6 = theme.colors.terminal.cyan;
      color7 = theme.colors.terminal.white;

      # Bright colors
      color8 = theme.colors.terminal.brightBlack;
      color9 = theme.colors.terminal.brightRed;
      color10 = theme.colors.terminal.brightGreen;
      color11 = theme.colors.terminal.brightYellow;
      color12 = theme.colors.terminal.brightBlue;
      color13 = theme.colors.terminal.brightMagenta;
      color14 = theme.colors.terminal.brightCyan;
      color15 = theme.colors.terminal.brightWhite;
    };
  };
}
