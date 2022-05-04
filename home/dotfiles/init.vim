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

" autocomplete
set completeopt=menuone,menu,longest,preview
set complete=.
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" fzf
noremap <silent><leader>f :GFiles<CR>
noremap <silent><leader>g :GGrep<CR>
" https://github.com/junegunn/fzf.vim#example-git-grep-wrapper
command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \     'git grep --line-number -- '.shellescape(<q-args>), 0,
    \     fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" graphviz
noremap <silent><localleader>g :GraphvizCompile<CR>

" lsp
lua require('neovim-config')

" markdown
set concealcursor=n
set conceallevel=3

" neoformat
noremap <silent><localleader>f :Neoformat<CR>

" trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
noremap <silent>w1 :match ExtraWhitespace /\s\+\%#\@<!$/<CR>
noremap <silent>w0 :match<CR>
noremap <silent>wd :%s/\s\+$//e<CR>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
