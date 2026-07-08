vim.keymap.set("x", "p", '"_dP', { silent = true })

vim.keymap.set({ "n", "x" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "x" }, "X", '"_X', { silent = true })

vim.keymap.set("n", "c", '"_c', { silent = true })
vim.keymap.set("n", "C", '"_C', { silent = true })
vim.keymap.set("n", "cc", '"_cc', { silent = true })
vim.keymap.set("x", "c", '"_c', { silent = true })

vim.keymap.set("x", "<C-c>", '"+y', { silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("x", "<", "<gv", { silent = true })
vim.keymap.set("x", ">", ">gv", { silent = true })

vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>P", '"+P', { silent = true })

vim.keymap.set("n", "s", "ys", { remap = true, silent = true })
vim.keymap.set("x", "s", "S", { remap = true, silent = true })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { silent = true })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

vim.keymap.set("n", "<C-s>", "<cmd>write<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>write<CR>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

vim.keymap.set("n", "<Leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "File explorer" })

vim.keymap.set("n", "<Leader>C", "<cmd>Telescope commands<CR>", { desc = "Command finder" })
vim.keymap.set("n", "<Leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostic finder" })
vim.keymap.set("n", "<Leader>H", "<cmd>Telescope help_tags<CR>", { desc = "Help finder" })
vim.keymap.set("n", "<Leader>K", "<cmd>Telescope keymaps<CR>", { desc = "Keymap finder" })
vim.keymap.set("n", "<Leader>O", "<cmd>Telescope oldfiles<CR>", { desc = "Old finder" })

vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffer finder" })
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>", { desc = "File finder" })
vim.keymap.set("n", "<Leader>r", "<cmd>Telescope resume<CR>", { desc = "Resume finder" })
vim.keymap.set("n", "<Leader>s", "<cmd>Telescope live_grep<CR>", { desc = "String finder" })
vim.keymap.set({ "n", "x" }, "<Leader>w", "<cmd>Telescope grep_string<CR>", { desc = "Word finder" })

vim.keymap.set({ "n", "x" }, "<Leader>aa", "<cmd>CodeCompanionCLI Ask<CR>", { desc = "Prompt Copilot" })
vim.keymap.set({ "n", "x" }, "<Leader>ae", "<cmd>CodeCompanionCLI Ask agent=claude<CR>", { desc = "Prompt Claude" })
vim.keymap.set({ "n", "x" }, "<Leader>ax", "<cmd>CodeCompanionCLI Ask agent=codex<CR>", { desc = "Prompt Codex" })
