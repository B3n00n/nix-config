-- @COLORSCHEME@ / @LUALINE@ / @BACKGROUND@ are substituted by default.nix.

-- ─── Theme ────────────────────────────────────────────────────────────
vim.o.background = "@BACKGROUND@"
vim.cmd([[colorscheme @COLORSCHEME@]])

-- ─── Basic settings ───────────────────────────────────────────────────
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
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.mouse = 'a'
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ─── nvim-tree ────────────────────────────────────────────────────────
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  view = { width = 35, side = "left" },
  renderer = {
    group_empty = true,
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
    },
  },
  filters = { dotfiles = false },
  git = { enable = true, ignore = false },
})

-- ─── lualine ──────────────────────────────────────────────────────────
require('lualine').setup({
  options = {
    theme = '@LUALINE@',
    component_separators = '|',
    section_separators = { left = '█', right = '█' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

-- ─── treesitter ───────────────────────────────────────────────────────
require('nvim-treesitter.configs').setup({
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
})

-- ─── telescope ────────────────────────────────────────────────────────
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

-- ─── LSP ──────────────────────────────────────────────────────────────
vim.lsp.enable('nixd')

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- ─── Completion (nvim-cmp) ────────────────────────────────────────────
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- ─── gitsigns ─────────────────────────────────────────────────────────
require('gitsigns').setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

require('Comment').setup()
require('nvim-autopairs').setup()

require('ibl').setup({
  indent = { char = "│" },
  scope = { enabled = true, show_start = true, show_end = false },
})

-- ─── Keybindings (VS Code-flavoured) ──────────────────────────────────
local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }
vim.g.mapleader = ' '

-- File explorer
keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts)
keymap('n', '<A-Left>',  '<C-w>h', opts)
keymap('n', '<A-Right>', '<C-w>l', opts)
keymap('i', '<A-Left>',  '<Esc><C-w>h', opts)
keymap('i', '<A-Right>', '<Esc><C-w>l', opts)
keymap('n', '<leader>e', ':NvimTreeFocus<CR>', opts)

-- File finding
keymap('n', '<C-p>',   ':Telescope find_files<CR>', opts)
keymap('i', '<C-p>',   '<Esc>:Telescope find_files<CR>', opts)
keymap('n', '<C-h>',   ':Telescope live_grep<CR>', opts)
keymap('i', '<C-h>',   '<Esc>:Telescope live_grep<CR>', opts)
keymap('n', '<C-S-f>', ':Telescope live_grep<CR>', opts)
keymap('i', '<C-S-f>', '<Esc>:Telescope live_grep<CR>', opts)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- In-file search
keymap('n', '<C-f>', '/', opts)
keymap('i', '<C-f>', '<Esc>/', opts)
keymap('n', '<CR>', function()
  if vim.v.hlsearch == 1 then return 'n' else return '<CR>' end
end, { expr = true, silent = true })
keymap('n', '<F3>',   'n', opts)
keymap('n', '<S-F3>', 'N', opts)
keymap('n', '<Esc>',  ':noh<CR>', opts)

-- Save / undo / redo / cut / copy / paste
keymap('n', '<C-s>',   ':w<CR>', opts)
keymap('i', '<C-s>',   '<Esc>:w<CR>a', opts)
keymap('n', '<C-z>',   'u', opts)
keymap('i', '<C-z>',   '<C-o>u', opts)
keymap('n', '<C-S-z>', '<C-r>', opts)
keymap('i', '<C-S-z>', '<C-o><C-r>', opts)

-- Ctrl+/ sends Ctrl+_ in most terminals
keymap('n', '<C-_>', 'gcc', { remap = true })
keymap('i', '<C-_>', '<Esc>gcca', { remap = true })
keymap('v', '<C-_>', 'gc',  { remap = true })

keymap('n', '<C-x>', 'dd', opts)
keymap('i', '<C-x>', '<Esc>dda', opts)
keymap('n', '<C-v>', 'p',  opts)
keymap('i', '<C-v>', '<Esc>pa', opts)
keymap('n', '<C-c>', 'yy', opts)
keymap('i', '<C-c>', '<Esc>yya', opts)

-- Big jumps
keymap('n', '<C-Up>',   '10k', opts)
keymap('n', '<C-Down>', '10j', opts)
keymap('i', '<C-Up>',   '<Esc>10ka', opts)
keymap('i', '<C-Down>', '<Esc>10ja', opts)
keymap('v', '<C-Up>',   '10k', opts)
keymap('v', '<C-Down>', '10j', opts)

keymap('n', '<C-w>', ':bd<CR>', opts)
keymap('n', '<C-q>', ':q<CR>',  opts)

-- Tabs / buffers
keymap('n', '<C-Tab>',   ':bnext<CR>', opts)
keymap('i', '<C-Tab>',   '<Esc>:bnext<CR>', opts)
keymap('n', '<C-S-Tab>', ':bprevious<CR>', opts)
keymap('i', '<C-S-Tab>', '<Esc>:bprevious<CR>', opts)
keymap('n', '<S-l>', ':bnext<CR>',     opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Line movement (VS Code-style)
keymap('n', '<A-Up>',   ':m .-2<CR>==', opts)
keymap('n', '<A-Down>', ':m .+1<CR>==', opts)
keymap('i', '<A-Up>',   '<Esc>:m .-2<CR>==gi', opts)
keymap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', opts)
keymap('v', '<A-Up>',   ":m '<-2<CR>gv=gv", opts)
keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", opts)

keymap('n', '<C-d>', ':t.<CR>', opts)
keymap('i', '<C-d>', '<Esc>:t.<CR>gi', opts)

keymap('v', '<',      '<gv', opts)
keymap('v', '>',      '>gv', opts)
keymap('v', '<Tab>',  '>gv', opts)
keymap('v', '<S-Tab>', '<gv', opts)

-- LSP
keymap('n', '<F12>',  vim.lsp.buf.definition, opts)
keymap('n', 'gd',     vim.lsp.buf.definition, opts)
keymap('n', '<F2>',   vim.lsp.buf.rename, opts)
keymap('n', '<C-.>',  vim.lsp.buf.code_action, opts)
keymap('n', '<S-k>',  vim.lsp.buf.hover, opts)
keymap('n', 'K',      vim.lsp.buf.hover, opts)
keymap('n', 'gi',     vim.lsp.buf.implementation, opts)

-- Leader shortcuts
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>x', ':x<CR>', opts)
