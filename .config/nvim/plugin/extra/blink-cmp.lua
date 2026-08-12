vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },

	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

local vscode_snippets = require("luasnip.loaders.from_vscode")
vscode_snippets.lazy_load()
vscode_snippets.load_standalone({ path = vim.fn.stdpath("config") .. "/snippets.code-snippets" })

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	cmdline = {
		enabled = false,
	},
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "snippet_forward", "accept", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
	},
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	pattern = { ":", ">" },
	callback = function(args)
		vim.opt_local.completeopt = { "menu", "menuone", "longest" }
		vim.keymap.set("i", "<Tab>", "<C-X><C-V>", { buffer = args.buf })
		vim.keymap.set("i", "<CR>", function()
			return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
		end, { buffer = args.buf, expr = true })
	end,
	desc = "Use native command completion in command-line window",
})

vim.keymap.set("c", "<Down>", function()
	return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
end, { expr = true })
vim.keymap.set("c", "<Up>", function()
	return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
end, { expr = true })
vim.keymap.set("c", "<CR>", function()
	return vim.fn.wildmenumode() == 1 and "<C-y>" or "<CR>"
end, { expr = true })
