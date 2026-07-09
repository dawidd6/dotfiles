vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
	cmdline = {
		completion = {
			menu = { auto_show = false },
		},
		keymap = {
			["<C-e>"] = { "cancel", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
		},
	},
	completion = {
		menu = {
			border = "rounded",
		},
		documentation = {
			window = {
				border = "rounded",
			},
			auto_show = true,
			auto_show_delay_ms = 200,
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
		["<Tab>"] = { "accept", "fallback" },
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
