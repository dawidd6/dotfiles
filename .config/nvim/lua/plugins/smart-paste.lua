vim.pack.add({
	{ src = "https://github.com/nemanjamalesija/smart-paste.nvim" },
})

local smart_paste = require("smart-paste")

smart_paste.setup()

vim.keymap.set("n", "<Leader>p", function()
	smart_paste.paste({ register = "+", key = "p" })
end, { silent = true })
vim.keymap.set("n", "<Leader>P", function()
	smart_paste.paste({ register = "+", key = "P" })
end, { silent = true })
