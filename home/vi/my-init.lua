local key_opts = {noremap = true, silent = true}

-- Leaders
vim.g.mapleader = ','
vim.g.maplocalleader = '.'

-- Settings
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.guicursor = ''
vim.opt.hidden = true
vim.opt.history = 10000
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
vim.opt.tabstop = 4
vim.opt.wildmenu = true

-- ALWAYS use the clipboard for ALL operations
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

-- Yank relative path of current file
vim.api.nvim_set_keymap('n', '<Leader>cp', ":call setreg('+', expand('%'))<CR>",
                        key_opts)

-- Auto-save
vim.api.nvim_set_keymap('n', '<Leader>a', ':AutoSaveToggle<CR>', key_opts)
vim.g.auto_save_events = {"TextChanged", "TextChangedI"}

-- Better Whitespace
-- https://www.markdownguide.org/basic-syntax#line-break-best-practices
vim.api.nvim_set_keymap('n', 'wd', ':StripWhitespace<CR>', key_opts)
vim.api.nvim_set_keymap('n', 'wt', ':ToggleWhitespace<CR>', key_opts)

-- Clear highlighted search matches
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':noh<CR>', key_opts)

-- Completion
vim.opt.completeopt = 'menu'
vim.api.nvim_set_keymap('i', '<C-o>', '<C-x><C-o>', {noremap = true}) -- omnifunc

-- Colors
vim.opt.background = 'light'
vim.opt.termguicolors = true
vim.cmd('colorscheme alabaster')

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

-- Idris2
vim.cmd('autocmd FileType idris2 setlocal tabstop=4 shiftwidth=4')

-- Hoogle
vim.api.nvim_set_keymap('n', '<LocalLeader>h',
                        ':silent !xdg-open https://hoogle.haskell.org<CR>',
                        key_opts)
vim.api.nvim_set_keymap('n', 'gh',
                        ':silent !xdg-open https://hoogle.haskell.org/?hoogle=<C-r><C-w><CR>',
                        key_opts)

-- Markdown
vim.opt.concealcursor = 'nc'
vim.opt.conceallevel = 2
ToggleConcealLevel = function()
    -- https://github.com/LuaLS/lua-language-server/issues/1527
    ---@diagnostic disable-next-line: undefined-field
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
vim.g.neoformat_enabled_haskell = {'fourmolu'}
vim.g.neoformat_haskell_fourmolu = {
    exe = 'fourmolu',
    args = {'--stdin-input-file', '%:p'},
    stdin = 1
}
vim.g.neoformat_enabled_lua = {'luaformat'}
vim.g.neoformat_enabled_nix = {'nixfmt'}
vim.g.neoformat_nix_nixfmt = {exe = 'nixfmt', args = {'--width=120'}, stdin = 1}
vim.g.neoformat_enabled_scala = {'scalafmt'}
vim.g.neoformat_enabled_sh = {'shfmt'}
vim.g.neoformat_sh_shfmt = {
    exe = 'shfmt',
    args = {'--case-indent', '--indent', '4', '--space-redirects'}
}
vim.g.neoformat_enabled_typescript = {'prettier'}

-- Netrw
vim.g.netrw_preview = 1
vim.g.netrw_winsize = 30
vim.api.nvim_set_keymap('n', '<Leader>e', ':Explore<CR>', key_opts)

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

-- https://superuser.com/questions/1642954/how-to-start-vim-with-a-clean-jumplist
vim.cmd('autocmd VimEnter * :clearjumps')

require 'my-lsp'
SetupLSP(key_opts)

require 'my-aia'
if os.getenv("NVIM_AIA") == "1" then SetupAIA() end
