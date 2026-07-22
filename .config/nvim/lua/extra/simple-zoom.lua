vim.pack.add({
	{ src = "https://github.com/fasterius/simple-zoom.nvim" },
})

require("simple-zoom").setup({
	hide_tabline = false,
})

vim.keymap.set("n", "<Leader>z", ":SimpleZoomToggle<CR>", { silent = true, desc = "Zoom current window" })
