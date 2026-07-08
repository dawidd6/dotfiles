vim.loader.enable()

-- Plugins
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	{ src = "https://github.com/OXY2DEV/markview.nvim" },
	-- { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

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
	{ src = "https://github.com/MagicDuck/grug-far.nvim" },

	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("vscode").setup()
vim.cmd.colorscheme("vscode")

require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "",
		disabled_filetypes = {
			statusline = { "NvimTree" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 3 } },
		lualine_x = { "encoding", "fileformat", "filetype", "lsp_status" },
		lualine_y = { "progress" },
		lualine_z = { "location", "searchcount", "selectioncount" },
	},
	tabline = {
		lualine_c = {
			{
				"buffers",
				show_filename_only = true,
				ignore_focus = { "NvimTree" },
				filetype_names = {
					NvimTree = "",
				},
			},
		},
		lualine_x = { "tabs" },
	},
})
require("which-key").setup({
	preset = "helix",
	delay = 0,
	filter = function(mapping)
		return mapping.desc and mapping.desc ~= ""
	end,
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
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})
require("grug-far").setup()

local nvim_tree_api = require("nvim-tree.api")
local nvim_tree_utils = require("nvim-tree.utils")
nvim_tree_api.events.subscribe(nvim_tree_api.events.Event.TreeOpen, function()
	if vim.t["filetree_width"] ~= nil then
		local winid = nvim_tree_api.tree.winid()
		vim.api.nvim_win_set_width(winid, vim.t["filetree_width"])
	end
end)
require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
	},
	view = {
		width = 50,
	},
	on_attach = function(bufnr)
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		nvim_tree_api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "o", function()
			nvim_tree_api.node.open.edit(nil, { focus = true })
		end, opts("Open No Focus"))

		vim.keymap.set("x", "o", function()
			local nodes = nvim_tree_utils.get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					nvim_tree_api.node.open.edit(node, { focus = true })
				end
			end
		end, opts("Open No Focus Selected Files"))

		vim.keymap.set("x", "<CR>", function()
			local nodes = nvim_tree_utils.get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					nvim_tree_api.node.open.edit(node)
				end
			end
		end, opts("Open Selected Files"))
	end,
})

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
	cmdline = {
		completion = {
			menu = { auto_show = false },
		},
		keymap = {
			["<C-e>"] = { "cancel", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
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
		["<C-e>"] = { "cancel", "fallback" },
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

-- Autocommands
vim.api.nvim_create_autocmd("WinResized", {
	pattern = "*",
	callback = function()
		local winid = nvim_tree_api.tree.winid()
		if winid ~= nil and vim.tbl_contains(vim.v.event["windows"], winid) then
			vim.t["filetree_width"] = vim.api.nvim_win_get_width(winid)
		end
	end,
	desc = "Remember file explorer window width",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpAccept",
	callback = function(ev)
		local item = ev.data.item
		if item.kind == 3 or item.kind == 2 then
			vim.defer_fn(function()
				vim.lsp.buf.signature_help()
			end, 500)
		end
	end,
	desc = "Show function signature popup after accepting completion",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"git",
		"help",
		"man",
		"qf",
		"scratch",
	},
	callback = function(args)
		if args.match ~= "help" or not vim.bo[args.buf].modifiable then
			vim.keymap.set("n", "q", ":quit<CR>", { buffer = args.buf })
		end
	end,
	desc = "Close special buffer types with <q>",
})

vim.api.nvim_create_autocmd({ "WinNew", "WinEnter", "BufWinEnter" }, {
	callback = function()
		if vim.w.todo_match then
			return
		end
		vim.w.todo_match = vim.fn.matchadd("Todo", [[\v<(TODO|FIXME|HACK|NOTE|WARNING|WARN|BUG)>]])
	end,
	desc = "Highlight common comments",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
	desc = "Always open help in right split",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Don't continue comments on newlines",
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function(args)
		vim.b[args.buf].completion = false
	end,
	desc = "Disable completion in command-line window",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
	desc = "Trim whitespace on buffer write",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
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
	desc = "Return to last edit position when opening files",
})

vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
	desc = "Auto-resize splits when window is resized",
})

vim.api.nvim_create_autocmd("TermClose", {
	callback = function(args)
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(args.buf) then
				pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
			end
		end)
	end,
	desc = "Terminal buffer is automatically deleted when process ends",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	nested = true,
	callback = function()
		if vim.bo.modified and vim.bo.modifiable and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("write")
		end
	end,
	desc = "Automatically save buffer when focus is lost",
})

-- Commands
vim.api.nvim_create_user_command("ResizeWindow", function(opts)
	vim.cmd("vertical resize " .. vim.opt.columns:get() * (opts.args / 100.0))
end, { nargs = "*", desc = "Resize window vertically by given percent" })

vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function(opts)
	local path = vim.fn.expand("%:p")
	if opts.range > 0 then
		if opts.line1 == opts.line2 then
			path = path .. ":" .. opts.line1
		else
			path = path .. ":" .. opts.line1 .. "-" .. opts.line2
		end
	end
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { range = true, desc = "Print and copy absolute file path with optional line range" })

vim.api.nvim_create_user_command("CopyRelativeFilePath", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy relative file path" })

vim.api.nvim_create_user_command("CopyGitAbsoluteDirPath", function()
	local path = vim.fs.root(0, { ".git" })
	if not path then
		vim.notify("Not in git repository")
		return
	end
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy git absolute dir path" })

vim.api.nvim_create_user_command("CopyGitRelativeFilePath", function()
	local git_root_path = vim.fs.root(0, { ".git" })
	local file_path = vim.fn.expand("%:p")
	if not git_root_path then
		vim.notify("Not in git repository")
		return
	end
	local path = file_path:gsub("^" .. vim.pesc(git_root_path) .. "/", "")
	vim.fn.setreg("+", path)
	vim.notify(path)
end, { desc = "Print and copy git relative file path" })

vim.api.nvim_create_user_command("Terminal", function()
	local path = vim.fs.root(0, { ".git" }) or vim.fn.expand("%:p:h")
	local shell = vim.fn.fnamemodify(vim.env.SHELL or vim.o.shell, ":t")
	vim.cmd("edit " .. vim.fn.fnameescape("term://" .. path .. "//" .. shell))
	vim.cmd("startinsert")
end, { desc = "Open terminal buffer in git root dir or file dir" })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update all vim.pack plugins" })

-- Options
vim.opt.iskeyword:append("-")
vim.opt.listchars = {
	leadmultispace = "|   ",
	tab = "→ ",
	nbsp = "␣",
	lead = "␣",
	trail = "•",
	extends = "⟩", -- »
	precedes = "⟨", -- «
}

vim.o.cmdheight = 0
vim.o.breakindent = true
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
vim.o.linebreak = true
vim.o.list = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.showbreak = "↪ "
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

-- Keymaps
vim.keymap.set("x", "p", '"_dP', { silent = true })

vim.keymap.set({ "n", "x" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "x" }, "X", '"_X', { silent = true })

vim.keymap.set("n", "c", '"_c', { silent = true })
vim.keymap.set("n", "C", '"_C', { silent = true })
vim.keymap.set("n", "cc", '"_cc', { silent = true })
vim.keymap.set("x", "c", '"_c', { silent = true })

vim.keymap.set("x", "<C-c>", '"+y', { silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("x", "<", "<gv", { silent = true })
vim.keymap.set("x", ">", ">gv", { silent = true })

vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { silent = true })
vim.keymap.set({ "n", "x" }, "<Leader>P", '"+P', { silent = true })

vim.keymap.set("n", "s", "ys", { remap = true, silent = true })
vim.keymap.set("x", "s", "S", { remap = true, silent = true })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { silent = true })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

vim.keymap.set("n", "<C-s>", "<cmd>write<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>write<CR>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

vim.keymap.set("n", "<Leader>C", "<cmd>Telescope commands<CR>", { desc = "Fuzzy find commands" })
vim.keymap.set("n", "<Leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Fuzzy find diagnostics" })
vim.keymap.set("n", "<Leader>H", "<cmd>Telescope help_tags<CR>", { desc = "Fuzzy find help tags" })
vim.keymap.set("n", "<Leader>K", "<cmd>Telescope keymaps<CR>", { desc = "Fuzzy find keymaps" })
vim.keymap.set("n", "<Leader>O", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find old files" })

vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", { desc = "Fuzzy find buffer" })
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files" })
vim.keymap.set("n", "<Leader>r", "<cmd>Telescope resume<CR>", { desc = "Resume fuzzy search" })
vim.keymap.set("n", "<Leader>s", "<cmd>Telescope live_grep<CR>", { desc = "Fuzzy find string" })
vim.keymap.set({ "n", "x" }, "<Leader>w", "<cmd>Telescope grep_string<CR>", { desc = "Fuzzy find word" })

vim.keymap.set("x", "<Leader>/", "<cmd>GrugFarWithin<CR>", { desc = "Search and replace" })
vim.keymap.set("n", "<Leader>/", "<cmd>GrugFar<CR>", { desc = "Search and replace" })
vim.keymap.set("n", "<Leader><Leader>", function()
	if vim.bo.filetype == "NvimTree" then
		vim.cmd("NvimTreeClose")
	else
		vim.cmd("NvimTreeFocus")
	end
end, { desc = "Toggle file tree focus" })
