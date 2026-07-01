vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/kevinhwang91/promise-async" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/b0o/SchemaStore.nvim" },

	{ src = "https://github.com/Mofiqul/vscode.nvim" },

	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },

	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/tzachar/local-highlight.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/kevinhwang91/nvim-ufo" },
	{ src = "https://github.com/kosayoda/nvim-lightbulb" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/johnfrankmorgan/whitespace.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/barrettruth/canola.nvim" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

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
require("which-key").setup({
	preset = "helix",
})
require("ibl").setup()
require("ufo").setup()
require("nvim-lightbulb").setup({
	autocmd = { enabled = true }
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("guess-indent").setup()
require("whitespace-nvim").setup()

require("gitsigns").setup()

require("oil").setup()

-- TODO: not needed??? to delete???
--require("conform").setup({
--	format_on_save = {
--		timeout_ms = 500,
--		lsp_format = "fallback",
--	},
--	formatters_by_ft = {
--		lua = { "stylua" },
--		fish = { "fish_indent" },
--	},
--})

require("telescope").setup()
require("telescope").load_extension("ui-select")

require("blink.cmp").setup({
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
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
	},
})

vim.diagnostic.config({
	virtual_text = true,
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

vim.lsp.enable({
	"ansiblels",
	"bashls",
	"fish_lsp",
	"lua_ls",
	"yamlls",
})

vim.api.nvim_create_user_command("CopyRelativeFilePath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy relative file path" })

vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy absolute file path" })

vim.api.nvim_create_user_command("CopyGitRootDirPath", function()
	if vim.b.gitsigns_status_dict then
		local path = vim.b.gitsigns_status_dict.root
		vim.fn.setreg("+", path)
		vim.notify(path)
	else
		vim.notify("Not in git repository")
	end
end, { desc = "Print and copy git root path" })

vim.api.nvim_create_user_command("Terminal", function()
	local path = vim.fn.expand("%:p:h")
	if vim.b.gitsigns_status_dict then
		path = vim.b.gitsigns_status_dict.root
	end
	vim.cmd("edit term://" .. path .. "//$SHELL")
	vim.cmd("startinsert")
end, { desc = "Open terminal buffer in git root dir or file dir" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all vim.pack plugins" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.cmd.wincmd("o")
	end,
	pattern = "help",
	group = vim.api.nvim_create_augroup("only-help", { clear = true }),
	desc = "Open help in current window",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	group = vim.api.nvim_create_augroup("discontinue-comment", { clear = true }),
	desc = "Don't continue comments on newlines",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("whitespace-nvim").trim()
		vim.lsp.buf.format()
	end,
	group = vim.api.nvim_create_augroup("format-trim", { clear = true }),
	desc = "Trim whitespace and format on buffer write",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	desc = "Highlight text briefly after yanking",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	group = vim.api.nvim_create_augroup("return-last", { clear = true }),
	desc = "Return to last edit position when opening files",
})

vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
	group = vim.api.nvim_create_augroup("resize-split", { clear = true }),
	desc = "Auto-resize splits when window is resized",
})

vim.api.nvim_create_autocmd("TermClose", {
	callback = function(args)
		if vim.api.nvim_buf_is_valid(args.buf) then
			vim.api.nvim_buf_delete(args.buf, { force = true })
		end
	end,
	group = vim.api.nvim_create_augroup("terminal-autoclose", { clear = true }),
	desc = "Terminal buffer is automatically deleted when process ends",
})

vim.cmd.colorscheme("vscode")

vim.opt.iskeyword:append("-")

vim.o.cmdheight = 0
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
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
vim.o.winborder = "rounded"
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
