vim.loader.enable()

require("vim._core.ui2").enable()

do -- Autocommands
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

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "help", "man", "qf", "git", "scratch", "checkhealth", "lspinfo", "gitsigns-blame" },
		callback = function(args)
			vim.keymap.set("n", "q", ":q<CR>", { buffer = args.buf, silent = true })
		end,
		desc = "Close special buffers with <q>",
	})

	vim.api.nvim_create_autocmd("CmdwinEnter", {
		callback = function(args)
			vim.keymap.set("n", "q", ":q<CR>", { buffer = args.buf, silent = true })
			vim.keymap.set("n", "<CR>", "<CR>", { buffer = args.buf, silent = true })
		end,
		desc = "Close command-line window with <q>",
	})

	-- TODO: neovim 0.13+
	-- vim.api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
			-- vim.hl.hl_op({ higroup = "Visual", timeout = 300 })
		end,
		desc = "Highlight text briefly after yanking",
	})

	vim.api.nvim_create_autocmd("TermOpen", {
		callback = function()
			vim.cmd.startinsert()
		end,
		desc = "Enter insert mode in terminal automatically",
	})

	vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			vim.cmd("tabdo wincmd =")
		end,
		desc = "Auto-resize splits when window is resized",
	})
end

do -- Commands
	vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function(opts)
		local path = vim.fn.expand("%:p")
		if opts.range > 0 then
			path = path .. ":" .. opts.line1 .. ":" .. opts.line2
		end
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy absolute file path", range = true })

	vim.api.nvim_create_user_command("CopyRelativeFilePath", function()
		local path = vim.fn.expand("%:.")
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy relative file path" })

	vim.api.nvim_create_user_command("CopyProjectRelativeFilePath", function()
		local path = vim.fs.relpath(vim.fs.root(0, { ".git" }) or vim.fn.getcwd(), vim.fn.expand("%:p")) or ""
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy project relative file path" })

	vim.api.nvim_create_user_command("CopyProjectAbsoluteDirectoryPath", function()
		local path = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy project absolute directory path" })

	vim.api.nvim_create_user_command("CopyProjectRelativeDirectoryPath", function()
		local path = vim.fs.relpath(vim.fs.root(0, { ".git" }) or vim.fn.getcwd(), vim.fn.getcwd()) or ""
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Copy project relative directory path" })

	vim.api.nvim_create_user_command("PackUpdate", function()
		vim.pack.update()
	end, { desc = "Update plugins" })

	vim.api.nvim_create_user_command("PackClean", function()
		local inactive = vim.iter(vim.pack.get())
			:filter(function(x)
				return not x.active
			end)
			:map(function(x)
				return x.spec.name
			end)
			:totable()
		if #inactive > 0 then
			vim.pack.del(inactive)
		end
	end, { desc = "Clean plugins" })
end

do -- Keymaps
	vim.keymap.set("x", "p", '"_dP', { silent = true })

	vim.keymap.set({ "n", "x" }, "x", '"_x', { silent = true })
	vim.keymap.set({ "n", "x" }, "X", '"_X', { silent = true })

	vim.keymap.set("n", "c", '"_c', { silent = true })
	vim.keymap.set("n", "C", '"_C', { silent = true })
	vim.keymap.set("n", "cc", '"_cc', { silent = true })
	vim.keymap.set("x", "c", '"_c', { silent = true })

	vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

	vim.keymap.set("x", "<", "<gv", { silent = true })
	vim.keymap.set("x", ">", ">gv", { silent = true })

	vim.keymap.set("n", "<Bs>", ":b#<CR>", { silent = true })
	vim.keymap.set("n", "<Del>", ":bnext | bdelete #<CR>", { silent = true })
	vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
	vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

	vim.keymap.set("n", "<C-s>", ":write<CR>", { silent = true })
	vim.keymap.set("i", "<C-s>", "<Esc>:write<CR>", { silent = true })
	vim.keymap.set("n", "<C-a>", "ggVG", { silent = true })
	vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { silent = true })
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

	vim.keymap.set("n", "<C-Left>", "<C-w>h", { silent = true })
	vim.keymap.set("n", "<C-Right>", "<C-w>l", { silent = true })
	vim.keymap.set("n", "<C-Up>", "<C-w>k", { silent = true })
	vim.keymap.set("n", "<C-Down>", "<C-w>j", { silent = true })

	vim.keymap.set("n", "<S-Up>", ":move .-2<CR>==", { silent = true })
	vim.keymap.set("n", "<S-Down>", ":move .+1<CR>==", { silent = true })
	vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv=gv", { silent = true })
	vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv=gv", { silent = true })

	vim.keymap.set("n", "<CR>", "o<Esc>", { silent = true })

	vim.keymap.set("n", "<Leader>R", ":restart<CR>", { silent = true })

	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true })
end

do -- Options
	vim.o.breakindent = true
	vim.o.clipboard = "unnamedplus"
	vim.o.cmdheight = vim.g.vscode and 1 or 0
	vim.o.confirm = true
	vim.o.cursorline = true
	vim.o.expandtab = true
	vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
	vim.o.foldcolumn = "1"
	vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldmethod = "expr"
	vim.o.foldtext = ""
	vim.o.ignorecase = true
	vim.o.inccommand = "split"
	vim.o.linebreak = true
	vim.o.mouse = "a"
	vim.o.number = true
	vim.o.scrolloff = 10
	vim.o.sessionoptions = "buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize"
	vim.o.shiftwidth = 4
	vim.o.showbreak = "↪ "
	vim.o.showmode = false
	vim.o.signcolumn = "yes"
	vim.o.smartcase = true
	vim.o.smartindent = true
	vim.o.smoothscroll = true
	vim.o.splitbelow = true
	vim.o.splitright = true
	vim.o.swapfile = false
	vim.o.statuscolumn = "%l%s%C "
	vim.o.tabstop = 4
	vim.o.undofile = true
	vim.o.updatetime = 250
	vim.o.winborder = "rounded"
	vim.o.pumborder = "rounded"
	vim.o.wildmode = "longest,full"
	vim.o.writebackup = false
end

do -- nvim-web-devicons
	vim.pack.add({
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	})
end

do -- auto-save
	vim.pack.add({
		-- TODO: switch back when https://github.com/okuuva/auto-save.nvim/pull/83 is merged
		-- { src = "https://github.com/okuuva/auto-save.nvim" },
		{ src = "https://github.com/dawidd6/auto-save.nvim", version = "nested" },
	})

	require("auto-save").setup({
		trigger_events = {
			immediate_save = { "BufLeave", "FocusLost", "VimSuspend" },
			cancel_deferred_save = {},
			defer_save = {},
		},
		condition = function(buf)
			return vim.api.nvim_get_mode().mode == "n" and vim.bo[buf].buftype == ""
		end,
		nested = true,
	})
end

do -- auto-session
	vim.pack.add({
		{ src = "https://github.com/rmagatti/auto-session" },
	})

	require("auto-session").setup({
		close_filetypes_on_save = { "neo-tree" },
	})
end

do -- blink.cmp
	vim.pack.add({
		{ src = "https://github.com/saghen/blink.lib" },
		{ src = "https://github.com/saghen/blink.cmp" },
		{ src = "https://github.com/rafamadriz/friendly-snippets" },
	})

	require("blink.cmp").setup({
		cmdline = {
			enabled = false,
		},
		fuzzy = {
			implementation = "lua",
		},
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "accept", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},
	})

	vim.api.nvim_create_autocmd("CmdwinEnter", {
		pattern = { ":", ">" },
		callback = function(args)
			vim.opt_local.completeopt = { "menu", "menuone", "longest" }
			vim.keymap.set("i", "<Tab>", "<C-X><C-V>", { buffer = args.buf })
			vim.keymap.set("i", "<CR>", function()
				return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
			end, { buffer = args.buf, expr = true })
		end,
		desc = "Use native command completion in command-line window",
	})

	vim.keymap.set("c", "<Down>", function()
		return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
	end, { expr = true })
	vim.keymap.set("c", "<Up>", function()
		return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
	end, { expr = true })
	vim.keymap.set("c", "<CR>", function()
		return vim.fn.wildmenumode() == 1 and "<C-y>" or "<CR>"
	end, { expr = true })
end

do -- blink.indent
	vim.pack.add({
		{ src = "https://github.com/saghen/blink.indent" },
	})

	require("blink.indent").setup({
		static = {
			highlights = { "IblIndent" },
		},
		scope = {
			highlights = { "IblScope" },
		},
	})
end

do -- browsher.nvim
	vim.pack.add({
		{ src = "https://github.com/claydugo/browsher.nvim" },
	})

	require("browsher").setup({
		default_pin = "branch",
		providers = {
			["gitlab"] = require("browsher").providers["gitlab.com"],
			["salsa"] = require("browsher").providers["gitlab.com"],
		},
	})
end

do -- bufferline.nvim
	vim.pack.add({
		{ src = "https://github.com/akinsho/bufferline.nvim" },
	})

	require("bufferline").setup({
		options = {
			style_preset = require("bufferline").style_preset.minimal,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
		},
	})
end

do -- conflict.nvim
	vim.pack.add({
		{ src = "https://github.com/niekdomi/conflict.nvim" },
	})

	require("conflict").setup({
		show_actions = false,
	})
end

do -- conform.nvim
	vim.pack.add({
		{ src = "https://github.com/stevearc/conform.nvim" },
	})

	require("conform").setup({
		format_on_save = function()
			if not vim.g.disable_autoformat then
				return { timeout_ms = 1000, lsp_format = "never" }
			end
		end,
		formatters_by_ft = {
			dockerfile = { "dockerfmt" },
			fish = { "fish_indent" },
			lua = { "stylua" },
			ruby = { "rubocop" },
			sh = { "shfmt" },
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
	})

	vim.api.nvim_create_user_command("FormatDisable", function()
		vim.g.disable_autoformat = true
	end, {
		desc = "Disable autoformat-on-save",
	})

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.g.disable_autoformat = false
	end, {
		desc = "Enable autoformat-on-save",
	})
end

do -- dial.nvim
	vim.pack.add({
		{ src = "https://github.com/monaqa/dial.nvim" },
	})

	local augend = require("dial.augend")

	require("dial.config").augends:register_group({
		default = {
			augend.constant.alias.en_weekday,
			augend.constant.alias.en_weekday_full,
			augend.constant.alias.bool,
			augend.constant.alias.Bool,
			augend.constant.new({
				elements = { "yes", "no" },
			}),
			augend.constant.new({
				elements = { "and", "or" },
			}),
			augend.case.new({
				types = { "camelCase", "snake_case", "SCREAMING_SNAKE_CASE", "PascalCase" },
			}),
		},
	})

	vim.keymap.set("n", "+", "<Plug>(dial-increment)", { silent = true, desc = "Increment current word" })
	vim.keymap.set("n", "-", "<Plug>(dial-decrement)", { silent = true, desc = "Decrement current word" })
end

do -- gitsigns.nvim
	vim.pack.add({
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	})

	require("gitsigns").setup()

	vim.keymap.set("n", "ghp", "<cmd>Gitsigns preview_hunk<CR>", { silent = true, desc = "Git preview hunk" })
	vim.keymap.set("n", "ghr", "<cmd>Gitsigns reset_hunk<CR>", { silent = true, desc = "Git reset hunk" })
	vim.keymap.set("n", "ghs", "<cmd>Gitsigns stage_hunk<CR>", { silent = true, desc = "Git stage hunk" })
	vim.keymap.set("n", "gbl", "<cmd>Gitsigns blame_line --full<CR>", { silent = true, desc = "Git blame line" })
	vim.keymap.set("n", "gbf", "<cmd>Gitsigns blame --full<CR>", { silent = true, desc = "Git blame file" })
	vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { silent = true, desc = "Previous git hunk" })
	vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { silent = true, desc = "Next git hunk" })
end

do -- guess-indent.nvim
	vim.pack.add({
		{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	})

	require("guess-indent").setup()
end

do -- hydra.nvim
	vim.pack.add({
		{ src = "https://github.com/nvimtools/hydra.nvim" },
	})

	local hydra = require("hydra")

	hydra.setup({
		invoke_on_body = true,
	})

	hydra({
		name = "Resize window",
		mode = "n",
		body = "<C-w>r",
		config = {
			hint = {
				type = "statusline",
			},
		},
		heads = {
			{ "<Left>", "<C-w><", { desc = "narrower" } },
			{ "<Right>", "<C-w>>", { desc = "wider" } },
			{ "<Up>", "<C-w>+", { desc = "taller" } },
			{ "<Down>", "<C-w>-", { desc = "shorter" } },
		},
	})
end

do -- lastplace.nvim
	vim.pack.add({
		{ src = "https://github.com/nxhung2304/lastplace.nvim" },
	})

	require("lastplace").setup()
end

do -- live-preview.nvim
	vim.pack.add({
		{ src = "https://github.com/brianhuster/live-preview.nvim" },
	})
end

do -- lsp_signature.nvim
	vim.pack.add({
		{ src = "https://github.com/ray-x/lsp_signature.nvim" },
	})

	require("lsp_signature").setup({
		hint_enable = false,
	})
end

do -- lspsaga.nvim
	vim.pack.add({
		{ src = "https://github.com/nvimdev/lspsaga.nvim" },
	})

	require("lspsaga").setup({
		lightbulb = {
			virtual_text = false,
		},
	})
end

do -- lualine.nvim
	vim.pack.add({
		{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	})

	require("lualine").setup({
		options = {
			section_separators = "",
			component_separators = "",
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "filename", path = 3 } },
			lualine_x = {
				"encoding",
				"fileformat",
				"filetype",
				"lsp_status",
				{
					function()
						return "󰊓 Z"
					end,
					cond = function()
						return vim.t["simple-zoom"] == "zoom"
					end,
				},
				{
					function()
						return "󰿇 SOPS"
					end,
					cond = function()
						return vim.b["sops"] == "d"
					end,
				},
				{
					function()
						return "󰍁 SOPS"
					end,
					cond = function()
						return vim.b["sops"] == "e"
					end,
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location", "searchcount", "selectioncount" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 3 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	})
end

do -- quicker.nvim
	vim.pack.add({
		{ src = "https://github.com/stevearc/quicker.nvim" },
	})

	require("quicker").setup({
		keys = {
			{ "<CR>", "<CR>", desc = "Open quickfix item" },
		},
	})
end

do -- rainbow-delimiters.nvim
	vim.pack.add({
		{ src = "https://github.com/hiphish/rainbow-delimiters.nvim" },
	})
end

do -- sidekick.nvim
	vim.pack.add({
		{ src = "https://github.com/folke/sidekick.nvim" },
	})

	require("sidekick").setup({
		nes = { enabled = false },
		cli = {
			mux = {
				enabled = true,
				backend = "tmux",
				create = "split",
			},
		},
		copilot = { status = { enabled = false } },
	})

	vim.keymap.set({ "n", "x" }, "ga", "<cmd>Sidekick cli prompt<CR>", { silent = true, desc = "Go ask AI" })
end

do -- simple-zoom.nvim
	vim.pack.add({
		{ src = "https://github.com/fasterius/simple-zoom.nvim" },
	})

	require("simple-zoom").setup({
		hide_tabline = true,
	})

	vim.keymap.set("n", "<C-w>z", "<cmd>SimpleZoomToggle<CR>", { silent = true, desc = "Zoom window" })
end

do -- neo-tree.nvim
	vim.pack.add({
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/MunifTanjim/nui.nvim" },
		{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	})

	require("neo-tree").setup({
		popup_border_style = "",
		default_component_configs = {
			indent = {
				highlight = "NonText",
				expander_highlight = "NonText",
			},
		},
		buffers = {
			show_unloaded = true,
		},
		filesystem = {
			-- TODO: is this needed?
			-- use_libuv_file_watcher = true,
			find_by_full_path_words = true,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			filtered_items = {
				force_visible_in_empty_folder = true,
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_ignored = false,
			},
		},
		window = {
			position = "float",
			mappings = {
				["C"] = "",
				["z"] = "",
				["w"] = "close_all_subnodes",
				["W"] = "close_all_nodes",
				["e"] = "expand_all_subnodes",
				["E"] = "expand_all_nodes",
			},
		},
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "NeoTreeDimText", { link = "NonText" })
		end,
	})

	vim.keymap.set("n", "<Space>", "<cmd>Neotree last dir=.<CR>", { silent = true, desc = "Explore neo tree" })
end

do -- nvim-autopairs
	vim.pack.add({
		{ src = "https://github.com/windwp/nvim-autopairs" },
	})

	require("nvim-autopairs").setup()
end

do -- nvim-early-retirement
	vim.pack.add({
		{ src = "https://github.com/chrisgrieser/nvim-early-retirement" },
	})

	require("early-retirement").setup({
		deleteBufferWhenFileDeleted = true,
	})
end

do -- nvim-lint
	vim.pack.add({
		{ src = "https://github.com/mfussenegger/nvim-lint" },
	})

	local lint = require("lint")

	lint.linters.shellcheck.args = { "--format", "json1", "-" }

	lint.linters_by_ft = {
		dockerfile = { "hadolint" },
		sh = { "shellcheck" },
	}

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
		callback = function()
			if vim.bo.modifiable then
				lint.try_lint()
			end
		end,
	})
end

do -- nvim-lspconfig
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
		extension = {
			service = "systemd",
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
		ruby_lsp = {},
		systemd_lsp = {},
		tsc = {
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
		zizmor = {},
	}

	for name, config in pairs(lsp) do
		vim.lsp.config(name, config)
	end
	vim.lsp.enable(vim.tbl_keys(lsp))
	-- vim.lsp.codelens.enable(true)
	-- vim.lsp.inlay_hint.enable(true)
	-- vim.lsp.inline_completion.enable(true)
end

do -- nvim-sops
	-- vim.cmd.packadd("nvim-sops")
	vim.pack.add({
		{ src = "https://github.com/dawidd6/nvim-sops" },
	})

	require("sops").setup()
end

do -- nvim-surround
	vim.pack.add({
		{ src = "https://github.com/kylechui/nvim-surround" },
	})

	require("nvim-surround").setup()

	vim.keymap.set("n", "s", "ys", { remap = true, silent = true })
	vim.keymap.set("x", "s", "S", { remap = true, silent = true })
end

do -- nvim-treesitter
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	})

	require("nvim-treesitter").install({
		"bash",
		"diff",
		"dockerfile",
		"fish",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"javascript",
		"json",
		"python",
		"ruby",
		"ssh_config",
		"toml",
		"typescript",
		"yaml",
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(event)
			local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
			if lang and vim.treesitter.language.add(lang) then
				vim.treesitter.start(event.buf, lang)
			end
		end,
	})

	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(event)
			if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
				require("nvim-treesitter").update()
			end
		end,
	})
end

do -- todo-comments.nvim
	vim.pack.add({
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/folke/todo-comments.nvim" },
	})

	require("todo-comments").setup()
end

do -- telescope.nvim
	vim.pack.add({
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
		{ src = "https://github.com/debugloop/telescope-undo.nvim" },
	})

	local telescope = require("telescope")
	local telescope_actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
			},
			mappings = {
				i = {
					["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
					["<C-Up>"] = telescope_actions.cycle_history_prev,
					["<C-Down>"] = telescope_actions.cycle_history_next,
				},
				n = {
					["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
					["<C-Up>"] = telescope_actions.cycle_history_prev,
					["<C-Down>"] = telescope_actions.cycle_history_next,
				},
			},
		},
		pickers = {
			buffers = {
				mappings = {
					i = {
						["<Del>"] = telescope_actions.delete_buffer,
					},
					n = {
						["<Del>"] = telescope_actions.delete_buffer,
					},
				},
			},
		},
		extensions = {
			["live_grep_args"] = {
				auto_quoting = true,
			},
			["ui-select"] = {
				previewer = require("telescope.previewers").new_buffer_previewer({
					define_preview = function(self, entry)
						local item = entry.value.text
						local text = type(item) == "table" and item.preview and item.preview.text or ""
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(text, "\n"))
					end,
				}),
			},
		},
	})

	require("telescope").load_extension("live_grep_args")
	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("todo-comments")
	require("telescope").load_extension("undo")

	vim.keymap.set(
		"n",
		"<Leader>/",
		"<cmd>Telescope current_buffer_fuzzy_find<CR>",
		{ silent = true, desc = "Search current buffer" }
	)
	vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope resume<CR>", { silent = true, desc = "Resume last search" })

	vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", { silent = true, desc = "Search open buffers" })
	vim.keymap.set(
		"n",
		"<Leader>d",
		"<cmd>Telescope diagnostics<CR>",
		{ silent = true, desc = "Search current diagnostics" }
	)
	vim.keymap.set(
		"n",
		"<Leader>f",
		"<cmd>Telescope find_files<CR>",
		{ silent = true, desc = "Search workspace files" }
	)
	vim.keymap.set("n", "<Leader>g", "<cmd>Telescope git_files<CR>", { silent = true, desc = "Search git files" })
	vim.keymap.set(
		"n",
		"<Leader>h",
		"<cmd>Telescope search_history<CR>",
		{ silent = true, desc = "Search searching history" }
	)
	vim.keymap.set("n", "<Leader>j", "<cmd>Telescope jumplist<CR>", { silent = true, desc = "Search jump list" })
	vim.keymap.set("n", "<Leader>o", "<cmd>Telescope oldfiles<CR>", { silent = true, desc = "Search old files" })
	vim.keymap.set(
		"n",
		"<Leader>r",
		"<cmd>Telescope registers<CR>",
		{ silent = true, desc = "Search clipboard registers" }
	)
	vim.keymap.set(
		"n",
		"<Leader>s",
		"<cmd>Telescope live_grep_args<CR>",
		{ silent = true, desc = "Search given string" }
	)
	vim.keymap.set(
		{ "n", "x" },
		"<Leader>w",
		"<cmd>Telescope grep_string<CR>",
		{ silent = true, desc = "Search selected word" }
	)
	vim.keymap.set(
		"n",
		"<Leader>t",
		"<cmd>Telescope todo-comments<CR>",
		{ silent = true, desc = "Search TODO comments" }
	)
	vim.keymap.set("n", "<Leader>u", "<cmd>Telescope undo<CR>", { silent = true, desc = "Search undo tree" })
end

do -- vscode.nvim
	vim.pack.add({
		{ src = "https://github.com/Mofiqul/vscode.nvim" },
	})

	require("vscode").setup()
	vim.cmd.colorscheme("vscode")
end

do -- which-key.nvim
	vim.pack.add({
		{ src = "https://github.com/folke/which-key.nvim" },
	})

	require("which-key").setup({
		preset = "helix",
		delay = 0,
		filter = function(mapping)
			return mapping.desc and mapping.desc ~= ""
		end,
		icons = {
			mappings = false,
		},
	})
end
