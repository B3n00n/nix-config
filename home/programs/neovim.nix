# Neovim Configuration - Tokyo Night Theme
# Minimal, clean configuration without complex Lua
{ pkgs, systemVars ? null, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      nvim-tree-lua
      nvim-web-devicons
    ];

    extraLuaConfig = ''
      -- Tokyo Night theme
      vim.cmd[[colorscheme tokyonight-night]]

      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.termguicolors = true
      vim.opt.cursorline = true
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.swapfile = false
      vim.opt.undofile = true

      -- IDE keybindings
      vim.keymap.set('n', '<C-z>', 'u', { silent = true })
      vim.keymap.set('i', '<C-z>', '<C-o>u', { silent = true })
      vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true })
      vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { silent = true })
      vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })
      vim.keymap.set('i', '<C-q>', '<Esc>:q<CR>', { silent = true })
      vim.keymap.set('n', '<C-f>', '/', { silent = true })
      vim.keymap.set('i', '<C-f>', '<Esc>/', { silent = true })
    '';

    extraPackages = with pkgs; [
      nixd
      ripgrep
      fd
    ];
  };
}
