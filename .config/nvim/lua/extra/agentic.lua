vim.pack.add({
	{ src = "https://github.com/carlos-algms/agentic.nvim" },
})

require("agentic").setup({
	provider = "copilot-acp",
	acp_providers = {
		["copilot-acp"] = {
			initial_model = "gpt-5.6-sol",
			default_thought_level = "xhigh",
		},
	},
})

vim.keymap.set({ "n", "x" }, "ga", function()
	require("agentic").open()
end, { silent = true, desc = "Go ask AI" })
