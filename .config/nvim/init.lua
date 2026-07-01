vim.loader.enable()

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/kevinhwang91/promise-async" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/mosheavni/yaml-companion.nvim" },
	{ src = "https://github.com/b0o/SchemaStore.nvim" },

	{ src = "https://github.com/Mofiqul/vscode.nvim" },

	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },

	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/kevinhwang91/nvim-ufo" },
	{ src = "https://github.com/kosayoda/nvim-lightbulb" },
	{ src = "https://github.com/j-hui/fidget.nvim" },

	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/johnfrankmorgan/whitespace.nvim" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/barrettruth/canola.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },

	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },

	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("vscode").setup()

require("neoscroll").setup()
require("smear_cursor").setup()

require("bufferline").setup()
require("lualine").setup()
require("todo-comments").setup()
require("which-key").setup({
	preset = "helix",
})
require("ibl").setup()
require("ufo").setup()
require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
})
require("fidget").setup()

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("guess-indent").setup()
require("whitespace-nvim").setup()

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git [c]hange" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [c]hange" })

		-- Actions
		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [s]tage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [r]eset hunk" })
		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
		map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "git preview hunk [i]nline" })
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "git [b]lame line" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("@")
		end, { desc = "git [D]iff against last commit" })
		map("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end, { desc = "git hunk [Q]uickfix list (all files in repo)" })
		map("n", "<leader>hq", gitsigns.setqflist, { desc = "git hunk [q]uickfix list (all changes in this file)" })
		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
		map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle git intra-line [w]ord diff" })

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
})

require("oil").setup()
require("neo-tree").setup({
	filesystem = {
		window = {
			mappings = {
				[" "] = "close_window",
			},
		},
	},
})

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
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})
require("telescope").load_extension("ui-select")

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

-- TODO:
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf
		local builtin = require("telescope.builtin")

		-- Find references for the word under your cursor.
		vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		vim.keymap.set(
			"n",
			"gW",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = buf, desc = "Open Workspace Symbols" }
		)

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "[G]oto [T]ype Definition" })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- NOTE: Remember that Lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.cmd.colorscheme("vscode")

vim.opt.iskeyword:append("-")
vim.opt.listchars = { tab = "» ", nbsp = "␣" }

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

vim.keymap.set("n", "<leader>sh", ":Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", ":Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set({ "n", "v" }, "<leader>sw", ":Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", ":Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", ":Telescope resume<CR>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", ":Telescope oldfiles<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sc", ":Telescope commands<CR>", { desc = "[S]earch [C]ommands" })
vim.keymap.set("n", "<leader><leader>", ":Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown())
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "[F]ormat buffer" })

vim.keymap.set("n", " ", "<Cmd>Neotree reveal<CR>", { desc = "NeoTree reveal", silent = true })
