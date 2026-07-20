vim.pack.add({
	{ src = "https://github.com/lukas-reineke/lsp-format.nvim" },
})

local lsp_format = require("lsp-format")

lsp_format.setup({
	sync = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.name == "null-ls" then
			lsp_format.on_attach(client, args.buf)
		end
	end,
})
