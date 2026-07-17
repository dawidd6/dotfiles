vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

local gitsigns = require("gitsigns")

gitsigns.setup()

vim.api.nvim_create_user_command("GitToggleLineBlame", function()
	gitsigns.toggle_current_line_blame({ full = true })
end, {
	desc = "Toggle git line blame",
})

vim.keymap.set("n", "gb", function()
	gitsigns.blame_line({ full = true })
end, { silent = true, desc = "Blame line" })
