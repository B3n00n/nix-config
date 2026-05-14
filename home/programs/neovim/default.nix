{ config, pkgs, ... }:

let
  theme = config.theme;
  initLua = builtins.replaceStrings
    [ "@COLORSCHEME@" "@LUALINE@" "@BACKGROUND@" ]
    [
      theme.apps.neovim.colorscheme
      theme.apps.neovim.lualine
      theme.apps.neovim.background
    ]
    (builtins.readFile ./init.lua);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      theme.apps.neovim.plugin

      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim

      (nvim-treesitter.withPlugins (p: [
        p.nix p.lua p.python p.javascript p.typescript p.rust p.go
        p.java p.c p.cpp p.bash p.json p.yaml p.toml p.html p.css p.markdown
      ]))

      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim

      nvim-lspconfig

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      gitsigns-nvim
      comment-nvim
      nvim-autopairs
      indent-blankline-nvim
    ];

    extraLuaConfig = initLua;

    extraPackages = with pkgs; [
      ripgrep      # telescope live_grep
      fd           # telescope find_files
      tree-sitter
      gcc          # treesitter parser compilation
    ];
  };
}
