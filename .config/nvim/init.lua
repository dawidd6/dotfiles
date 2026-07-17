vim.loader.enable()

vim.cmd("runtime! lua/core/*.lua")

if vim.g.vscode then
	vim.cmd("runtime! lua/plugin/nvim-surround.lua")
else
	vim.cmd("runtime! lua/plugin/*.lua")
end
