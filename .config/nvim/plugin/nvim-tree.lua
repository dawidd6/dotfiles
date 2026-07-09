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
		width = 50,
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

nvim_tree_api.events.subscribe(nvim_tree_api.events.Event.TreeOpen, function()
	if vim.t["filetree_width"] ~= nil then
		local winid = nvim_tree_api.tree.winid()
		vim.api.nvim_win_set_width(winid, vim.t["filetree_width"])
	end
end)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "grug-far",
	callback = function()
		if nvim_tree_api.tree.is_visible() then
			nvim_tree_api.tree.close()
		end
	end,
	desc = "Keep file explorer and search and replace sidebars exclusive",
})

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

vim.keymap.set("n", "<Leader>ee", function()
	nvim_tree_api.tree.open()
end, { desc = "Open file explorer" })
vim.keymap.set("n", "<Leader>ec", function()
	nvim_tree_api.tree.close()
end, { desc = "Close file explorer" })
