set autoindent
set background=dark
set backspace=indent,eol,start
set expandtab
set guicursor=""
set hlsearch
set ignorecase
set nu
set path=.
set ruler
set shiftwidth=4
set showtabline=2
set smartcase
set smarttab
set softtabstop=0
set splitright
set tabstop=8
set wildmenu

syntax on

" colors
set termguicolors
highlight Pmenu ctermbg=darkmagenta guibg=darkmagenta

" markdown
set concealcursor=nc

" trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
noremap <silent>w1 :match ExtraWhitespace /\s\+\%#\@<!$/<CR>
noremap <silent>w0 :match<CR>
noremap <silent>wd :%s/\s\+$//e<CR>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" more config in lua
lua require('neovim-config')
