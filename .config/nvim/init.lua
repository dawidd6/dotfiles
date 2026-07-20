vim.loader.enable()

local function require_all(directory)
	for _, file in
		ipairs(vim.fn.glob(string.format("%s/lua/%s/*.lua", vim.fn.stdpath("config"), directory), true, true))
	do
		require(string.format("%s.%s", directory, vim.fn.fnamemodify(file, ":t:r")))
	end
end

require_all("core")

if vim.g.vscode then
	require("extra.autopairs")
	require("extra.surround")
else
	require("vim._core.ui2").enable()
	require_all("extra")
end
