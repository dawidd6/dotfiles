vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
})

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")
local telescope_live_grep_args = require("telescope").extensions.live_grep_args

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			width = 0.99,
			height = 0.99,
		},
		mappings = {
			i = {
				["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
			},
			n = {
				["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
			},
		},
		file_ignore_patterns = {
			"^.git/",
			"/.git/",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
	extensions = {
		["live_grep_args"] = {
			auto_quoting = true,
		},
	},
})

telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<Leader>f", telescope_builtin.find_files, { silent = true, desc = "Search files" })
vim.keymap.set("n", "<Leader>j", telescope_builtin.jumplist, { silent = true, desc = "Search jumps" })
vim.keymap.set("n", "<Leader>o", telescope_builtin.oldfiles, { silent = true, desc = "Search old files" })
vim.keymap.set("n", "<Leader>s", telescope_live_grep_args.live_grep_args, { silent = true, desc = "Search string" })
vim.keymap.set({ "n", "x" }, "<Leader>w", telescope_builtin.grep_string, { silent = true, desc = "Search word" })
vim.keymap.set("n", "<Leader><Leader>", telescope_builtin.resume, { silent = true, desc = "Resume searching" })
