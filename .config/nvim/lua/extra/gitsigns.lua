vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup()

vim.keymap.set("n", "ghp", ":Gitsigns preview_hunk<CR>", { silent = true, desc = "Git preview hunk" })
vim.keymap.set("n", "ghr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "Git reset hunk" })
vim.keymap.set("n", "ghs", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Git stage hunk" })
vim.keymap.set("n", "gbl", ":Gitsigns blame_line --full<CR>", { silent = true, desc = "Git blame line" })
vim.keymap.set("n", "gbf", ":Gitsigns blame --full<CR>", { silent = true, desc = "Git blame file" })
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous git hunk" })
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Next git hunk" })
