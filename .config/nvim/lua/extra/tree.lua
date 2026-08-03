vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		width = {
			min = 30,
			max = -1,
		},
	},
})

vim.keymap.set("n", "<Space>", ":NvimTreeFocus<CR>", { silent = true, desc = "Explore file tree" })
