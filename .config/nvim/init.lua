vim.loader.enable()

vim.cmd("runtime! lua/core/*.lua")

if vim.g.vscode then
	vim.cmd("runtime! lua/extra/autopairs.lua")
	vim.cmd("runtime! lua/extra/surround.lua")
else
	vim.cmd("runtime! lua/extra/*.lua")
end
