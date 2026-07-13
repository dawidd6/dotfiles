vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
})

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")
local telescope_file_browser_actions = require("telescope._extensions.file_browser.actions")
local telescope_file_browser = require("telescope").extensions.file_browser
local telescope_live_grep_args = require("telescope").extensions.live_grep_args

telescope.setup({
	defaults = {
		initial_mode = "normal",
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
		buffers = {
			mappings = {
				i = {
					["<C-d>"] = telescope_actions.delete_buffer,
				},
				n = {
					["<C-d>"] = telescope_actions.delete_buffer,
				},
			},
		},
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
	extensions = {
		["file_browser"] = {
			hide_parent_dir = true,
			hijack_netrw = true,
			select_buffer = true,
			no_ignore = true,
			grouped = true,
			hidden = true,
			mappings = {
				i = {
					["<C-c>"] = telescope_file_browser_actions.copy,
					["<C-a>"] = telescope_file_browser_actions.create,
					["<C-x>"] = telescope_file_browser_actions.move,
					["<C-d>"] = telescope_file_browser_actions.remove,
					["<C-n>"] = telescope_file_browser_actions.rename,
				},
				n = {
					["<C-c>"] = telescope_file_browser_actions.copy,
					["<C-a>"] = telescope_file_browser_actions.create,
					["<C-x>"] = telescope_file_browser_actions.move,
					["<C-d>"] = telescope_file_browser_actions.remove,
					["<C-n>"] = telescope_file_browser_actions.rename,
					["<BS>"] = telescope_file_browser_actions.goto_parent_dir,
				},
			},
		},
		["live_grep_args"] = {
			auto_quoting = true,
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<Space>", telescope_file_browser.file_browser, { silent = true, desc = "Open explorer" })

vim.keymap.set("n", "<Leader><Leader>", telescope_builtin.resume, { silent = true, desc = "Resume picking" })
vim.keymap.set("n", "<Leader>b", telescope_builtin.buffers, { silent = true, desc = "Pick buffer" })
vim.keymap.set("n", "<Leader>f", telescope_builtin.find_files, { silent = true, desc = "Pick file" })
vim.keymap.set("n", "<Leader>j", telescope_builtin.jumplist, { silent = true, desc = "Pick jump" })
vim.keymap.set("n", "<Leader>o", telescope_builtin.oldfiles, { silent = true, desc = "Pick oldies" })
vim.keymap.set("n", "<Leader>s", telescope_live_grep_args.live_grep_args, { silent = true, desc = "Pick string" })
vim.keymap.set({ "n", "x" }, "<Leader>w", telescope_builtin.grep_string, { silent = true, desc = "Pick word" })
