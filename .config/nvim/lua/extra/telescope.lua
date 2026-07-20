vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

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
		buffers = {
			mappings = {
				i = {
					["<Del>"] = telescope_actions.delete_buffer,
				},
				n = {
					["<Del>"] = telescope_actions.delete_buffer,
				},
			},
		},
		find_files = {
			hidden = true,
			no_ignore = true,
		},
	},
	extensions = {
		["live_grep_args"] = {
			auto_quoting = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("ui-select")
telescope.load_extension("todo-comments")

vim.keymap.set("n", "<Leader>sb", ":Telescope buffers<CR>", { silent = true, desc = "Search buffers" })
vim.keymap.set("n", "<Leader>sc", ":Telescope commands<CR>", { silent = true, desc = "Search commands" })
vim.keymap.set("n", "<Leader>sf", ":Telescope find_files<CR>", { silent = true, desc = "Search files" })
vim.keymap.set("n", "<Leader>sj", ":Telescope jumplist<CR>", { silent = true, desc = "Search jumps" })
vim.keymap.set("n", "<Leader>so", ":Telescope oldfiles<CR>", { silent = true, desc = "Search oldies" })
vim.keymap.set("n", "<Leader>sr", ":Telescope resume<CR>", { silent = true, desc = "Search resume" })
vim.keymap.set("n", "<Leader>ss", ":Telescope live_grep_args<CR>", { silent = true, desc = "Search string" })
vim.keymap.set({ "n", "x" }, "<Leader>sw", ":Telescope grep_string<CR>", { silent = true, desc = "Search word" })
vim.keymap.set("n", "<Leader>st", ":Telescope todo-comments<CR>", { silent = true, desc = "Search TODOs" })
