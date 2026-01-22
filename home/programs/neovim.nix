{ pkgs, systemVars ? null, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Theme
      tokyonight-nvim

      # File explorer
      nvim-tree-lua
      nvim-web-devicons

      # Statusline
      lualine-nvim

      # Syntax highlighting & language support
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.python
        p.javascript
        p.typescript
        p.rust
        p.go
        p.java
        p.c
        p.cpp
        p.bash
        p.json
        p.yaml
        p.toml
        p.html
        p.css
        p.markdown
      ]))

      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim

      # LSP Support
      nvim-lspconfig

      # Auto-completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # Git integration
      gitsigns-nvim

      # Better commenting
      comment-nvim

      # Autopairs
      nvim-autopairs

      # Indent guides
      indent-blankline-nvim
    ];

    extraLuaConfig = ''
      -- ========================================
      -- THEME CONFIGURATION
      -- ========================================
      vim.cmd[[colorscheme tokyonight-night]]

      -- ========================================
      -- BASIC SETTINGS
      -- ========================================
      vim.opt.number = true                 -- Show line numbers
      vim.opt.relativenumber = true         -- Relative line numbers
      vim.opt.tabstop = 2                   -- 2 spaces for tabs
      vim.opt.shiftwidth = 2                -- 2 spaces for indent
      vim.opt.expandtab = true              -- Use spaces instead of tabs
      vim.opt.smartindent = true            -- Smart autoindenting
      vim.opt.ignorecase = true             -- Ignore case in search
      vim.opt.smartcase = true              -- Unless uppercase is used
      vim.opt.termguicolors = true          -- True color support
      vim.opt.cursorline = true             -- Highlight current line
      vim.opt.clipboard = 'unnamedplus'     -- System clipboard
      vim.opt.swapfile = false              -- Disable swap files
      vim.opt.undofile = true               -- Persistent undo
      vim.opt.scrolloff = 8                 -- Keep 8 lines above/below cursor
      vim.opt.sidescrolloff = 8             -- Keep 8 columns left/right cursor
      vim.opt.signcolumn = 'yes'            -- Always show sign column
      vim.opt.updatetime = 300              -- Faster updates
      vim.opt.timeoutlen = 500              -- Faster key sequence completion
      vim.opt.mouse = 'a'                   -- Enable mouse support
      vim.opt.splitright = true             -- Vertical splits to the right
      vim.opt.splitbelow = true             -- Horizontal splits below

      -- ========================================
      -- NVIM-TREE FILE EXPLORER
      -- ========================================
      require('nvim-tree').setup({
        sort_by = "case_sensitive",
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      -- ========================================
      -- LUALINE STATUSLINE
      -- ========================================
      require('lualine').setup({
        options = {
          theme = 'tokyonight',
          component_separators = '|',
          section_separators = { left = '█', right = '█' },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })

      -- ========================================
      -- TREESITTER SYNTAX HIGHLIGHTING
      -- ========================================
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      -- ========================================
      -- TELESCOPE FUZZY FINDER
      -- ========================================
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      require('telescope').load_extension('fzf')

      -- ========================================
      -- LSP CONFIGURATION
      -- ========================================
      local lspconfig = require('lspconfig')

      -- Nix LSP
      lspconfig.nixd.setup({})

      -- Show diagnostics on hover
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end
      })

      -- ========================================
      -- AUTO-COMPLETION
      -- ========================================
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- ========================================
      -- GITSIGNS
      -- ========================================
      require('gitsigns').setup({
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })

      -- ========================================
      -- COMMENT.NVIM
      -- ========================================
      require('Comment').setup()

      -- ========================================
      -- AUTOPAIRS
      -- ========================================
      require('nvim-autopairs').setup()

      -- ========================================
      -- INDENT GUIDES
      -- ========================================
      require('ibl').setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
      })

      -- ========================================
      -- KEYBINDINGS - VS Code Style for Comfort
      -- ========================================
      local keymap = vim.keymap.set
      local opts = { silent = true, noremap = true }

      -- Leader key
      vim.g.mapleader = ' '

      -- ========================================
      -- FILE EXPLORER & NAVIGATION
      -- ========================================

      -- Toggle file explorer (like VS Code sidebar)
      keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts)

      -- Navigate between file explorer and editor with Alt+Left/Right
      keymap('n', '<A-Left>', '<C-w>h', opts)   -- Go to left window (file explorer)
      keymap('n', '<A-Right>', '<C-w>l', opts)  -- Go to right window (editor)
      keymap('i', '<A-Left>', '<Esc><C-w>h', opts)
      keymap('i', '<A-Right>', '<Esc><C-w>l', opts)

      -- Focus file explorer directly
      keymap('n', '<leader>e', ':NvimTreeFocus<CR>', opts)

      -- ========================================
      -- FILE FINDING & SEARCH
      -- ========================================

      -- Ctrl+P - Quick open file (like VS Code)
      keymap('n', '<C-p>', ':Telescope find_files<CR>', opts)
      keymap('i', '<C-p>', '<Esc>:Telescope find_files<CR>', opts)

      -- Ctrl+H - Search across all files (Ctrl+Shift+F alternative - more reliable)
      keymap('n', '<C-h>', ':Telescope live_grep<CR>', opts)
      keymap('i', '<C-h>', '<Esc>:Telescope live_grep<CR>', opts)

      -- Also try Ctrl+Shift+F (may not work in all terminals)
      keymap('n', '<C-S-f>', ':Telescope live_grep<CR>', opts)
      keymap('i', '<C-S-f>', '<Esc>:Telescope live_grep<CR>', opts)

      -- Other Telescope shortcuts
      keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
      keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
      keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)

      -- ========================================
      -- IN-FILE SEARCH (Better Search Experience)
      -- ========================================

      -- Ctrl+F - Start search
      keymap('n', '<C-f>', '/', opts)
      keymap('i', '<C-f>', '<Esc>/', opts)

      -- Enter or F3 - Jump to next search result (after searching)
      keymap('n', '<CR>', function()
        -- Only jump to next match if there's an active search
        if vim.v.hlsearch == 1 then
          return 'n'
        else
          return '<CR>'
        end
      end, { expr = true, silent = true })
      keymap('n', '<F3>', 'n', opts)

      -- Shift+F3 - Jump to previous search result
      keymap('n', '<S-F3>', 'N', opts)

      -- Escape - Clear search highlight
      keymap('n', '<Esc>', ':noh<CR>', opts)

      -- ========================================
      -- BASIC EDITING (VS Code familiar)
      -- ========================================

      -- Ctrl+S - Save file
      keymap('n', '<C-s>', ':w<CR>', opts)
      keymap('i', '<C-s>', '<Esc>:w<CR>a', opts)

      -- Ctrl+Z - Undo
      keymap('n', '<C-z>', 'u', opts)
      keymap('i', '<C-z>', '<C-o>u', opts)

      -- Ctrl+Shift+Z - Redo
      keymap('n', '<C-S-z>', '<C-r>', opts)
      keymap('i', '<C-S-z>', '<C-o><C-r>', opts)

      -- Ctrl+/ - Toggle comment (like VS Code)
      keymap('n', '<C-_>', 'gcc', { remap = true })  -- Ctrl+/ sends Ctrl+_
      keymap('i', '<C-_>', '<Esc>gcca', { remap = true })
      keymap('v', '<C-_>', 'gc', { remap = true })

      -- Ctrl+X - Cut entire line (like nano/VS Code)
      keymap('n', '<C-x>', 'dd', opts)
      keymap('i', '<C-x>', '<Esc>dda', opts)

      -- Ctrl+V - Paste (after cut)
      keymap('n', '<C-v>', 'p', opts)
      keymap('i', '<C-v>', '<Esc>pa', opts)

      -- Ctrl+C - Copy entire line
      keymap('n', '<C-c>', 'yy', opts)
      keymap('i', '<C-c>', '<Esc>yya', opts)

      -- Ctrl+Up/Down - Jump multiple lines (like nano, 10 lines at a time)
      keymap('n', '<C-Up>', '10k', opts)
      keymap('n', '<C-Down>', '10j', opts)
      keymap('i', '<C-Up>', '<Esc>10ka', opts)
      keymap('i', '<C-Down>', '<Esc>10ja', opts)
      keymap('v', '<C-Up>', '10k', opts)
      keymap('v', '<C-Down>', '10j', opts)

      -- Ctrl+W - Close current file/buffer
      keymap('n', '<C-w>', ':bd<CR>', opts)

      -- Ctrl+Q - Quit
      keymap('n', '<C-q>', ':q<CR>', opts)

      -- ========================================
      -- TAB & BUFFER MANAGEMENT
      -- ========================================

      -- Ctrl+Tab - Next buffer (like switching tabs in VS Code)
      keymap('n', '<C-Tab>', ':bnext<CR>', opts)
      keymap('i', '<C-Tab>', '<Esc>:bnext<CR>', opts)

      -- Ctrl+Shift+Tab - Previous buffer
      keymap('n', '<C-S-Tab>', ':bprevious<CR>', opts)
      keymap('i', '<C-S-Tab>', '<Esc>:bprevious<CR>', opts)

      -- Alternative: Shift+L and Shift+H for next/previous
      keymap('n', '<S-l>', ':bnext<CR>', opts)
      keymap('n', '<S-h>', ':bprevious<CR>', opts)

      -- ========================================
      -- LINE & SELECTION MANIPULATION
      -- ========================================

      -- Alt+Up/Down - Move lines up/down (like VS Code)
      keymap('n', '<A-Up>', ':m .-2<CR>==', opts)
      keymap('n', '<A-Down>', ':m .+1<CR>==', opts)
      keymap('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', opts)
      keymap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', opts)
      keymap('v', '<A-Up>', ":m '<-2<CR>gv=gv", opts)
      keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", opts)

      -- Ctrl+D - Duplicate line (like VS Code)
      keymap('n', '<C-d>', ':t.<CR>', opts)
      keymap('i', '<C-d>', '<Esc>:t.<CR>gi', opts)

      -- Better indenting (keeps selection)
      keymap('v', '<', '<gv', opts)
      keymap('v', '>', '>gv', opts)
      keymap('v', '<Tab>', '>gv', opts)
      keymap('v', '<S-Tab>', '<gv', opts)

      -- ========================================
      -- LSP & CODE INTELLIGENCE
      -- ========================================

      -- F12 - Go to definition (like VS Code)
      keymap('n', '<F12>', vim.lsp.buf.definition, opts)
      keymap('n', 'gd', vim.lsp.buf.definition, opts)

      -- F2 - Rename symbol (like VS Code)
      keymap('n', '<F2>', vim.lsp.buf.rename, opts)

      -- Ctrl+. - Code actions (like VS Code quick fix)
      keymap('n', '<C-.>', vim.lsp.buf.code_action, opts)

      -- Shift+K - Show hover documentation
      keymap('n', '<S-k>', vim.lsp.buf.hover, opts)
      keymap('n', 'K', vim.lsp.buf.hover, opts)

      -- Go to implementation
      keymap('n', 'gi', vim.lsp.buf.implementation, opts)

      -- ========================================
      -- QUICK ACTIONS
      -- ========================================

      -- Space+w - Quick save
      keymap('n', '<leader>w', ':w<CR>', opts)

      -- Space+q - Quick quit
      keymap('n', '<leader>q', ':q<CR>', opts)

      -- Space+x - Save and quit
      keymap('n', '<leader>x', ':x<CR>', opts)
    '';

    extraPackages = with pkgs; [
      # Language servers
      nixd              # Nix LSP

      # Required tools
      ripgrep           # For Telescope live_grep
      fd                # For Telescope find_files
      tree-sitter       # For treesitter
      gcc               # For treesitter compilation
    ];
  };
}
