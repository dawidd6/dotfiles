" Keymaps in this file are for both NeoVim and VSCodeVim

xnoremap p "_dP

nnoremap x "_x
xnoremap x "_x
nnoremap X "_X
xnoremap X "_X

nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
xnoremap c "_c

xnoremap <C-c> "+y

nnoremap <Esc> :nohlsearch<CR>

tnoremap <Esc><Esc> <C-\><C-n>

xnoremap < <gv
xnoremap > >gv

nnoremap <Leader>y "+y
xnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
xnoremap <Leader>Y "+Y
nnoremap <Leader>p "+p
xnoremap <Leader>p "+p
nnoremap <Leader>P "+P
xnoremap <Leader>P "+P

nmap s ys
xmap s S

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
