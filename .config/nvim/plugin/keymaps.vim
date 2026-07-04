" Keymaps in this file are for both NeoVim and VSCodeVim

vnoremap p "_dP

nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
vnoremap c "_c

vnoremap <C-c> "+y

nnoremap <Esc> :nohlsearch<CR>

tnoremap <Esc><Esc> <C-\><C-n>

vnoremap < <gv
vnoremap > >gv

nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>Y "+Y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

nmap s ys
vmap s S

nnoremap <C-Left> <C-w><C-h>
nnoremap <C-Right> <C-w><C-l>
nnoremap <C-Down> <C-w><C-j>
nnoremap <C-Up> <C-w><C-k>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-s> :write<CR>
inoremap <C-s> <Esc>:write<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
