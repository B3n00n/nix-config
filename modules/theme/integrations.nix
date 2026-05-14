{ pkgs, spicePkgs }:
{
  dracula = {
    neovim = {
      colorscheme = "dracula";
      lualine     = "dracula";
      plugin      = pkgs.vimPlugins.dracula-nvim;
      background  = "dark";
    };
    spicetify = {
      theme       = spicePkgs.themes.text;
      colorScheme = "Dracula";
    };
    vscode = {
      colorTheme = "Dracula";
      extension  = pkgs.vscode-extensions.dracula-theme.theme-dracula;
    };
    gtk = {
      themeName    = "Dracula";
      themePackage = pkgs.dracula-theme;
      iconName     = "Dracula";
      iconPackage  = pkgs.dracula-icon-theme;
    };
  };

  "tokyo-night" = {
    neovim = {
      colorscheme = "tokyonight-night";
      lualine     = "tokyonight";
      plugin      = pkgs.vimPlugins.tokyonight-nvim;
      background  = "dark";
    };
    spicetify = {
      theme       = spicePkgs.themes.text;
      colorScheme = "TokyoNight";
    };
    vscode = {
      colorTheme = "Tokyo Night";
      extension  = pkgs.vscode-extensions.enkia.tokyo-night;
    };
    gtk = {
      themeName    = "Tokyonight-Dark";
      themePackage = pkgs.tokyonight-gtk-theme;
      iconName     = "Papirus-Dark";
      iconPackage  = pkgs.papirus-icon-theme;
    };
  };
}
