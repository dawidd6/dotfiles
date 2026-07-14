vim.keymap.set("x", "p", '"_dP', { silent = true })
vim.keymap.set({ "n", "x" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "x" }, "X", '"_X', { silent = true })

vim.keymap.set("n", "c", '"_c', { silent = true })
vim.keymap.set("n", "C", '"_C', { silent = true })
vim.keymap.set("n", "cc", '"_cc', { silent = true })
vim.keymap.set("x", "c", '"_c', { silent = true })

vim.keymap.set("x", "<C-c>", '"+y', { silent = true })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("x", "<", "<gv", { silent = true })
vim.keymap.set("x", ">", ">gv", { silent = true })

vim.keymap.set("n", "s", "ys", { remap = true, silent = true })
vim.keymap.set("x", "s", "S", { remap = true, silent = true })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { silent = true })
vim.keymap.set("n", "<S-Up>", "<C-w>+", { silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w>-", { silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w>>", { silent = true })
vim.keymap.set("n", "<S-Left>", "<C-w><", { silent = true })

vim.keymap.set("n", "<Del>", ":bwipeout<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

vim.keymap.set("n", "<C-s>", ":write<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:write<CR>", { silent = true })
vim.keymap.set("n", "<C-a>", "ggVG", { silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>P", '"+P', { silent = true })
