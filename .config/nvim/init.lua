do -- BASE PLUGINS
	vim.pack.add({ { src = "https://github.com/nvim-lua/plenary.nvim" } })
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })
end

do -- LSP PLUGINS
	vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })
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
end

do -- FORMAT PLUGINS
	vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
	require("conform").setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
		},
	})
end

do -- COMPLETION PLUGINS
	vim.pack.add({ { src = "https://github.com/RRethy/nvim-treesitter-endwise" } })
	-- no setup needed

	vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })
	require("which-key").setup({
		preset = "helix",
	})

	vim.pack.add({ { src = "https://github.com/altermo/ultimate-autopair.nvim" } })
	require("ultimate-autopair").setup()

	vim.pack.add({ { src = "https://github.com/saghen/blink.lib" } })
	vim.pack.add({ { src = "https://github.com/saghen/blink.cmp" } })
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
		},
	})
end

do -- EDITOR PLUGINS
	vim.pack.add({ { src = "https://github.com/folke/todo-comments.nvim" } })
	require("todo-comments").setup()

	vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })
	require("guess-indent").setup()

	vim.pack.add({ { src = "https://github.com/johnfrankmorgan/whitespace.nvim" } })
	require("whitespace-nvim").setup()
end

do -- EXPLORER PLUGINS
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })
	require("nvim-tree").setup()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

do -- ANIMATION PLUGINS
	vim.pack.add({ { src = "https://github.com/karb94/neoscroll.nvim" } })
	require("neoscroll").setup()

	vim.pack.add({ { src = "https://github.com/sphamba/smear-cursor.nvim" } })
	require("smear_cursor").setup()
end

do -- STATUS PLUGINS
	vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })
	require("bufferline").setup()

	vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })
	require("lualine").setup()
end

do -- THEME PLUGINS
	vim.pack.add({ { src = "https://github.com/Mofiqul/vscode.nvim" } })
	require("vscode").setup()
	vim.cmd.colorscheme("vscode")
end

do -- PICKER PLUGINS
	vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
	require("telescope").setup()
end

do -- SCM PLUGINS
	vim.pack.add({ { src = "https://github.com/trevorhauter/gitportal.nvim" } })
	require("gitportal").setup()

	vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })
	require("gitsigns").setup()

	vim.pack.add({ { src = "https://github.com/akinsho/git-conflict.nvim" } })
	require("git-conflict").setup()
end

do -- COMMANDS
	vim.api.nvim_create_user_command("RelPath", function()
		local path = vim.fn.expand("%")
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Print and copy relative file path" })

	vim.api.nvim_create_user_command("AbsPath", function()
		local path = vim.fn.expand("%:p")
		vim.fn.setreg("+", path)
		vim.notify(path)
	end, { desc = "Print and copy absolute file path" })

	vim.api.nvim_create_user_command("RootPath", function()
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
end

do -- AUTOCOMMANDS
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.cmd.wincmd("L")
		end,
		pattern = "help",
		group = vim.api.nvim_create_augroup("vertical-help", { clear = true }),
		desc = "Open help in vertical split window",
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
end

do -- FILETYPES
	vim.filetype.add({
		pattern = {
			[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
			[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
			[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
		},
	})
end

do -- OPTIONS
	vim.o.autoindent = true
	vim.o.confirm = true
	vim.o.cursorline = true
	vim.o.expandtab = true
	vim.o.ignorecase = true
	vim.o.inccommand = "split"
	vim.o.number = true
	vim.o.relativenumber = true
	vim.o.scrolloff = 10
	vim.o.shiftwidth = 4
	vim.o.showmode = false
	vim.o.signcolumn = "yes"
	vim.o.smartcase = true
	vim.o.smartindent = true
	vim.o.splitright = true
	vim.o.splitbelow = true
	vim.o.swapfile = false
	vim.o.tabstop = 4
	vim.o.termguicolors = true
	vim.o.timeoutlen = 300
	vim.o.undofile = true
	vim.o.updatetime = 250
	vim.o.writebackup = false
end

do -- KEYMAPS
	vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Cut character without yanking" })
	vim.keymap.set({ "n", "v" }, "X", '"_X', { desc = "Cut character without yanking" })

	vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })
	vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

	vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Disable search highlight" })
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit to normal mode easier in terminal" })

	vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
	vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
end

do -- LEADER KEYMAPS
	vim.keymap.set("n", "<Leader>e", ":NvimTreeFocus<CR>", { desc = "Focus file tree explorer" })
	vim.keymap.set("n", "<Leader>E", ":NvimTreeClose<CR>", { desc = "Close file tree explorer" })

	vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>", { desc = "Search buffers" })
	vim.keymap.set("n", "<Leader>c", ":Telescope commands<CR>", { desc = "Search commands" })
	vim.keymap.set("n", "<Leader>d", ":Telescope diagnostics<CR>", { desc = "Search diagnostics" })
	vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>", { desc = "Search files" })
	vim.keymap.set("n", "<Leader>h", ":Telescope help_tags<CR>", { desc = "Search help" })
	vim.keymap.set("n", "<Leader>j", ":Telescope jumplist<CR>", { desc = "Search jumps" })
	vim.keymap.set("n", "<Leader>k", ":Telescope keymaps<CR>", { desc = "Search keymaps" })
	vim.keymap.set("n", "<Leader>s", ":Telescope live_grep<CR>", { desc = "Search string" })

	vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
	vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard" })

	vim.keymap.set("n", "<Leader>x", ":bwipeout<CR>", { desc = "Delete buffer" })
end
