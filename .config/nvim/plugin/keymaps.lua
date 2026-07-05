vim.keymap.set("n", "<Leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Browse tree" })

vim.keymap.set("n", "<Leader>C", "<cmd>Telescope commands<CR>", { desc = "Find commands" })
vim.keymap.set("n", "<Leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
vim.keymap.set("n", "<Leader>H", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
vim.keymap.set("n", "<Leader>K", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
vim.keymap.set("n", "<Leader>O", "<cmd>Telescope oldfiles<CR>", { desc = "Find old files" })

vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>r", "<cmd>Telescope resume<CR>", { desc = "Find resume" })
vim.keymap.set("n", "<Leader>s", "<cmd>Telescope live_grep<CR>", { desc = "Find string" })
vim.keymap.set({ "n", "v" }, "<Leader>w", "<cmd>Telescope grep_string<CR>", { desc = "Find word" })

vim.keymap.set({ "n", "v" }, "<Leader>ap", "<cmd>Sidekick cli prompt<CR>", { desc = "Artificial prompt" })
vim.keymap.set("n", "<Leader>ac", "<cmd>Sidekick cli close<CR>", { desc = "Artificial close" })
vim.keymap.set("n", "<Leader>at", "<cmd>Sidekick cli toggle focus=true<CR>", { desc = "Artificial toggle" })
