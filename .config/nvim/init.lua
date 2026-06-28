vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	{ src = "https://github.com/Mofiqul/vscode.nvim" },

	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },

	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/tzachar/local-highlight.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/johnfrankmorgan/whitespace.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("vscode").setup()

require("neoscroll").setup()
require("smear_cursor").setup()

require("bufferline").setup()
require("lualine").setup()
require("local-highlight").setup({
	hlgroup = "LocalHighlight",
	cw_hlgroup = "LocalHighlight",
	animate = {
		enabled = false,
	},
})
require("todo-comments").setup()

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("guess-indent").setup()
require("whitespace-nvim").setup()

require("gitsigns").setup()

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		fish = { "fish_indent" },
	},
})

require("blink.cmp").setup({
	completion = {
		menu = {
			border = "rounded",
		},
		documentation = {
			window = {
				border = "rounded",
			},
		},
	},
	fuzzy = {
		implementation = "lua",
	},
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Left>"] = { "hide", "fallback" },
		["<Right>"] = { "hide", "fallback" },
		["<Esc>"] = { "hide", "fallback" },
		["<PageDown>"] = { "scroll_documentation_down", "fallback" },
		["<PageUp>"] = { "scroll_documentation_up", "fallback" },
	},
})

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
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
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.enable({
	"ansiblels",
	"bashls",
	"lua_ls",
	"yamlls",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("whitespace-nvim").trim()
	end,
	desc = "Trim whitespace on buffer write",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Don't continue comments on newlines",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Return to last edit position when opening files",
})

vim.cmd.colorscheme("vscode")

vim.o.cmdheight = 0
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.writebackup = false

vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Cut character without yanking", silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { desc = "Cut character without yanking", silent = true })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking", silent = true })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard", silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Disable search highlight", silent = true })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit to normal mode easier in terminal", silent = true })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect", silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { desc = "Copy to system clipboard", silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+Y', { desc = "Copy to system clipboard", silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard", silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', { desc = "Paste from system clipboard", silent = true })
vim.keymap.set("n", "s", "ys", { desc = "Surround quicker and easier", silent = true, remap = true })
