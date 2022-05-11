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

let mapleader=","
let maplocalleader="."

" buffer completion
set completeopt=menuone,menu,longest,preview
set complete=.
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" colors
set termguicolors
highlight Pmenu ctermbg=darkmagenta guibg=darkmagenta

" fzf
noremap <silent><leader>f :GFiles<CR>
noremap <silent><leader>g :GGrep<CR>

" graphviz
noremap <silent><localleader>g :GraphvizCompile<CR>

" markdown
set concealcursor=nc
set nofoldenable

" neoformat
noremap <silent><localleader>f :Neoformat<CR>

" trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
noremap <silent>w1 :match ExtraWhitespace /\s\+\%#\@<!$/<CR>
noremap <silent>w0 :match<CR>
noremap <silent>wd :%s/\s\+$//e<CR>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
