" Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:plug_threads=2

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#branch#enabled=1
    let g:airline_powerline_fonts=0
    let g:airline_theme='quantum'
Plug 'airblade/vim-gitgutter'
    let g:gitgutter_enabled=1
Plug 'tyrannicaltoucan/vim-quantum'
    let g:quantum_black=1
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug '907th/vim-auto-save'
    let g:auto_save=0
    let g:auto_save_events=["InsertLeave", "TextChanged"]
Plug 'dag/vim-fish'
call plug#end()

" Indent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" Search
set ignorecase
set incsearch
set hlsearch
set showmatch
set gdefault

" Appearance
syntax on
colorscheme quantum
set background=dark
set number
set wildmenu
set termguicolors
set laststatus=2
set showcmd
set showmode
set guicursor=

" Timing
set updatetime=100
set ttimeoutlen=10

" Buffers
set hidden

" Backups
set noswapfile
set nobackup
set nowritebackup

" Behaviour
filetype plugin on
set nocompatible
set backspace=indent,eol,start
set clipboard=unnamedplus
set visualbell
set autoread
set encoding=utf8
set completeopt-=preview

" Key bindings
nnoremap . :bn<CR>
nnoremap , :bp<CR>
nnoremap <C-c> :e ++enc=cp1250<CR>
nnoremap <C-u> :e ++enc=utf-8<CR>

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
