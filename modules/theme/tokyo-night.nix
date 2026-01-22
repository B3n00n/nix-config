# Tokyo Night Theme - Centralized Color Definitions
#
# This is a pure Nix function that returns the Tokyo Night color scheme
# and styling constants. It doesn't use the module system - just returns
# an attribute set.
#
# Usage in modules:
#   let
#     theme = import ./path/to/tokyo-night.nix;
#   in {
#     programs.kitty.settings.foreground = theme.colors.foreground;
#   }
#
# Based on: https://github.com/tokyo-night/tokyo-night-vscode-theme

{
  # Tokyo Night color scheme
  colors = {
    # Base colors
    background = "#1a1b26";      # Dark navy background
    foreground = "#c0caf5";      # Light lavender foreground

    # UI colors
    selection = "#33467c";       # Selection background
    comment = "#565f89";         # Comment text

    # Accent colors
    cyan = "#33ccff";            # Bright cyan
    green = "#00ff99";           # Bright green
    purple = "#bb9af7";          # Soft purple
    red = "#f7768e";             # Soft red
    orange = "#ff9e64";          # Soft orange
    yellow = "#e0af68";          # Soft yellow
    blue = "#7aa2f7";            # Medium blue
    magenta = "#bb9af7";         # Magenta (same as purple)

    # Additional shades
    lightCyan = "#7dcfff";       # Light cyan
    lightGreen = "#9ece6a";      # Light green
    darkBlue = "#3d59a1";        # Dark blue

    # Grays
    gray1 = "#1f2335";           # Darker gray
    gray2 = "#24283b";           # Dark gray
    gray3 = "#414868";           # Medium gray

    # Terminal colors (standard 16 color palette)
    terminal = {
      black = "#15161e";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      blue = "#7aa2f7";
      magenta = "#bb9af7";
      cyan = "#7dcfff";
      white = "#a9b1d6";

      brightBlack = "#414868";
      brightRed = "#f7768e";
      brightGreen = "#9ece6a";
      brightYellow = "#e0af68";
      brightBlue = "#7aa2f7";
      brightMagenta = "#bb9af7";
      brightCyan = "#7dcfff";
      brightWhite = "#c0caf5";
    };
  };

  # Font configuration
  fonts = {
    monospace = "JetBrains Mono";
    sansSerif = "Noto Sans";
    serif = "Noto Serif";
    terminal = "JetBrains Mono";
    size = {
      normal = 11;
      small = 9;
      large = 13;
    };
  };

  # Common styling patterns
  opacity = {
    opaque = "1.0";
    semiTransparent = "0.9";
    transparent = "0.8";
  };

  # Border and rounding
  border = {
    width = 2;
    radius = 10;
  };
}
