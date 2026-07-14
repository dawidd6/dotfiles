vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
})

local neo_tree = require("neo-tree")
local neo_tree_command = require("neo-tree.command")

neo_tree.setup({
	filesystem = {
		find_by_full_path_words = true,
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			never_show = {
				".git",
				".DS_Store",
			},
		},
	},
})

vim.keymap.set("n", "<leader>b", function()
	neo_tree_command.execute({ source = "buffers", focus = true })
end, { desc = "Explore buffer tree" })
vim.keymap.set("n", "<leader>e", function()
	neo_tree_command.execute({ focus = true })
end, { desc = "Explore file tree" })
