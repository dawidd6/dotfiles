" Keymaps in this file are for both NeoVim and VSCodeVim

nnoremap <silent> x "_x
vnoremap <silent> x "_x
nnoremap <silent> X "_X
vnoremap <silent> X "_X
vnoremap <silent> p "_dP

vnoremap <silent> <C-c> "+y

nnoremap <silent> <Esc> :nohlsearch<CR>

tnoremap <silent> <Esc><Esc> <C-\><C-n>

vnoremap <silent> < <gv
vnoremap <silent> > >gv

nnoremap <silent> <Leader>y "+y
vnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y "+Y
vnoremap <silent> <Leader>Y "+Y
nnoremap <silent> <Leader>p "+p
vnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>P "+P
vnoremap <silent> <Leader>P "+P

nmap <silent> s ys
vmap <silent> s S

nnoremap <silent> <C-Left> <C-w><C-h>
nnoremap <silent> <C-Right> <C-w><C-l>
nnoremap <silent> <C-Down> <C-w><C-j>
nnoremap <silent> <C-Up> <C-w><C-k>

nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
