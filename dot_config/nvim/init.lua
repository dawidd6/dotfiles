vim.opt.expandtab = true
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.visualbell = true
vim.opt.writebackup = false
vim.opt.clipboard = "unnamedplus"

vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })
vim.keymap.set("v", "p", '"_dP', { silent = true })
vim.keymap.set('n', ',', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '.', ':bnext<CR>', { noremap = true, silent = true })
