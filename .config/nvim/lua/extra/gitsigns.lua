vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
	sign_priority = 30,
})

vim.keymap.set("n", "ghp", "<cmd>Gitsigns preview_hunk<CR>", { silent = true, desc = "Git preview hunk" })
vim.keymap.set("n", "ghr", "<cmd>Gitsigns reset_hunk<CR>", { silent = true, desc = "Git reset hunk" })
vim.keymap.set("n", "ghs", "<cmd>Gitsigns stage_hunk<CR>", { silent = true, desc = "Git stage hunk" })
vim.keymap.set("n", "gbl", "<cmd>Gitsigns blame_line --full<CR>", { silent = true, desc = "Git blame line" })
vim.keymap.set("n", "gbf", "<cmd>Gitsigns blame --full<CR>", { silent = true, desc = "Git blame file" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous git hunk" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { silent = true, desc = "Next git hunk" })
