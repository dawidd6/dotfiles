vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	signature = {
		enabled = true,
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
		documentation = {
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
		["<Tab>"] = {
			function(cmp)
				if vim.fn.getcmdwintype() ~= "" then
					return cmp.show_and_insert_or_accept_single() or cmp.select_next()
				end
			end,
			"accept",
			"fallback",
		},
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
	},
})

require("blink.cmp.config")({
	completion = {
		menu = { auto_show = false },
		ghost_text = { enabled = false },
		list = {
			selection = {
				auto_insert = true,
			},
		},
	},
}, { mode = "cmdwin" })

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
