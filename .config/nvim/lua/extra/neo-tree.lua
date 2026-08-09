vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
})

require("neo-tree").setup({
	popup_border_style = "",
	default_component_configs = {
		indent = {
			highlight = "NonText",
			expander_highlight = "NonText",
		},
	},
	buffers = {
		show_unloaded = true,
	},
	filesystem = {
		use_libuv_file_watcher = true,
		find_by_full_path_words = true,
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		filtered_items = {
			force_visible_in_empty_folder = true,
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_ignored = false,
		},
	},
	window = {
		mappings = {
			["C"] = "",
			["z"] = "",
			["w"] = "close_all_subnodes",
			["W"] = "close_all_nodes",
			["e"] = "expand_all_subnodes",
			["E"] = "expand_all_nodes",
		},
	},
})

vim.keymap.set("n", "<Space>", ":Neotree last dir=.<CR>", { silent = true, desc = "Explore neo tree" })
