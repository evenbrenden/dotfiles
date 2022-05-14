" colors
set termguicolors
highlight Pmenu ctermbg=darkmagenta guibg=darkmagenta

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" more config in lua
lua require('neovim-init')
