vim.pack.add({
	{ src = "https://github.com/noisesfromspace/touchup.nvim" },
})

require("touchup").setup({
	enter = { enabled = false },
})
