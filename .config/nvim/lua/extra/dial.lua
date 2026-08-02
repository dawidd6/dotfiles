vim.pack.add({
	{ src = "https://github.com/monaqa/dial.nvim" },
})

local augend = require("dial.augend")

require("dial.config").augends:register_group({
	default = {
		augend.constant.alias.en_weekday,
		augend.constant.alias.en_weekday_full,
		augend.constant.alias.bool,
		augend.constant.alias.Bool,
		augend.constant.new({
			elements = { "yes", "no" },
		}),
		augend.constant.new({
			elements = { "and", "or" },
		}),
		augend.case.new({
			types = { "camelCase", "snake_case", "SCREAMING_SNAKE_CASE", "PascalCase" },
		}),
	},
})

vim.keymap.set("n", "gs", "<Plug>(dial-increment)", { silent = true, desc = "Increment current word" })
vim.keymap.set("n", "gS", "<Plug>(dial-decrement)", { silent = true, desc = "Decrement current word" })
