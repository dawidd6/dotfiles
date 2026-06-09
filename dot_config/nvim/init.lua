-- Plugin for nice icons
vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-web-devicons" } })

-- Plugin for handling whitespace
vim.pack.add({ { src = "https://github.com/johnfrankmorgan/whitespace.nvim" } })
require("whitespace-nvim").setup()

-- Plugin for highlighting special comments
vim.pack.add({ { src = "https://github.com/folke/todo-comments.nvim" } })
require("todo-comments").setup()

-- Plugin for buffer line
vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })
require("bufferline").setup()

-- Plugin for status line
vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })
require("lualine").setup()

-- Plugin for git integration
vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })
require("gitsigns").setup()

-- Plugin for git conflicts handling
vim.pack.add({ { src = "https://github.com/akinsho/git-conflict.nvim" } })
require("git-conflict").setup()

-- Plugin for guessing indentation
vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })
require("guess-indent").setup()

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

-- Plugin for theme/colorcheme
vim.pack.add({ { src = "https://github.com/Mofiqul/vscode.nvim" } })
require("vscode").setup()
vim.cmd.colorscheme("vscode")

-- Keymaps
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "X", '"_X')
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", ",", ":bprevious<CR>")
vim.keymap.set("n", ".", ":bnext<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- Options
vim.o.autoindent = true
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.undofile = true
vim.o.writebackup = false

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
