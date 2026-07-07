" Keymaps in this file are for both NeoVim and VSCodeVim

xnoremap <silent> p "_dP

nnoremap <silent> x "_x
xnoremap <silent> x "_x
nnoremap <silent> X "_X
xnoremap <silent> X "_X

nnoremap <silent> c "_c
nnoremap <silent> C "_C
nnoremap <silent> cc "_cc
xnoremap <silent> c "_c

xnoremap <silent> <C-c> "+y

nnoremap <silent> <Esc> :nohlsearch<CR>

tnoremap <silent> <Esc><Esc> <C-\><C-n>

xnoremap <silent> < <gv
xnoremap <silent> > >gv

nnoremap <silent> <Leader>y "+y
xnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y "+Y
xnoremap <silent> <Leader>Y "+Y
nnoremap <silent> <Leader>p "+p
xnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>P "+P
xnoremap <silent> <Leader>P "+P

nmap <silent> s ys
xmap <silent> s S

nnoremap <silent> <C-Left> <C-w><C-h>
nnoremap <silent> <C-Right> <C-w><C-l>
nnoremap <silent> <C-Down> <C-w><C-j>
nnoremap <silent> <C-Up> <C-w><C-k>

nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

nnoremap <silent> <C-s> :write<CR>
inoremap <silent> <C-s> <Esc>:write<CR>

nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> <C-u> <C-u>zz
