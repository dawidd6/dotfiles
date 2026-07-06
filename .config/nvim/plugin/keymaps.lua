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
