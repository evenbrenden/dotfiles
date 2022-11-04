local key_opts = {noremap = true, silent = true}

-- Leaders
vim.g.mapleader = ','
vim.g.maplocalleader = '.'

-- Settings
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.expandtab = true
vim.opt.guicursor = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.spell = false
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

-- ALWAYS use the clipboard for ALL operations
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

-- Auto-save
vim.api.nvim_set_keymap('n', '<Leader>a', ':AutoSaveToggle<CR>', key_opts)
vim.g.auto_save_events = {"TextChanged", "TextChangedI"}

-- Clear highlighted search matches
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':noh<CR>', key_opts)

-- Completion
vim.opt.completeopt = 'menu'
vim.api.nvim_set_keymap('i', '<C-o>', '<C-x><C-o>', {noremap = true})

-- Colors
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd('colorscheme defaultish')

-- Better Whitespace
vim.api.nvim_set_keymap('n', 'wd', ':StripWhitespace<CR>', key_opts)
vim.api.nvim_set_keymap('n', 'wt', ':ToggleWhitespace<CR>', key_opts)
-- Defaults minus markdown
vim.g.better_whitespace_filetypes_blacklist = {
    'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'
}

-- fzf-hoogle.vim
vim.cmd([[
augroup hoogle
  autocmd!
  autocmd FileType haskell nnoremap <buffer> <LocalLeader>h :Hoogle<CR>
  autocmd FileType haskell nnoremap <buffer> H :Hoogle <C-r><C-w><CR>
augroup END
]])
vim.g.hoogle_fzf_cache_file = '~/.cache/fzf-hoogle.vim/cache.json'

-- GitGutter
vim.opt.updatetime = 100

-- GraphViz
vim.cmd([[
augroup graphviz
  autocmd!
  autocmd FileType dot nnoremap <buffer> <LocalLeader>c :GraphvizCompile<CR>
  " GraphvizInteractive does not play well with code that does not compile
  autocmd FileType dot nnoremap <buffer> <LocalLeader>i :Dispatch dot -Tx11 %:p<CR>
augroup END
]])
vim.g.WMGraphviz_output = 'svg'

-- Markdown
vim.opt.concealcursor = 'nc'
vim.opt.conceallevel = 2
ToggleConcealLevel = function()
    if vim.opt.conceallevel:get() == 0 then
        vim.opt.conceallevel = 2
    else
        vim.opt.conceallevel = 0
    end
end
vim.api.nvim_set_keymap('n', '<LocalLeader>c', ':lua ToggleConcealLevel()<CR>',
                        key_opts)
vim.opt.foldenable = false

-- Neoformat
vim.api.nvim_set_keymap('n', '<LocalLeader>f', ':Neoformat<CR>', key_opts)
vim.api.nvim_set_keymap('v', '<LocalLeader>f', ":'<,'>Neoformat<CR>", key_opts)
vim.g.neoformat_enabled_python = {'autopep8'}
vim.g.neoformat_enabled_haskell = {'ormolu'}
vim.g.neoformat_haskell_ormolu = {exe = 'fourmolu'}
vim.g.neoformat_enabled_lua = {'luaformat'}
vim.g.neoformat_enabled_nix = {'nixfmt'}
vim.g.neoformat_enabled_shell = {'shfmt'}
vim.g.neoformat_enabled_typescript = {'prettier'}

-- Search and replace
vim.api.nvim_set_keymap('n', '<Leader>r', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>',
                        key_opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', key_opts)
vim.api.nvim_set_keymap('n', '<Leader>g', ':Telescope live_grep<CR>', key_opts)
vim.api.nvim_set_keymap('n', '<Leader>s',
                        ':Telescope grep_string search=<C-r><C-w><CR>', key_opts)

-- YAML
vim.cmd([[
augroup yaml
  autocmd!
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
]])

-- Nope
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require 'my-lsp'
SetupLSP(key_opts)
