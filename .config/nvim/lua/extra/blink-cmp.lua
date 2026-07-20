vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("blink.cmp").setup({
	snippets = {
		preset = "luasnip",
	},
	signature = {
		enabled = true,
	},
	cmdline = {
		enabled = false,
	},
	completion = {
		documentation = {
			auto_show = true,
		},
		list = {
			selection = {
				auto_insert = false,
			},
		},
	},
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<C-e>"] = { "cancel", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpAccept",
	callback = function(ev)
		local item = ev.data.item
		if item.kind == 3 or item.kind == 2 then
			vim.defer_fn(function()
				vim.lsp.buf.signature_help()
			end, 500)
		end
	end,
	desc = "Show function signature popup after accepting completion",
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
