vim.pack.add({
	{ src = "https://github.com/fasterius/simple-zoom.nvim" },
})

require("simple-zoom").setup({
	hide_tabline = true,
})

vim.keymap.set("n", "<C-w>z", ":SimpleZoomToggle<CR>", { silent = true, desc = "Zoom window" })
