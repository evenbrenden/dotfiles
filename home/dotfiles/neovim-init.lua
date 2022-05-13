local key_opts = {noremap = true, silent = true}

-- Leaders
vim.g.mapleader = ","
vim.g.maplocalleader = "."

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

-- fzf
vim.api.nvim_set_keymap("n", "<leader>f", ":GFiles<CR>", key_opts)
vim.api.nvim_set_keymap("n", "<leader>g", ":GGrep<CR>", key_opts)

-- GraphViz
vim.api.nvim_set_keymap("n", "<localleader>g", ":GraphvizCompile<CR>", key_opts)

-- Markdown
vim.opt.concealcursor = 'nc'

-- Neoformat
vim.api.nvim_set_keymap("n", "<localleader>f", ":Neoformat<CR>", key_opts)

require 'neovim-completion'
require 'neovim-lsp'
