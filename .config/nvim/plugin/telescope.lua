vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local telescope_builtin = require("telescope.builtin")

require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

vim.keymap.set("n", "<Leader>fb", telescope_builtin.buffers, { desc = "Fuzzy find buffer" })
vim.keymap.set("n", "<Leader>fc", telescope_builtin.commands, { desc = "Fuzzy find commands" })
vim.keymap.set("n", "<Leader>fd", telescope_builtin.diagnostics, { desc = "Fuzzy find diagnostics" })
vim.keymap.set("n", "<Leader>ff", telescope_builtin.find_files, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<Leader>fh", telescope_builtin.help_tags, { desc = "Fuzzy find help tags" })
vim.keymap.set("n", "<Leader>fk", telescope_builtin.keymaps, { desc = "Fuzzy find keymaps" })
vim.keymap.set("n", "<Leader>fo", telescope_builtin.oldfiles, { desc = "Fuzzy find old files" })
vim.keymap.set("n", "<Leader>fr", telescope_builtin.resume, { desc = "Fuzzy find resume" })
vim.keymap.set("n", "<Leader>fs", telescope_builtin.live_grep, { desc = "Fuzzy find string" })
vim.keymap.set({ "n", "x" }, "<Leader>fw", telescope_builtin.grep_string, { desc = "Fuzzy find word" })
