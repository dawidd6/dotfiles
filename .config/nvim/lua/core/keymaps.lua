vim.keymap.set("x", "p", '"_dP', { silent = true })

vim.keymap.set({ "n", "x" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "x" }, "X", '"_X', { silent = true })

vim.keymap.set("n", "c", '"_c', { silent = true })
vim.keymap.set("n", "C", '"_C', { silent = true })
vim.keymap.set("n", "cc", '"_cc', { silent = true })
vim.keymap.set("x", "c", '"_c', { silent = true })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

vim.keymap.set("x", "<", "<gv", { silent = true })
vim.keymap.set("x", ">", ">gv", { silent = true })

vim.keymap.set("n", "<Bs>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "<Del>", ":bnext | bdelete #<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

vim.keymap.set("n", "<C-s>", ":write<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:write<CR>", { silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

vim.keymap.set("n", "<C-Left>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { silent = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { silent = true })

vim.keymap.set("n", "<S-Up>", ":move .-2<CR>==", { silent = true })
vim.keymap.set("n", "<S-Down>", ":move .+1<CR>==", { silent = true })
vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<CR>", "o<Esc>", { silent = true })

vim.keymap.set("n", "<Leader>R", ":restart<CR>", { silent = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })
