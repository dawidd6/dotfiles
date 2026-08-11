vim.pack.add({
	{ src = "https://github.com/rmagatti/auto-session" },
})

require("auto-session").setup({
	close_filetypes_on_save = { "neo-tree" },
})
