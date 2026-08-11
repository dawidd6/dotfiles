vim.pack.add({
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

-- vim.lsp.codelens.enable(true)
vim.lsp.inlay_hint.enable(true)
vim.lsp.inline_completion.enable(true)

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	severity_sort = true,
	float = { source = true },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
})

vim.lsp.config("lua_ls", {
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
})

vim.lsp.config("tsgo", { cmd = { "tsc", "--lsp", "--stdio" } })

vim.lsp.config(
	"yamlls",
	require("yaml-companion").setup({
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
	})
)

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

vim.lsp.enable({
	"ansiblels",
	"dockerls",
	"fish_lsp",
	"lua_ls",
	"tsgo",
	"yamlls",
})
