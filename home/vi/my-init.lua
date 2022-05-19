local key_opts = {noremap = true, silent = true}

-- Leaders
vim.g.mapleader = ','
vim.g.maplocalleader = '.'

-- Settings
vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backspace = 'indent,eol,start'
vim.opt.expandtab = true
vim.opt.guicursor = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.nu = true
vim.opt.path = ''
vim.opt.ruler = true
vim.opt.shiftwidth = 4
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 0
vim.opt.splitright = true
vim.opt.tabstop = 8
vim.opt.wildmenu = true

-- Colors
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, 'Pmenu', {bg = '#8B008B'})

-- Better Whitespace
vim.api.nvim_set_keymap('n', 'wd', ':StripWhitespace<CR>', key_opts)
vim.api.nvim_set_keymap('n', 'wt', ':ToggleWhitespace<CR>', key_opts)

-- GitGutter
vim.opt.updatetime = 100

-- GraphViz
vim.api.nvim_set_keymap('n', '<localleader>g', ':GraphvizCompile<CR>', key_opts)
vim.g.WMGraphviz_output = 'svg'

-- HOCON
vim.cmd('autocmd BufNewFile,BufRead *.hocon set ft=hocon')

-- Markdown
vim.opt.concealcursor = 'nc'

-- Neoformat
vim.api.nvim_set_keymap('n', '<localleader>f', ':Neoformat<CR>', key_opts)
vim.g.neoformat_enabled_python = {'autopep8'}
vim.g.neoformat_enabled_haskell = {'brittany'}
vim.g.neoformat_haskell_brittany = {exe = 'brittany', args = {'--indent=2'}}
vim.g.neoformat_enabled_lua = {'luaformat'}
vim.g.neoformat_enabled_nix = {'nixfmt'}
vim.g.neoformat_enabled_shell = {'shfmt'}

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', key_opts)
vim.api.nvim_set_keymap('n', '<leader>g', ':Telescope live_grep<CR>', key_opts)

-- YAML
vim.cmd('autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab')

-- Nope
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require 'my-cmp'
setupCompletion()

require 'my-lsp'
setupLSP(key_opts)
