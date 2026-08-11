vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/debugloop/telescope-undo.nvim" },
})

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		mappings = {
			i = {
				["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
				["<C-Up>"] = telescope_actions.cycle_history_prev,
				["<C-Down>"] = telescope_actions.cycle_history_next,
			},
			n = {
				["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
				["<C-Up>"] = telescope_actions.cycle_history_prev,
				["<C-Down>"] = telescope_actions.cycle_history_next,
			},
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
	},
	extensions = {
		["live_grep_args"] = {
			auto_quoting = true,
		},
		["ui-select"] = {
			previewer = require("telescope.previewers").new_buffer_previewer({
				define_preview = function(self, entry)
					local item = entry.value.text
					local text = type(item) == "table" and item.preview and item.preview.text or ""
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(text, "\n"))
				end,
			}),
		},
	},
})

require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("todo-comments")
require("telescope").load_extension("undo")

vim.keymap.set(
	"n",
	"<Leader>/",
	"<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ silent = true, desc = "Search current buffer" }
)
vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope resume<CR>", { silent = true, desc = "Resume last search" })

vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", { silent = true, desc = "Search open buffers" })
vim.keymap.set(
	"n",
	"<Leader>d",
	"<cmd>Telescope diagnostics<CR>",
	{ silent = true, desc = "Search current diagnostics" }
)
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>", { silent = true, desc = "Search workspace files" })
vim.keymap.set("n", "<Leader>g", "<cmd>Telescope git_files<CR>", { silent = true, desc = "Search git files" })
vim.keymap.set(
	"n",
	"<Leader>h",
	"<cmd>Telescope search_history<CR>",
	{ silent = true, desc = "Search searching history" }
)
vim.keymap.set("n", "<Leader>j", "<cmd>Telescope jumplist<CR>", { silent = true, desc = "Search jump list" })
vim.keymap.set("n", "<Leader>o", "<cmd>Telescope oldfiles<CR>", { silent = true, desc = "Search old files" })
vim.keymap.set("n", "<Leader>r", "<cmd>Telescope registers<CR>", { silent = true, desc = "Search clipboard registers" })
vim.keymap.set("n", "<Leader>s", "<cmd>Telescope live_grep_args<CR>", { silent = true, desc = "Search given string" })
vim.keymap.set(
	{ "n", "x" },
	"<Leader>w",
	"<cmd>Telescope grep_string<CR>",
	{ silent = true, desc = "Search selected word" }
)
vim.keymap.set("n", "<Leader>t", "<cmd>Telescope todo-comments<CR>", { silent = true, desc = "Search TODO comments" })
vim.keymap.set("n", "<Leader>u", "<cmd>Telescope undo<CR>", { silent = true, desc = "Search undo tree" })
