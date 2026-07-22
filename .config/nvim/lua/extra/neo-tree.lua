vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
})

require("neo-tree").setup({
	auto_clean_after_session_restore = true,
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

vim.keymap.set("n", "<leader>b", ":Neotree buffers focus dir=.<CR>", { silent = true, desc = "Explore buffer tree" })
vim.keymap.set("n", "<leader>e", ":Neotree focus dir=.<CR>", { silent = true, desc = "Explore file tree" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				vim.cmd("Neotree focus dir=.")
			end)
		end
	end,
	desc = "Open neo-tree on startup",
})
