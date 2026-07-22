vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup()

vim.keymap.set("n", "gb", ":Gitsigns blame_line --full<CR>", { silent = true, desc = "Git blame line" })
vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous git hunk" })
vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { silent = true, desc = "Next git hunk" })
