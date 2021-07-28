" Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Python
let g:python3_host_prog = '/usr/bin/python3'

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
    let g:lightline = { 'colorscheme': 'material' }
Plug 'mengelbrecht/lightline-bufferline'
    let g:lightline.tabline          = {'left': [['buffers']], 'right': [[]]}
    let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type   = {'buffers': 'tabsel'}
Plug 'airblade/vim-gitgutter'
    let g:gitgutter_enabled=1
Plug 'kaicataldo/material.vim'
    let g:material_theme_style='darker'
    let g:material_terminal_italics=1
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'dag/vim-fish'
Plug 'xu-cheng/brew.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
Plug 'honza/vim-snippets'
Plug 'rhysd/conflict-marker.vim'
    let g:conflict_marker_begin = '^<<<<<<< .*$'
    let g:conflict_marker_end   = '^>>>>>>> .*$'
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
colorscheme material
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
set showtabline=2

" Backups
set noswapfile
set nobackup
set nowritebackup

" Behaviour
filetype plugin on
set nocompatible
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set visualbell
set autoread
set encoding=utf8
set completeopt-=preview
set nofixendofline

" Change cursor based on mode
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
highlight Cursor gui=reverse

" Key bindings
nnoremap . :bn<CR>
nnoremap , :bp<CR>
nnoremap <C-c> :e ++enc=cp1250<CR>
nnoremap <C-u> :e ++enc=utf-8<CR>
" Trim whitespace
nnoremap <F12> :%s/\s\+$//e<CR>

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Ruby
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab

" Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" Delete, don't cut
nnoremap x "_x
nnoremap X "_X
"nnoremap d "_d
"nnoremap D "_D
"vnoremap d "_d
