set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set splitright
set nu
set hlsearch
set ruler
set showtabline=2
set path+=./**
set backspace=indent,eol,start
set smartcase
set ignorecase
set wildmenu
set background=dark
syntax on

" autocomplete: ctrl+p
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
" only autocomplete current buffer
set complete=.

" show and remove trailing whitespace
let mapleader=","
map <silent><Leader>w :%s/\s\+$//<CR>
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" pathogen
silent! call pathogen#infect()
