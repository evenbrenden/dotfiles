set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set backspace=indent,eol,start
set hlsearch
set path=.
set smartcase
set ignorecase
set autoindent
set splitright
set ruler
set nu
set wildmenu
set showtabline=2
set background=dark
set guicursor=
syntax on
let mapleader=","
let maplocalleader="\\"

" write to current file with ,s
noremap <silent><Leader>s :w<CR>

" autocomplete with ctrl+p
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
" only do autocomplete for the current buffer
set complete=.

" show and remove trailing whitespace with ,w
noremap <silent><Leader>w :%s/\s\+$//<CR>
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" vim-markdown
let g:vim_markdown_conceal_code_blocks = 1
set conceallevel=2

" wmgraphviz.vim
let g:WMGraphviz_output = "svg"
