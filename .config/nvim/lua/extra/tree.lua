vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = true,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		width = {
			min = 30,
			max = -1,
		},
		signcolumn = "no",
	},
	filters = {
		enable = false,
	},
	renderer = {
		root_folder_label = ":~",
		indent_markers = {
			enable = true,
			inline_arrows = true,
		},
	},
	actions = {
		change_dir = {
			global = true,
			restrict_above_cwd = true,
		},
	},
})

vim.keymap.set("n", "<Space>", ":NvimTreeFocus<CR>", { silent = true, desc = "Explore file tree" })
