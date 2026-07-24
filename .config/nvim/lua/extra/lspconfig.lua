vim.pack.add({
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	signs = { priority = 20 },
	severity_sort = true,
	float = { source = true },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
})

vim.lsp.config("dockerls", {
	root_markers = vim.list_extend({ "Containerfile" }, vim.lsp.config.dockerls.root_markers),
})

vim.lsp.config("lua_ls", {
	root_markers = vim.list_extend({ "init.lua" }, vim.lsp.config.lua_ls.root_markers),
	settings = {
		Lua = {
			format = { enable = false },
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
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config(
	"yamlls",
	require("yaml-companion").setup({
		lspconfig = {
			settings = {
				yaml = {
					format = {
						enable = false,
					},
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

vim.lsp.enable({
	"ansiblels",
	"dockerls",
	"fish_lsp",
	"lua_ls",
	"yamlls",
})
