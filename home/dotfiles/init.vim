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
noremap <silent><leader>f :Files<CR>
noremap <silent><leader>g :Rg<CR>

" graphviz
noremap <silent><localleader>g :GraphvizCompile<CR>

" hls
lua require'lspconfig'.hls.setup{}

" lsp
noremap ld :lua vim.lsp.buf.definition()<CR>
noremap ls :lua vim.lsp.buf.hover()<CR>
noremap lf :lua vim.lsp.buf.references()<CR>
noremap lr :lua vim.lsp.buf.rename()<CR>

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
noremap <silent><localleader>c :call ToggleConcealLevel()<CR>

" neoformat
noremap <silent><localleader>f :Neoformat<CR>

" trailing whitespace
hi ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
noremap <silent><leader>w :%s/\s\+$//<CR>

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
