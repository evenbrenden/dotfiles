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
let maplocalleader="."

" autocomplete with ctrl+p
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
" only do autocomplete for the current buffer
set complete=.

" show and remove trailing whitespace
noremap <silent><Leader>w :%s/\s\+$//<CR>
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" vim-fzf
noremap <silent><Leader>f :Files<CR>

" markdown
set concealcursor=n
set conceallevel=3
function! ToggleConcealLevel()
    if (&conceallevel == 0)
        set conceallevel=3
    else
        set conceallevel=0
    endif
endfunction
noremap <silent><Leader>c :call ToggleConcealLevel()<CR>

" wmgraphviz.vim
let g:WMGraphviz_output="svg"

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
