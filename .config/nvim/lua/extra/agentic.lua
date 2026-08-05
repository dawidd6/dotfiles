vim.pack.add({
	{ src = "https://github.com/carlos-algms/agentic.nvim" },
})

local agentic = require("agentic")

agentic.setup({
	provider = "copilot-acp",
	acp_providers = {
		["copilot-acp"] = {
			initial_model = "gpt-5.6-sol",
			default_thought_level = "xhigh",
		},
	},
	headers = {
		chat = function(parts, session_state)
			local header = parts.title
			if session_state then
				local provider_name = session_state:get_provider_name()
				if provider_name then
					header = header .. " | " .. provider_name
				end
				local model_name = session_state:get_model_name()
				if model_name then
					header = header .. " | " .. model_name
				end
				local thought_level_name = session_state:get_thought_level_name()
				if thought_level_name then
					header = header .. " | " .. thought_level_name
				end
			end
			return header
		end,
	},
})

vim.keymap.set("n", "ga", function()
	agentic.open()
end, { silent = true, desc = "Go ask AI" })
vim.keymap.set("x", "ga", function()
	agentic.add_selection()
	agentic.add_current_line_diagnostics()
end, { silent = true, desc = "Go ask AI" })
