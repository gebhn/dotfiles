function _G.Find(cmdarg, _)
	local files = vim.fn.globpath('.', '**/*', false, true)
	if #cmdarg == 0 then
		return files
	else
		return vim.fn.matchfuzzy(files, cmdarg)
	end
end

vim.o.findfunc = 'v:lua.Find'
