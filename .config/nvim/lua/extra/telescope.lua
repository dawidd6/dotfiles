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

vim.keymap.set(
	"n",
	"<Leader>/",
	":Telescope current_buffer_fuzzy_find<CR>",
	{ silent = true, desc = "Search current buffer" }
)
vim.keymap.set("n", "<Leader><Leader>", ":Telescope resume<CR>", { silent = true, desc = "Resume last search" })

vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>", { silent = true, desc = "Search open buffers" })
vim.keymap.set("n", "<Leader>c", ":Telescope commands<CR>", { silent = true, desc = "Search available commands" })
vim.keymap.set("n", "<Leader>d", ":Telescope diagnostics<CR>", { silent = true, desc = "Search current diagnostics" })
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { silent = true, desc = "Search workspace files" })
vim.keymap.set("n", "<Leader>h", ":Telescope search_history<CR>", { silent = true, desc = "Search searching history" })
vim.keymap.set("n", "<Leader>j", ":Telescope jumplist<CR>", { silent = true, desc = "Search jump list" })
vim.keymap.set("n", "<Leader>o", ":Telescope oldfiles<CR>", { silent = true, desc = "Search old files" })
vim.keymap.set("n", "<Leader>r", ":Telescope registers<CR>", { silent = true, desc = "Search clipboard registers" })
vim.keymap.set("n", "<Leader>s", ":Telescope live_grep_args<CR>", { silent = true, desc = "Search given string" })
vim.keymap.set(
	{ "n", "x" },
	"<Leader>w",
	":Telescope grep_string<CR>",
	{ silent = true, desc = "Search selected word" }
)
vim.keymap.set("n", "<Leader>t", ":Telescope todo-comments<CR>", { silent = true, desc = "Search TODO comments" })
