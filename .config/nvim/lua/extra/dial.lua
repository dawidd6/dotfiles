vim.pack.add({
	{ src = "https://github.com/monaqa/dial.nvim" },
})

local augend = require("dial.augend")

require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%d/%m/%Y"],
		augend.date.alias["%H:%M:%S"],
		augend.semver.alias.semver,
		augend.hexcolor.new({
			case = "lower",
		}),
		augend.constant.alias.bool,
		augend.constant.new({
			elements = { "yes", "no" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
		augend.case.new({
			types = { "camelCase", "snake_case" },
			cyclic = true,
		}),
	},
})

vim.keymap.set({ "n", "x" }, "<Leader>+", "<Plug>(dial-increment)", { silent = true, desc = "Increment selected text" })
vim.keymap.set({ "n", "x" }, "<Leader>-", "<Plug>(dial-decrement)", { silent = true, desc = "Decrement selected text" })
