local function scan_dir(path, result)
	result = result or {}
	for _, name in ipairs(vim.fn.readdir(path)) do
		local full = path .. '/' .. name
		if vim.fn.isdirectory(full) == 1 then
			if name ~= '.git' then
				scan_dir(full, result)
			end
		else
			table.insert(result, full)
		end
	end
	return result
end

function _G.Find(cmdarg, _)
	local files = scan_dir(vim.fn.getcwd())

	if #cmdarg == 0 then
		return files
	else
		return vim.fn.matchfuzzy(files, cmdarg)
	end
end

vim.o.findfunc = 'v:lua.Find'
