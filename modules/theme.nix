# System-wide theme configuration
#
# Fonts and general theming settings. Cursor theme environment variables
# are set in Hyprland configuration where they're actually used.
{ pkgs, ... }:

{
  # System-wide fonts
  fonts.packages = with pkgs; [
    noto-fonts              # General-purpose fonts
    noto-fonts-cjk-sans     # CJK (Chinese, Japanese, Korean) support
    noto-fonts-color-emoji  # Color emoji support
    font-awesome            # Icon font
    jetbrains-mono          # Monospace font for coding
    fira-code               # Monospace font with ligatures
    terminus_font           # Bitmap font
  ];
}
