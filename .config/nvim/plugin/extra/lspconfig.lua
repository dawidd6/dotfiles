vim.pack.add({
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	severity_sort = true,
	float = { source = true },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
})

vim.filetype.add({
	pattern = {
		[".*/defaults/.*%.ya?ml"] = "yaml.ansible",
		[".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
		[".*/playbook.*%.ya?ml"] = "yaml.ansible",
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
		[".*/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/molecule/.*%.ya?ml"] = "yaml.ansible",
	},
})

local lsp = {
	ansiblels = {},
	dockerls = {},
	fish_lsp = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME .. "/lua",
					},
					checkThirdParty = false,
				},
			},
		},
	},
	tsgo = {
		cmd = { "tsc", "--lsp", "--stdio" },
	},
	yamlls = require("yaml-companion").setup({
		lspconfig = {
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemaDownload = { enable = false },
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		},
	}),
}

for name, config in pairs(lsp) do
	vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(lsp))
-- vim.lsp.codelens.enable(true)
vim.lsp.inlay_hint.enable(true)
-- vim.lsp.inline_completion.enable(true)
