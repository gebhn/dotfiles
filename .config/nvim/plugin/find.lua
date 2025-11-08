function _G.Find(cmdarg, _)
	local files = vim.fn.globpath('.', '**/*', false, true)
	return #cmdarg == 0 and files or vim.fn.matchfuzzy(files, cmdarg)
end

vim.o.findfunc = 'v:lua.Find'
