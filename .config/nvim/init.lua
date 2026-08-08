vim.loader.enable()

local function require_all(directory)
	for _, file in
		ipairs(vim.fn.glob(string.format("%s/lua/%s/*.lua", vim.fn.stdpath("config"), directory), true, true))
	do
		require(string.format("%s.%s", directory, vim.fn.fnamemodify(file, ":t:r")))
	end
end

-- TODO: move files to plugin/ dir?
require("vim._core.ui2").enable()
require_all("core")
require_all("extra")
