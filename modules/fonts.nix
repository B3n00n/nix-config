{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    jetbrains-mono
    fira-code
    terminus_font

    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
}
