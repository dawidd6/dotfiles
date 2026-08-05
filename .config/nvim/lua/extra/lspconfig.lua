vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	signs = false,
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

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = {
				kubernetes = "*.{yml,yaml}",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
				["http://json.schemastore.org/github-action"] = "action.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
			},
			format = {
				enable = false,
			},
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
		},
	},
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

vim.lsp.enable({
	"ansiblels",
	"dockerls",
	"fish_lsp",
	"lua_ls",
	"yamlls",
})
