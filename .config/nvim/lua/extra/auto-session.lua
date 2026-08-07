vim.pack.add({
	{ src = "https://github.com/rmagatti/auto-session" },
})

require("auto-session").setup({
	bypass_save_filetypes = { "", "neo-tree" },
})
