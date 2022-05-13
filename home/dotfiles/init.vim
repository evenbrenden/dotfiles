" colors
set termguicolors
highlight Pmenu ctermbg=darkmagenta guibg=darkmagenta

" trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
noremap <silent>w1 :match ExtraWhitespace /\s\+\%#\@<!$/<CR>
noremap <silent>w0 :match<CR>
noremap <silent>wd :%s/\s\+$//e<CR>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" more config in lua
lua require('neovim-config')
