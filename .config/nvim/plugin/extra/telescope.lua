vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

telescope.setup({
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
		},
	},
})

vim.keymap.set("n", "<Leader><Leader>", telescope_builtin.resume, { silent = true, desc = "Fuzzy find resume" })
vim.keymap.set("n", "<Leader>b", telescope_builtin.buffers, { silent = true, desc = "Fuzzy find buffer" })
vim.keymap.set("n", "<Leader>f", telescope_builtin.find_files, { silent = true, desc = "Fuzzy find files" })
vim.keymap.set("n", "<Leader>s", telescope_builtin.live_grep, { silent = true, desc = "Fuzzy find string" })
vim.keymap.set({ "n", "x" }, "<Leader>w", telescope_builtin.grep_string, { silent = true, desc = "Fuzzy find word" })
