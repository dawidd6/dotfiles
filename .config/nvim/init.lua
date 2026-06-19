do -- BASE PLUGINS --
	-- Plugin for useful functions
	vim.pack.add({ { src = "https://github.com/nvim-lua/plenary.nvim" } })
	-- Plugin for nice icons
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })
end

do -- CODING PLUGINS --
	-- Plugin for LSP configs
	vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })
	vim.lsp.enable({
		"ansiblels",
		"bashls",
		"lua_ls",
		"yamlls",
	})
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },
		virtual_text = true, -- Text shows up at the end of the line
		virtual_lines = false, -- Text shows up underneath the line, with virtual lines
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
	-- Plugin for formatting
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

do -- COMPLETING PLUGINS --
	-- Plugin for showing next keys
	vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })
	require("which-key").setup()
	-- Plugin for completion
	vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })
	require("blink.cmp").setup({
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

do -- EDITING PLUGINS --
	-- Plugin for highlighting special comments
	vim.pack.add({ { src = "https://github.com/folke/todo-comments.nvim" } })
	require("todo-comments").setup()
	-- Plugin for guessing indentation
	vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })
	require("guess-indent").setup()
	-- Plugin for handling whitespace
	vim.pack.add({ { src = "https://github.com/johnfrankmorgan/whitespace.nvim" } })
	require("whitespace-nvim").setup()
	-- Plugin for auto pairing
	vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" } })
	require("nvim-autopairs").setup()
end

do -- EXPLORING PLUGINS --
	-- Plugin for file tree/explorer
	vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })
	require("nvim-tree").setup()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
end

do -- LOOKING PLUGINS --
	-- Plugin for smooth scrolling
	vim.pack.add({ { src = "https://github.com/karb94/neoscroll.nvim" } })
	require("neoscroll").setup()
	-- Plugin for cursor animation
	vim.pack.add({ { src = "https://github.com/sphamba/smear-cursor.nvim" } })
	require("smear_cursor").setup()
	-- Plugin for buffer line
	vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })
	require("bufferline").setup()
	-- Plugin for status line
	vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })
	require("lualine").setup()
	-- Plugin for theme/colorcheme
	vim.pack.add({ { src = "https://github.com/Mofiqul/vscode.nvim" } })
	require("vscode").setup()
	vim.cmd.colorscheme("vscode")
end

do -- PICKING PLUGINS --
	-- Plugin for picking stuff
	vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
	require("telescope").setup()
end

do -- VERSIONING PLUGINS --
	-- Plugin for opening git objects in web browser
	vim.pack.add({ { src = "https://github.com/trevorhauter/gitportal.nvim" } })
	require("gitportal").setup()
	-- Plugin for git integration
	vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })
	require("gitsigns").setup()
	-- Plugin for git conflicts handling
	vim.pack.add({ { src = "https://github.com/akinsho/git-conflict.nvim" } })
	require("git-conflict").setup()
end

do -- COMMANDS --
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
end

do -- AUTOCOMMANDS --
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
				relative = "editor",
				border = "rounded",
				width = vim.o.columns,
				height = vim.o.lines,
				row = 0,
				col = 0,
			})
		end,
		pattern = "help",
		group = vim.api.nvim_create_augroup("floating-help", { clear = true }),
		desc = "Open help in a floating window",
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
end

do -- FILETYPES --
	vim.filetype.add({
		pattern = {
			[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
			[".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
			[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
		},
	})
end

do -- OPTIONS --
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

do -- KEYMAPS --
	vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Cut character without yanking" })
	vim.keymap.set({ "n", "v" }, "X", '"_X', { desc = "Cut character without yanking" })
	vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })
	vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
	vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Disable search highlight" })
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit to normal mode easier in terminal" })
	vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
	vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

	vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

	vim.keymap.set("n", "<Leader>ec", ":NvimTreeClose<CR>", { desc = "Close file tree explorer" })
	vim.keymap.set("n", "<Leader>ef", ":NvimTreeFocus<CR>", { desc = "Focus file tree explorer" })

	vim.keymap.set("n", "<Leader>sb", ":Telescope buffers<CR>", { desc = "Search buffers" })
	vim.keymap.set("n", "<Leader>sc", ":Telescope commands<CR>", { desc = "Search commands" })
	vim.keymap.set("n", "<Leader>sd", ":Telescope diagnostics<CR>", { desc = "Search diagnostics" })
	vim.keymap.set("n", "<Leader>sf", ":Telescope find_files<CR>", { desc = "Search files" })
	vim.keymap.set("n", "<Leader>sh", ":Telescope help_tags<CR>", { desc = "Search help" })
	vim.keymap.set("n", "<Leader>sk", ":Telescope keymaps<CR>", { desc = "Search keymaps" })
	vim.keymap.set("n", "<Leader>ss", ":Telescope live_grep<CR>", { desc = "Search string" })

	vim.keymap.set("n", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
	vim.keymap.set("n", "<Leader>p", '"+p', { desc = "Paste from system clipboard" })
end
