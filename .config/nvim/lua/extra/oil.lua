vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
	delete_to_trash = true,
	cleanup_buffers_on_delete = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	view_options = {
		show_hidden = true,
		show_hidden_when_empty = true,
	},
	float = {
		max_width = 0.99,
		max_height = 0.99,
	},
	keymaps = {
		["q"] = { "actions.close", mode = "n" },
		["<Bs>"] = { "actions.parent", mode = "n" },
		["<C-d>"] = { "actions.preview_scroll_down", mode = "n" },
		["<C-u>"] = { "actions.preview_scroll_up", mode = "n" },
	},
})

vim.keymap.set("n", "<Leader>e", ":Oil --float --preview<CR>", { desc = "Explore file tree" })
