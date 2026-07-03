vim.loader.enable()

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/b0o/SchemaStore.nvim" },

	{ src = "https://github.com/Mofiqul/vscode.nvim" },

	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("vscode").setup()

require("lualine").setup({
	options = {
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype", "lsp_status" },
		lualine_y = { "progress" },
		lualine_z = { "location", "searchcount", "selectioncount" },
	},
})
require("which-key").setup({
	preset = "helix",
	delay = 0,
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("guess-indent").setup()

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

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
		["file_browser"] = {
			path = "%:p:h",
			hijack_netrw = true,
			select_buffer = true,
			grouped = true,
			hidden = true,
			mappings = {
				["n"] = {
					["<bs>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
				},
			},
		},
	},
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")

require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
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

vim.api.nvim_create_autocmd("User", {
	callback = function(ev)
		local item = ev.data.item
		if item.kind == 3 or item.kind == 2 then
			vim.defer_fn(function()
				vim.lsp.buf.signature_help()
			end, 500)
		end
	end,
	pattern = "BlinkCmpAccept",
	group = vim.api.nvim_create_augroup("signature-completion", { clear = true }),
	desc = "Show function signature popup after accepting completion",
})

vim.api.nvim_create_autocmd({ "WinNew", "WinEnter", "BufWinEnter" }, {
	callback = function()
		if vim.w.todo_match then
			return
		end
		vim.w.todo_match = vim.fn.matchadd("Todo", [[\v<(TODO|FIXME|HACK|NOTE|WARNING|WARN|BUG)>]])
		vim.w.todo_match = true
	end,
	group = vim.api.nvim_create_augroup("highlight-comments", { clear = true }),
	desc = "Highlight common comments",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
	pattern = { "*.txt" },
	group = vim.api.nvim_create_augroup("help-right", { clear = true }),
	desc = "Always open help in right split",
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
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
	group = vim.api.nvim_create_augroup("trim-whitespace", { clear = true }),
	desc = "Trim whitespace on buffer write",
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
vim.opt.listchars = { tab = "» ", nbsp = "␣", trail = "·", lead = "·", leadmultispace = "|   " }

vim.o.cmdheight = 0
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.list = true
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
vim.keymap.set("v", "s", "S", { desc = "Surround quicker and easier", silent = true, remap = true })

vim.keymap.set("n", "<leader><leader>", ":Telescope file_browser<CR>", { desc = "Browse files" })
vim.keymap.set("n", "<leader>sb", ":Telescope buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sc", ":Telescope commands<CR>", { desc = "Search commands" })
vim.keymap.set("n", "<leader>sd", ":Telescope diagnostics<CR>", { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<leader>sh", ":Telescope help_tags<CR>", { desc = "Search help" })
vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>so", ":Telescope oldfiles<CR>", { desc = "Search old files" })
vim.keymap.set("n", "<leader>sr", ":Telescope resume<CR>", { desc = "Search resume" })
vim.keymap.set("n", "<leader>ss", ":Telescope live_grep<CR>", { desc = "Search string" })
vim.keymap.set({ "n", "v" }, "<leader>sw", ":Telescope grep_string<CR>", { desc = "Search word" })
