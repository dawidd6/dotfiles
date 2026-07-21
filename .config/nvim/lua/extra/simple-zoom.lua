vim.pack.add({
	{ src = "https://github.com/fasterius/simple-zoom.nvim" },
})

require("simple-zoom").setup()

vim.keymap.set("n", "<Leader>z", ":SimpleZoomToggle<CR>", { desc = "Zoom current window" })
