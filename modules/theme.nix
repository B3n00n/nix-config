# System-wide theme configuration
#
# Fonts and general theming settings. Cursor theme environment variables
# are set in Hyprland configuration where they're actually used.
{ pkgs, ... }:

{
  # System-wide fonts
  fonts.packages = with pkgs; [
    # General purpose fonts
    noto-fonts              # Sans-serif, serif fonts
    noto-fonts-cjk-sans     # CJK (Chinese, Japanese, Korean) support
    noto-fonts-color-emoji  # Color emoji support

    # Monospace fonts
    jetbrains-mono          # Base JetBrains Mono for coding
    fira-code               # Alternative monospace with ligatures
    terminus_font           # Bitmap terminal font

    # Nerd Fonts
    nerd-fonts.jetbrains-mono    # JetBrains Mono with icon glyphs
    nerd-fonts.symbols-only      # Standalone icon symbols
  ];
}
