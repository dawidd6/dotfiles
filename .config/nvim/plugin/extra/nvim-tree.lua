vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

local nvim_tree = require("nvim-tree")
local nvim_tree_api = require("nvim-tree.api")
local nvim_tree_utils = require("nvim-tree.utils")

nvim_tree.setup({
	update_focused_file = {
		enable = true,
	},
	view = {
		float = {
			enable = true,
			open_win_config = function()
				return {
					relative = "editor",
					row = 0,
					col = 0,
					width = vim.o.columns,
					height = vim.o.lines - vim.o.cmdheight,
					border = "none",
				}
			end,
		},
	},
	on_attach = function(bufnr)
		nvim_tree_api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "o", function()
			nvim_tree_api.node.open.edit(nil, { focus = true })
		end, { desc = "nvim-tree: Open No Focus", buffer = bufnr, noremap = true, silent = true, nowait = true })

		vim.keymap.set("x", "o", function()
			local nodes = nvim_tree_utils.get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					nvim_tree_api.node.open.edit(node, { focus = true })
				end
			end
		end, {
			desc = "nvim-tree: Open No Focus Selected Files",
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		})

		vim.keymap.set("x", "<CR>", function()
			local nodes = nvim_tree_utils.get_visual_nodes() or {}
			for _, node in ipairs(nodes) do
				if node.type == "file" or node.type == "link" then
					nvim_tree_api.node.open.edit(node)
				end
			end
		end, { desc = "nvim-tree: Open Selected Files", buffer = bufnr, noremap = true, silent = true, nowait = true })
	end,
})

vim.keymap.set("n", "<Leader>e", function()
	nvim_tree_api.tree.open()
end, { silent = true, desc = "Open file explorer" })
