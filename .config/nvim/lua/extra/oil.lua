vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local oil = require("oil")
local oil_actions = require("oil.actions")

oil.setup({
	delete_to_trash = true,
	cleanup_buffers_on_delete = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	view_options = {
		show_hidden = true,
		show_hidden_when_empty = true,
	},
	float = {
		max_width = 0.99,
		max_height = 0.99,
	},
	keymaps = {
		["<Bs>"] = { oil_actions.parent, mode = "n" },
	},
})

vim.keymap.set("n", "<Leader>e", function()
	oil.open_float()
end, { desc = "Explore file tree" })
