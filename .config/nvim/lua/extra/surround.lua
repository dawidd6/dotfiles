vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround" },
})

require("nvim-surround").setup()

vim.keymap.set("n", "s", "ys", { remap = true, silent = true })
vim.keymap.set("x", "s", "S", { remap = true, silent = true })
