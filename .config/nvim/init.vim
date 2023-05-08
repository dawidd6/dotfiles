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
set background=dark
set number
set wildmenu
set termguicolors
set laststatus=2
set showcmd
set showmode
set guicursor=
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
highlight Cursor gui=reverse

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

" Don't copy on paste
vnoremap p "_dP
